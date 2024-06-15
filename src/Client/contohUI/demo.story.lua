--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
local Contoh = require(script.Parent)
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
   local out = Contoh(maid)
   out.Parent = target
   return function()
      maid:Destroy()
   end
end