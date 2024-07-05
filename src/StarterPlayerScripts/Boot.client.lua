--!strict
--services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--packages
local ColdFusion = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("ColdFusion8"))
local Maid = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Maid"))
--modules
local types = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Sintesa"):WaitForChild("Types"))
local ViewportFrame = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Sintesa"):WaitForChild("Molecules"):WaitForChild("Util"):WaitForChild("ViewportFrame"))
--types
--constants
--remotes
--variables
--references
--local functions
--class
local maid = Maid.new()
local _fuse = ColdFusion.fuse(maid)
local _new = _fuse.new
local _import = _fuse.import
local _bind = _fuse.bind
local _clone = _fuse.clone
local _Computed = _fuse.Computed
local _Value = _fuse.Value

local target = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")
local out = ViewportFrame.ColdFusion.new(maid, _new("Part")({Size = Vector3.new(4,4,4)}), 200, false)

out.Position = UDim2.fromScale(0.5,0.5)
_new("Frame")({
  Size = UDim2.fromScale(1, 1),
  Parent = target,
  Children = {
     out
  }
})
