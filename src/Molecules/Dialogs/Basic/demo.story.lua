--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
local BasicDialogs = require(script.Parent)
--modules
local CustomEnums = require(script.Parent.Parent.Parent.Parent:WaitForChild("Enums"))
local Types = require(script.Parent.Parent.Parent.Parent:WaitForChild("Types"))
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

   local out = BasicDialogs.ColdFusion.new( 
      maid,
      _Value(false),

      "Warning",
      "You have exceeded the limit of purchasing",

      {
         Types.createFusionButtonData("Got it!", 0),
      },
      function(buttonData)  
         print(`{buttonData.Name} clicked`)
      end,
      Types.createFusionButtonData("", Icons.navigation.refresh),
      function()  
      
      end
   ) 
   out.Position = UDim2.fromScale(0.5,0.5)
   out.Parent = target

   return function()
   maid:Destroy()
   end
end