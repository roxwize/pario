-- This is a GameObject that basically just combines Colliders and Renderables, reducing three lines of code into one
local class = require "lib.middleclass"

local GameObject = require "obj.GameObject"
local Collider = require "obj.Collider"
local Renderable = require "obj.Renderable"

local Box = GameObject:subclass("Box")

function Box:initialize(name,x,y,w,h,world,coltype,img,color,ftype)
  GameObject.initialize(self,name,x,y,w,h,"Box")
  self.col = Collider:new(name,x,y,w,h,world,coltype)
  self.ren = Renderable:new(name,x,y,w,h,img,color,ftype)
  self.col:attachComponent(self.ren,0)
  
  self:move(self.x,self.y)
end

function Box:render()
  self.ren:render()
end

function Box:move(gx,gy)
  self.col:move(gx,gy)
end

return Box