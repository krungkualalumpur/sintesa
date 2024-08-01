--!strict
--services
--packages
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))
--modules
--types
export type TypeScaleData = {
    Font : Enum.Font,
    Weight : number, --https://create.roblox.com/docs/reference/engine/enums/FontWeight
    WeightProminent : number ?,
    Size : number,
    Tracking : number, --https://www.google.com/url?sa=i&url=https%3A%2F%2Fcreatypestudio.co%2Ftracking-typography%2F&psig=AOvVaw0kuD6WPW8hKhqJVV7xwf-l&ust=1718374778634000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCLCVoJPj2IYDFQAAAAAdAAAAABAE
    LineHeight : number --https://create.roblox.com/docs/reference/engine/classes/TextLabel#LineHeight
}

export type TypeScalesData = {
    [Enums.TypographyStyle] : TypeScaleData
}
--constants
local LINE_HEIGHT_ADJUSTMENT = 0.08
--remotes
--variables
local TypeScalesData : TypeScalesData = {
    [Enums.TypographyStyle.DisplayLarge] = {
        Font = Enum.Font.Roboto,
        Weight = 400,
        Size =  57,
        Tracking = -0.25,
        LineHeight = 64*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.DisplayMedium] = {
        Font = Enum.Font.Roboto,
        Weight = 400,
        Size = 45,
        Tracking = 0,
        LineHeight = 52*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.DisplaySmall] = {
        Font = Enum.Font.Roboto,
        Weight = 400,
        Size = 36,
        Tracking = 0,
        LineHeight = 44*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.HeadlineLarge] = {
        Font = Enum.Font.Roboto,
        Weight = 400,
        Size = 32,
        Tracking = 0,
        LineHeight = 40*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.HeadlineMedium] = {
        Font = Enum.Font.Roboto,
        Weight = 400,
        Size = 28,
        Tracking = 0,
        LineHeight = 36*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.HeadlineSmall] = {
        Font = Enum.Font.Roboto,
        Weight = 400,
        Size = 24,
        Tracking = 0,
        LineHeight = 32*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.TitleLarge] = {
        Font = Enum.Font.Roboto,
        Weight = 400,
        Size = 22,
        Tracking = 0,
        LineHeight = 28*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.TitleMedium] = {
        Font = Enum.Font.Roboto,
        Weight = 500,
        Size = 16,
        Tracking = 0.15,
        LineHeight = 24*LINE_HEIGHT_ADJUSTMENT
    }, 
    [Enums.TypographyStyle.TitleSmall] = {
        Font = Enum.Font.Roboto,
        Weight = 500,
        Size = 14,
        Tracking = 0.1,
        LineHeight = 20*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.BodyLarge] = {
        Font = Enum.Font.Roboto,
        Weight = 400,
        Size = 16,
        Tracking = 0.5,
        LineHeight = 24*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.BodyMedium] = {
        Font = Enum.Font.Roboto,
        Weight = 400,
        Size = 14,
        Tracking = 0.25,
        LineHeight = 20*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.BodySmall] = {
        Font = Enum.Font.Roboto,
        Weight = 400,
        Size = 12,
        Tracking = 0.4,
        LineHeight = 16*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.LabelLarge] = {
        Font = Enum.Font.Roboto,
        Weight = 500,
        WeightProminent = 700,
        Size = 14,
        Tracking = 0.1,
        LineHeight = 20*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.LabelMedium] = {
        Font = Enum.Font.Roboto,
        Weight = 500,
        WeightProminent = 700,
        Size = 12,
        Tracking = 0.5,
        LineHeight = 16*LINE_HEIGHT_ADJUSTMENT
    },
    [Enums.TypographyStyle.LabelSmall] = {
        Font = Enum.Font.Roboto,
        Weight = 500,
        Size = 11,
        Tracking = 0.5,
        LineHeight = 16*LINE_HEIGHT_ADJUSTMENT
    },
}
--references
--local functions
--class
local Typography = {}

function Typography.get(typographyStyle : Enums.TypographyStyle)
    return table.freeze(table.clone(TypeScalesData[typographyStyle]))
end

function Typography.getTypographyTypeScales()
    return table.freeze(table.clone(TypeScalesData))
end

return Typography