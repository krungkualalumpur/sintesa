--!strict
--services
--packages
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))
--modules
--types
export type LevelData = {
    [Enums.ElevationResting] : number
}
--constants
--remotes
--variables
local LevelData : LevelData = {
    [Enums.ElevationResting.Level0] = 0,
    [Enums.ElevationResting.Level1] = 1,
    [Enums.ElevationResting.Level2] = 3,
    [Enums.ElevationResting.Level3] = 6,
    [Enums.ElevationResting.Level4] = 8,
    [Enums.ElevationResting.Level5] = 12,
}
--references
--local functions
--class
local Elevation = {}
function Elevation.getLevelData(elevation : Enums.ElevationResting): number
    return LevelData[elevation]
end
function Elevation.getLevelsData(): LevelData
    return table.freeze(table.clone(LevelData))
end

return Elevation