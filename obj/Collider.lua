local class = require "lib.middleclass"
local Enum = require "data.enum"

local GameObject = require "obj.GameObject"
local Collider = GameObject:subclass("Collider")

function Collider:initialize(name,x,y,w,h,world,colType)
  GameObject.initialize(self,name,x,y,w,h,"Collider")
  self.world = world
  -- Basic system for handling collisions partially taken from s&box's physics.
  -- Every Collider has a collision type that dictates what objects collide with it and what objects don't,
  -- and the Collider's colGroups takes care of what it wants to collide with.
  -- Collision groups of an object are exclusive to THAT object, and are not shared or inherited
  -- between any other Colliders. These settings are also not global, but I may or may not
  -- implement a system for global collision groups in the future.
  --
  -- In the case of a conflict between collisions; for example, a "player"-type Collider chooses not to
  -- collide with a "particle"-type Collider, but the "particle"-type Collider's collision group states that
  -- it collides with "player"-type Colliders (in this case directly opposing collision rules) the collision rule
  -- that gets chosen when making a decision about whether or not to collide is the type with the highest priority.
  -- Priorities are, from highest to lowest:
  -- Player, World, Particle, Background
  -- This may change as more collision types are added as seen fit.
  --
  -- The collision types are relatively straightforward, but here are their explanations if you're stupid:
  -- Player: This is the player.
  -- World: Stuff like walls, floors, and backgrounds.
  -- Particle: Particles. Explosions and sparks and stuff. Probably won't be a part of the game since it's too difficult to implement.
  -- Background: Background stuff. Clouds, foliage, etc. Stuff that's meant for decoration.
  --
  -- This system really shouldn't be that complicated but making simple things vexing is my specialty.
  self.colType = colType
  self.colGroups = {
    -- Collisions are set to zero by default and are modified manually
      0,
      0,
      0,
      0
  }
  self.defaultCollision = "slide"
  print(self.colGroups[Enum.CollisionType.World])
  
  self.world:add(self,x,y,w,h)
  self:move(x,y) -- If placed inside another object, move away from it
end

local filter = function(item,other)
  if item.colGroups[other.colType] then return item.defaultCollision
  else return "cross" end
end

function Collider:move(gx,gy)
  local ax, ay, cols, len = self.world:move(self,gx,gy,filter)
  self.x = ax
  self.y = ay
  if self.components.renderable ~= nil then
    self.components.renderable:move(ax,ay)
  end
  return cols
end

function Collider:update(gx,gy)
  self.world:update(self,gx,gy)
  if self.renderable ~= nil then
    self.renderable:move(gx,gy)
  end
end

function Collider:destroy()
  self.world:remove(self)
end

return Collider