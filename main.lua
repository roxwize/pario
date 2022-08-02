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
    
    --love.graphics.print(object.name..", "..object.collider.name.."\nx: "..object.x.."\ny: "..object.y,100,50*i)
  end
end

function love.mousepressed(x,y)
  local len = #objects + 1
  local newR = Renderable:new("wallrenderer",x-50,y-50,100,100,nil,{255,255,0},"line")
  local newC = Collider:new("wall",newR.x,newR.y,newR.w,newR.h,world)
  newR:attachCollider(newC)
  objects[len] = newR
end

function love.keypressed(key)
  
end