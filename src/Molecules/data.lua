--!strict
--services
--packages
--modules
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))
--types
--constants
--remotes
--variables
--references
--local functions
--class
local data = {}

data.Buttons = {
    Elevated = {
        [Enums.ButtonState.Enabled] = {
            Shape = Enums.ShapeSymmetry.Full
        }
    }   
}

return data