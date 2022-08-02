local Renderable = require "obj.Renderable"
local Collider = require "obj.Collider"

local bump = require "lib.bump"

local world = bump.newWorld()
local Blorps = {} -- DEBUG ONLY BRUH

function love.load()
end

function love.update(dt)
end

function love.draw()
  for i,object in ipairs(Blorps) do
    object:render()
    
    love.graphics.print(object.name..", "..object.collider.name.."\nx: "..object.x.."\ny: "..object.y,100,50*i)
  end
end

function love.mousepressed(x,y)
  local len = #Blorps + 1
  local newR = Renderable:new("R"..tostring(len),x-50,y-50,100,100,nil,{255,255/len,0},"line")
  local newC = Collider:new("C"..tostring(len),newR.x,newR.y,newR.w,newR.h,"touch",world)
  newR:attachCollider(newC)
  Blorps[#Blorps + 1] = newR
end

function love.keypressed(key)
  
end