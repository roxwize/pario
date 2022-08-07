local class = require "lib.middleclass"

local GameObject = require "obj.GameObject"
local Renderable = GameObject:subclass("Renderable")

function Renderable:initialize(name,x,y,w,h,img,color,ftype)
  GameObject.initialize(self,name,x,y,w,h,"Renderable")
  self.img = img
  self.color = color
  self.ftype = ftype
end

function Renderable:move(x,y)
  if self.collider then -- NEver runs . . FIx DIS
    print("Controls")
    --self.collider:move(x,y)
    --self:move(self.collider.x,self.collider.y)
  else
    self.x = x
    self.y = y
  end
end

function Renderable:render()
  if self.img == nil then
    love.graphics.push()
    love.graphics.setColor(self.color)
    love.graphics.rectangle(self.ftype,self.x,self.y,self.w,self.h)
    love.graphics.pop()
  else
    love.graphics.draw(self.img,self.x,self.y)
  end
end

--function Renderable:attachComponent(component)
  --GameObject.attachComponent(self,component)
--end

return Renderable