local class = require "lib.middleclass"

local GameObject = require "obj.GameObject"
local Renderable = GameObject:subclass("Renderable")

function Renderable:initialize(name,x,y,w,h,img,color,ftype)
  GameObject.initialize(self,name,x,y,w,h)
  self.img = img
  self.color = color
  self.ftype = ftype
end

function Renderable:move(x,y)
  self.x = x
  self.y = y
end

function Renderable:render()
  if not img then
    love.graphics.setColor(self.color)
    love.graphics.rectangle(self.ftype,self.x,self.y,self.w,self.h)
  end
end

function Renderable:attachCollider(collider)
  self.collider = collider
  self.collider:attachRenderable(self)
  self:move(collider.x,collider.y)
end

return Renderable