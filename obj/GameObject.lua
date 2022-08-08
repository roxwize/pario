local class = require "lib.middleclass"

local GameObject = class("GameObject")

function GameObject:initialize(name,x,y,w,h,objtype)
  self.name = name
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.objtype = objtype
  self.components = {}
end

function GameObject:attachComponent(component,r) -- "r" is just a bodge to prevent stack overflows
  if component.objtype == "Collider" then
    if self.components.collider then return error("GameObjects can only have one Collider",2) end
    self.components.collider = component
  elseif component.objtype == "Renderable" then
    if self.components.renderable then return error("GameObjects can only have one Renderable",2) end
    self.components.renderable = component
    self.components.collider = self
  end
  if r == 0 then component:attachComponent(self,1) end
end

return GameObject