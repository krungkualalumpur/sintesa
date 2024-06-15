--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
--modules
--types
type Maid = Maid.Maid
--constants
--remotes
--variables
--references
--local functions
--class
return function(maid : Maid)
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
    local out = (_new("Frame")({
        Name = "Test",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(255,0,0),
        Children = {
            _new("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Bottom
            }),
            _new("TextLabel")({
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(0.1, 0.65),
                Text = "eh",
               
                BackgroundColor3 = Color3.fromRGB(122, 94, 57),
                Children = {
                    _new("Frame")({
                        Size = UDim2.fromScale(0.2, 0.2),
                        Rotation = 35,
                    })
                }
            })
        }
    })
    )
    return out
end