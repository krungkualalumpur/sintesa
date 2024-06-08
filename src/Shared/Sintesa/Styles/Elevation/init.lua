--!strict
--services
--packages
--modules
--types
export type Level = "Level 0" | "Level 1" 
                        | "Level 2" | "Level 3"
                            | "Level 4" | "Level 5"
export type LevelData = {
    [Level] : {dp : number}
}
export type ElevationData = {
    Level : Level,
}
--constants
--remotes
--variables
local LevelData : LevelData = {
    ["Level 0"] = {
        dp = 0
    },
    ["Level 1"] = {
        dp = 1
    },
    ["Level 2"] = {
        dp = 3
    },
    ["Level 3"] = {
        dp = 6
    },
    ["Level 4"] = {
        dp = 8
    },
    ["Level 5"] = {
        dp = 12
    },
}
--references
--local functions
--class
local Elevation = {}

function Elevation.getLevelData(): LevelData
    return table.freeze(LevelData)
end

return Elevation