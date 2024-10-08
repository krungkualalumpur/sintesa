--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
local ProgressIndicator = require(script.Parent)
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
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local progress = _Value(0.3)
    local out = ProgressIndicator.ColdFusion.new(maid, false, progress) 
    out.Position = UDim2.fromScale(0.5,0.5)
    print(out)
   _new("Frame")({
      Size = UDim2.fromScale(1, 1),
      Parent = target,
      Children = {
         out
      }
   })

   spawn(function()
      for i = 1, 3, 0.1 do 
         wait()
         progress:Set(i/3)
      end
   end)

   return function()
      maid:Destroy()
   end
end