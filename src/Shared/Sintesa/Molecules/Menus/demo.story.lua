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
    for i = 1, 3 do
         table.insert(lists, {LeadingIcon = Icons.action.sticky_note_2, Name = "Surya", TrailingIcon = Icons.action.abc, TrailingSupportingText = "G"})
         table.insert(lists, {Name = "Bedu", HasDividor = true})

    end
    local out = Lists.ColdFusion.new(maid, false,true, lists,  function(menu)
      print("menu ", menu.Name)
   end, 250) 
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