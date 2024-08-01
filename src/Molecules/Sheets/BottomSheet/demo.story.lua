--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
local BottomSheet = require(script.Parent)
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

    local out = BottomSheet.ColdFusion.new(maid, false,{
      _new("UIListLayout")({
         FillDirection = Enum.FillDirection.Vertical
      }),
      _new("Frame")({
         --BackgroundColor3 = Color3.fromRGB(255,0,0),
         Size = UDim2.new(0.5, 0,0,120)
      })
    }) 
    out.Parent = target

   return function()
      maid:Destroy()
   end
end