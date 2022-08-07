local Renderable = require "obj.Renderable"
local Collider = require "obj.Collider"

local bump = require "lib.bump"

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
    if object.components.collider then list = list..object.components.collider.name end
    love.graphics.print(list,0,i*30)
  end
end

function love.mousepressed(x,y)
  local len = #objects + 1
  local newR = Renderable:new("wallrenderer",x-50,y-50,100,100,nil,{255,255,0},"line")
  local newC = Collider:new("wall",newR.x,newR.y,newR.w,newR.h,world)
  newR:attachComponent(newC,0)
  newC:move(newC.x,newC.y)
  objects[len] = newR
end

function love.keypressed(key)
  
end