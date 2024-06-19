--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
local TopAppBar = require(script.Parent)
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

    local out = TopAppBar.ColdFusion.new(maid, false, {
        _new("Frame")({
            Size = UDim2.fromScale(0.2, 1),
            BackgroundColor3 = Color3.fromRGB(255,255,0)
        }) ,
        _new("Frame")({
            Size = UDim2.fromScale(0.2, 1),
            BackgroundColor3 = Color3.fromRGB(255,255,0)
        }) 
    })
    out.Size = UDim2.fromScale(0.25, 0.25)
    out.Parent = target

    
    return function()
        maid:Destroy()
    end
end