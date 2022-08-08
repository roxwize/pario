local Renderable = require "obj.Renderable"
local Collider = require "obj.Collider"
local Box = require "obj.Box"

local bump = require "lib.bump"
local Enum = require "data.enum"

local world = bump.newWorld()
local objects = {}

function love.load()
  local pario = love.graphics.newImage("data/pario.jpg")
  table.insert(objects,Renderable:new("pario",400,300,120,120,pario,nil,nil))
end

function love.update(dt)
end

function love.draw()
  for i,object in ipairs(objects) do
    object:render()
    local list = object.name.."\n"
    for _,component in pairs(object.components) do
      list = list..component.name
    end
    love.graphics.print(list,0,i*30)
  end
end

function love.mousepressed(x,y)
  local len = #objects + 1
  local newObj = Box:new("wall",x-50,y-50,100,100,world,Enum.CollisionType.World,nil,{255,255,0},"line")
--local newR = Renderable:new("wallrenderer",x-50,y-50,100,100,nil,{255,255,0},"line")
--local newC = Collider:new("wall",newR.x,newR.y,newR.w,newR.h,world,"World")
--newC.colGroups.World = 1
--newR:attachComponent(newC,0)
--newC:move(newC.x,newC.y)
  objects[len] = newObj
end

function love.keypressed(key)
  
end