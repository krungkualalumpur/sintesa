--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
--modules
local Lists = require(script.Parent)
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent.Parent:WaitForChild("Icons"))

local Checkbox = require(script.Parent.Parent:WaitForChild("Checkbox"):WaitForChild("Checkbox"))
local Switch  = require(script.Parent.Parent:WaitForChild("Switch"))
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

   
    local lists = {

    }
    for i = 1, 10 do
      local isKodekoSelected = _Value(false :: boolean?)
      local isUMNOSelected = _Value(false :: boolean)
      local isAryaSelected = _Value(false :: boolean?)

         table.insert(lists, Types.createFusionListInstance(
            'kodeko', 
            'support 123 this not bad', 
            nil,--"100+", 
            Checkbox.ColdFusion.new(maid, isKodekoSelected, function()
               isKodekoSelected:Set(not isKodekoSelected:Get())
            end, false),--Icons.navigation.arrow_drop_down, 
            nil, 
            Icons.social.person,
            true
         ))
         table.insert(lists, Types.createFusionListInstance(
            'UMNO', 
            'support untuak PERSATUAN!', 
            nil,--"100+", 
            Switch.ColdFusion.new(maid, isUMNOSelected, _Value(false), function()
               isUMNOSelected:Set(not isUMNOSelected:Get())
            end),--Icons.navigation.arrow_drop_down,
            nil, 
            Icons.maps.add_business,
            true
         ))
         table.insert(lists, Types.createFusionListInstance(
            'Aryaa', 
            'support Ary untuk kemenangan Karyo!!', 
            nil,--"100+", 
            Checkbox.ColdFusion.new(maid, isAryaSelected, function()
               isAryaSelected:Set(not isAryaSelected:Get())
            end, false),--Icons.navigation.arrow_drop_down,
            "A", 
            nil,
            true
         ))
    end
    local length = _Value(450)
    local out = Lists.ColdFusion.new(maid, false,true, lists, length) 
    out.Position = UDim2.fromOffset(0,0)
   _new("Frame")({
      Size = UDim2.fromScale(1, 1),
      BackgroundTransparency = 1,
      Parent = target,
      Children = {
         _new("UIPadding")({
            PaddingTop = UDim.new(0,10),
            PaddingBottom = UDim.new(0,10),
            PaddingLeft = UDim.new(0,10),
            PaddingRight = UDim.new(0,10),

         }),
         out
      }
   })

   return function()
      maid:Destroy()
   end
end