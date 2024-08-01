--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
--modules
local Suggestion = require(script.Parent)
local Icons = require(script.Parent.Parent.Parent.Parent:WaitForChild("Icons"))
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
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local selected = _Value(false)
    local isError = _Value(false)
    local out = Suggestion.ColdFusion.new(maid, "Suggestion Chip", function()  

    end, false, selected, Icons.image.image, Icons.navigation.close)
    out.Parent = target
    
   _new("Frame")({
      Size = UDim2.fromScale(1, 1),
      Parent = target,
      Children = {
         out
      }
   })

   return function()
      maid:Destroy()
   end
end