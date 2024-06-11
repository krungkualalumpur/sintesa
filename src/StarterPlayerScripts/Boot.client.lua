--!strict
--services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--packages
--modules
local types = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Sintesa"):WaitForChild("Types"))
local textButton = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Sintesa"):WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("TextButton"))
--types
--constants
--remotes
--variables
--references
--local functions
--class
textButton.ColdFusion.new("Test", types.createAppearanceData(Color3.fromRGB(200,155,155)))