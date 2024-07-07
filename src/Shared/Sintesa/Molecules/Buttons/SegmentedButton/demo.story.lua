--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
--modules
local SegmentedButton = require(script.Parent)
local Types = require(script.Parent.Parent.Parent.Parent:WaitForChild("Types"))
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
      Types.createFusionButtonData("Button1",  0, _Value(true)),
      Types.createFusionButtonData("Button2", 0, _Value(false)),
      Types.createFusionButtonData("Button3",  0, _Value(false)),
   }

   local out = SegmentedButton.ColdFusion.new(maid, buttons :: {[number] : Types.ButtonData}, isDark, function(buttonData) 
      print((buttonData.Name or "") .. " clickedkos!")
      if buttonData.Selected then buttonData.Selected:Set(not buttonData.Selected:Get()) end
   end)
   out.Position = UDim2.fromScale(0, 0.25)
   out.Size = UDim2.fromScale(1, 1)
   out.Parent = target

   return function() 
      maid:Destroy()
   end
end