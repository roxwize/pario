local class = require "lib.middleclass"

local GameObject = class("GameObject")

function GameObject:initialize(name,x,y,w,h)
  self.name = name
  self.x = x
  self.y = y
  self.w = w
  self.h = h
end

return GameObject