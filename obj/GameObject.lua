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

function GameObject:attachComponent(component)
  print("Ok I Do")
  print(component.name)
  print(self.name)
  table.insert(self.components,component)
  table.insert(component.components,self)
  print(self.components[1])
  if component.objtype == "Collider" then
    if self.collider then return error("GameObjects can only have one Collider",2) end
    self.collider = component
  elseif component.objtype == "Renderable" then
    if self.renderable then return error("GameObjects can only have one Renderable",2) end
    self.renderable = component
  end
end

return GameObject