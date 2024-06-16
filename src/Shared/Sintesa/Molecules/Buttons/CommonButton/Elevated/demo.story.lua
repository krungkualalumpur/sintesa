--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
local Elevated = require(script.Parent)
--modules
--types
--constants
--remotes
--variables
--references
--local functions 
--class
return function(target : CoreGui) 
   local maid = Maid.new()
   local _fuse = ColdFusion.fuse(maid)
   local _Value = _fuse.Value
   local out = Elevated.ColdFusion.new(maid, "Test")
   out.Size = UDim2.fromScale(0.25, 0.25)
   out.Parent = target
   return function()
      maid:Destroy()
   end
end