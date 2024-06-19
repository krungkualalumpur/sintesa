--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
local SegmentedButton = require(script.Parent)
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

   local isDark = _Value(false)
   local buttons = {
      {
         Name = "Button1",
         Selected = _Value(true)
      },
      {
         Name = "Button2",
         Selected = _Value(false)
      },
      {
         Name = "Button3",
         Selected = _Value(false)
      },
   }

   local out = SegmentedButton.ColdFusion.new(maid, buttons, isDark, function(buttonData) 
      print(buttonData.Name .. " clicked!")
      buttonData.Selected:Set(not buttonData.Selected:Get())
   end)
   out.Position = UDim2.fromScale(0, 0.25)
   out.Size = UDim2.fromScale(1, 1)
   out.Parent = target

   return function() 
      maid:Destroy()
   end
end