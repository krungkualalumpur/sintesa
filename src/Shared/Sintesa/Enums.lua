--This is an auto generated script, please do not modify this!
--!strict
--services
--packages
--modules
--types
type CustomEnum <N> = {
	Name : N,
	GetEnumItems : (self : CustomEnum<N>) -> {[number] : CustomEnumItem<CustomEnum<N>, string>}
}

type CustomEnumItem <E, N> = {
	Name : N,
	Value : number,
	EnumType : E
}
type ColorRoleEnum = CustomEnum<"ColorRole">
export type ColorRole = CustomEnumItem<ColorRoleEnum, "Primary"|"Secondary"|"Tertiary"|"Error"|"OnPrimary"|"OnSecondary"|"OnTertiary"|"OnError"|"PrimaryContainer"|"SecondaryContainer"|"TertiaryContainer"|"ErrorContainer"|"OnPrimaryContainer"|"OnSecondaryContainer"|"OnTertiaryContainer"|"OnErrorContainer"|"PrimaryFixed"|"PrimaryFixedDim"|"SecondaryFixed"|"SecondaryFixedDim"|"TertiaryFixed"|"TertiaryFixedDim"|"OnPrimaryFixed"|"OnSecondaryFixed"|"OnTertiaryFixed"|"OnPrimaryFixedVariant"|"OnSecondaryFixedVariant"|"OnTertiaryFixedVariant"|"SurfaceDim"|"Surface"|"SurfaceBright"|"InverseSurface"|"InverseOnSurface"|"SurfaceContainerLowest"|"SurfaceContainerLow"|"SurfaceContainer"|"SurfaceContainerHigh"|"SurfaceContainerHighest"|"InversePrimary"|"OnSurface"|"OnSurfaceVariant"|"Outline"|"OutlineVariant"|"Scrim"|"Shadow">

type ElevationRestingEnum = CustomEnum<"ElevationResting">
export type ElevationResting = CustomEnumItem<ElevationRestingEnum, "Level0"|"Level1"|"Level2"|"Level3"|"Level4"|"Level5">

type EasingEnum = CustomEnum<"Easing">
export type Easing = CustomEnumItem<EasingEnum, "Emphasized"|"EmphasizedDecelerate"|"EphasizedAccelerate"|"Standard"|"StandardDecelerate"|"StandardAccelerate">

type TransitionDurationEnum = CustomEnum<"TransitionDuration">
export type TransitionDuration = CustomEnumItem<TransitionDurationEnum, "Short1"|"Short2"|"Short3"|"Short4"|"Medium1"|"Medium2"|"Medium3"|"Medium4"|"Long1"|"Long2"|"Long3"|"Long4">

type ShapeStyleEnum = CustomEnum<"ShapeStyle">
export type ShapeStyle = CustomEnumItem<ShapeStyleEnum, "None"|"ExtraSmall"|"Small"|"Medium"|"Large"|"ExtraLarge"|"Full">

type ShapeSymmetryEnum = CustomEnum<"ShapeSymmetry">
export type ShapeSymmetry = CustomEnumItem<ShapeSymmetryEnum, "Top"|"Bottom"|"Start"|"End"|"Full">

type TypographyStyleEnum = CustomEnum<"TypographyStyle">
export type TypographyStyle = CustomEnumItem<TypographyStyleEnum, "DisplayLarge"|"DisplayMedium"|"DisplaySmall"|"HeadlineLarge"|"HeadlineMedium"|"HeadlineSmall"|"TitleLarge"|"TitleMedium"|"TitleSmall"|"BodyLarge"|"BodyMedium"|"BodySmall"|"LabelLarge"|"LabelMedium"|"LabelSmall">

type ButtonStateEnum = CustomEnum<"ButtonState">
export type ButtonState = CustomEnumItem<ButtonStateEnum, "Enabled"|"Disabled"|"Hovered"|"Focused"|"Pressed">

export type CustomEnums = {

	ColorRole : 	{		
		Primary : CustomEnumItem <ColorRoleEnum, "Primary">,
		Secondary : CustomEnumItem <ColorRoleEnum, "Secondary">,
		Tertiary : CustomEnumItem <ColorRoleEnum, "Tertiary">,
		Error : CustomEnumItem <ColorRoleEnum, "Error">,
		OnPrimary : CustomEnumItem <ColorRoleEnum, "OnPrimary">,
		OnSecondary : CustomEnumItem <ColorRoleEnum, "OnSecondary">,
		OnTertiary : CustomEnumItem <ColorRoleEnum, "OnTertiary">,
		OnError : CustomEnumItem <ColorRoleEnum, "OnError">,
		PrimaryContainer : CustomEnumItem <ColorRoleEnum, "PrimaryContainer">,
		SecondaryContainer : CustomEnumItem <ColorRoleEnum, "SecondaryContainer">,
		TertiaryContainer : CustomEnumItem <ColorRoleEnum, "TertiaryContainer">,
		ErrorContainer : CustomEnumItem <ColorRoleEnum, "ErrorContainer">,
		OnPrimaryContainer : CustomEnumItem <ColorRoleEnum, "OnPrimaryContainer">,
		OnSecondaryContainer : CustomEnumItem <ColorRoleEnum, "OnSecondaryContainer">,
		OnTertiaryContainer : CustomEnumItem <ColorRoleEnum, "OnTertiaryContainer">,
		OnErrorContainer : CustomEnumItem <ColorRoleEnum, "OnErrorContainer">,
		PrimaryFixed : CustomEnumItem <ColorRoleEnum, "PrimaryFixed">,
		PrimaryFixedDim : CustomEnumItem <ColorRoleEnum, "PrimaryFixedDim">,
		SecondaryFixed : CustomEnumItem <ColorRoleEnum, "SecondaryFixed">,
		SecondaryFixedDim : CustomEnumItem <ColorRoleEnum, "SecondaryFixedDim">,
		TertiaryFixed : CustomEnumItem <ColorRoleEnum, "TertiaryFixed">,
		TertiaryFixedDim : CustomEnumItem <ColorRoleEnum, "TertiaryFixedDim">,
		OnPrimaryFixed : CustomEnumItem <ColorRoleEnum, "OnPrimaryFixed">,
		OnSecondaryFixed : CustomEnumItem <ColorRoleEnum, "OnSecondaryFixed">,
		OnTertiaryFixed : CustomEnumItem <ColorRoleEnum, "OnTertiaryFixed">,
		OnPrimaryFixedVariant : CustomEnumItem <ColorRoleEnum, "OnPrimaryFixedVariant">,
		OnSecondaryFixedVariant : CustomEnumItem <ColorRoleEnum, "OnSecondaryFixedVariant">,
		OnTertiaryFixedVariant : CustomEnumItem <ColorRoleEnum, "OnTertiaryFixedVariant">,
		SurfaceDim : CustomEnumItem <ColorRoleEnum, "SurfaceDim">,
		Surface : CustomEnumItem <ColorRoleEnum, "Surface">,
		SurfaceBright : CustomEnumItem <ColorRoleEnum, "SurfaceBright">,
		InverseSurface : CustomEnumItem <ColorRoleEnum, "InverseSurface">,
		InverseOnSurface : CustomEnumItem <ColorRoleEnum, "InverseOnSurface">,
		SurfaceContainerLowest : CustomEnumItem <ColorRoleEnum, "SurfaceContainerLowest">,
		SurfaceContainerLow : CustomEnumItem <ColorRoleEnum, "SurfaceContainerLow">,
		SurfaceContainer : CustomEnumItem <ColorRoleEnum, "SurfaceContainer">,
		SurfaceContainerHigh : CustomEnumItem <ColorRoleEnum, "SurfaceContainerHigh">,
		SurfaceContainerHighest : CustomEnumItem <ColorRoleEnum, "SurfaceContainerHighest">,
		InversePrimary : CustomEnumItem <ColorRoleEnum, "InversePrimary">,
		OnSurface : CustomEnumItem <ColorRoleEnum, "OnSurface">,
		OnSurfaceVariant : CustomEnumItem <ColorRoleEnum, "OnSurfaceVariant">,
		Outline : CustomEnumItem <ColorRoleEnum, "Outline">,
		OutlineVariant : CustomEnumItem <ColorRoleEnum, "OutlineVariant">,
		Scrim : CustomEnumItem <ColorRoleEnum, "Scrim">,
		Shadow : CustomEnumItem <ColorRoleEnum, "Shadow">,
	} & ColorRoleEnum,

	ElevationResting : 	{		
		Level0 : CustomEnumItem <ElevationRestingEnum, "Level0">,
		Level1 : CustomEnumItem <ElevationRestingEnum, "Level1">,
		Level2 : CustomEnumItem <ElevationRestingEnum, "Level2">,
		Level3 : CustomEnumItem <ElevationRestingEnum, "Level3">,
		Level4 : CustomEnumItem <ElevationRestingEnum, "Level4">,
		Level5 : CustomEnumItem <ElevationRestingEnum, "Level5">,
	} & ElevationRestingEnum,

	Easing : 	{		
		Emphasized : CustomEnumItem <EasingEnum, "Emphasized">,
		EmphasizedDecelerate : CustomEnumItem <EasingEnum, "EmphasizedDecelerate">,
		EphasizedAccelerate : CustomEnumItem <EasingEnum, "EphasizedAccelerate">,
		Standard : CustomEnumItem <EasingEnum, "Standard">,
		StandardDecelerate : CustomEnumItem <EasingEnum, "StandardDecelerate">,
		StandardAccelerate : CustomEnumItem <EasingEnum, "StandardAccelerate">,
	} & EasingEnum,

	TransitionDuration : 	{		
		Short1 : CustomEnumItem <TransitionDurationEnum, "Short1">,
		Short2 : CustomEnumItem <TransitionDurationEnum, "Short2">,
		Short3 : CustomEnumItem <TransitionDurationEnum, "Short3">,
		Short4 : CustomEnumItem <TransitionDurationEnum, "Short4">,
		Medium1 : CustomEnumItem <TransitionDurationEnum, "Medium1">,
		Medium2 : CustomEnumItem <TransitionDurationEnum, "Medium2">,
		Medium3 : CustomEnumItem <TransitionDurationEnum, "Medium3">,
		Medium4 : CustomEnumItem <TransitionDurationEnum, "Medium4">,
		Long1 : CustomEnumItem <TransitionDurationEnum, "Long1">,
		Long2 : CustomEnumItem <TransitionDurationEnum, "Long2">,
		Long3 : CustomEnumItem <TransitionDurationEnum, "Long3">,
		Long4 : CustomEnumItem <TransitionDurationEnum, "Long4">,
	} & TransitionDurationEnum,

	ShapeStyle : 	{		
		None : CustomEnumItem <ShapeStyleEnum, "None">,
		ExtraSmall : CustomEnumItem <ShapeStyleEnum, "ExtraSmall">,
		Small : CustomEnumItem <ShapeStyleEnum, "Small">,
		Medium : CustomEnumItem <ShapeStyleEnum, "Medium">,
		Large : CustomEnumItem <ShapeStyleEnum, "Large">,
		ExtraLarge : CustomEnumItem <ShapeStyleEnum, "ExtraLarge">,
		Full : CustomEnumItem <ShapeStyleEnum, "Full">,
	} & ShapeStyleEnum,

	ShapeSymmetry : 	{		
		Top : CustomEnumItem <ShapeSymmetryEnum, "Top">,
		Bottom : CustomEnumItem <ShapeSymmetryEnum, "Bottom">,
		Start : CustomEnumItem <ShapeSymmetryEnum, "Start">,
		End : CustomEnumItem <ShapeSymmetryEnum, "End">,
		Full : CustomEnumItem <ShapeSymmetryEnum, "Full">,
	} & ShapeSymmetryEnum,

	TypographyStyle : 	{		
		DisplayLarge : CustomEnumItem <TypographyStyleEnum, "DisplayLarge">,
		DisplayMedium : CustomEnumItem <TypographyStyleEnum, "DisplayMedium">,
		DisplaySmall : CustomEnumItem <TypographyStyleEnum, "DisplaySmall">,
		HeadlineLarge : CustomEnumItem <TypographyStyleEnum, "HeadlineLarge">,
		HeadlineMedium : CustomEnumItem <TypographyStyleEnum, "HeadlineMedium">,
		HeadlineSmall : CustomEnumItem <TypographyStyleEnum, "HeadlineSmall">,
		TitleLarge : CustomEnumItem <TypographyStyleEnum, "TitleLarge">,
		TitleMedium : CustomEnumItem <TypographyStyleEnum, "TitleMedium">,
		TitleSmall : CustomEnumItem <TypographyStyleEnum, "TitleSmall">,
		BodyLarge : CustomEnumItem <TypographyStyleEnum, "BodyLarge">,
		BodyMedium : CustomEnumItem <TypographyStyleEnum, "BodyMedium">,
		BodySmall : CustomEnumItem <TypographyStyleEnum, "BodySmall">,
		LabelLarge : CustomEnumItem <TypographyStyleEnum, "LabelLarge">,
		LabelMedium : CustomEnumItem <TypographyStyleEnum, "LabelMedium">,
		LabelSmall : CustomEnumItem <TypographyStyleEnum, "LabelSmall">,
	} & TypographyStyleEnum,

	ButtonState : 	{		
		Enabled : CustomEnumItem <ButtonStateEnum, "Enabled">,
		Disabled : CustomEnumItem <ButtonStateEnum, "Disabled">,
		Hovered : CustomEnumItem <ButtonStateEnum, "Hovered">,
		Focused : CustomEnumItem <ButtonStateEnum, "Focused">,
		Pressed : CustomEnumItem <ButtonStateEnum, "Pressed">,
	} & ButtonStateEnum,

}
--constants
--remotes
--local function


local ColorRole = {
	Name = "ColorRole",
	GetEnumItems = function(self)
		local t = {}
		for _,v in pairs(self) do
			if type(v) == "table" then 
				 table.insert(t, v)  
			end
		end
		return t
	end,
}

ColorRole.Primary = {
	Name = "Primary",
	Value = 1,
	EnumType = ColorRole
}

ColorRole.Secondary = {
	Name = "Secondary",
	Value = 2,
	EnumType = ColorRole
}

ColorRole.Tertiary = {
	Name = "Tertiary",
	Value = 3,
	EnumType = ColorRole
}

ColorRole.Error = {
	Name = "Error",
	Value = 4,
	EnumType = ColorRole
}

ColorRole.OnPrimary = {
	Name = "OnPrimary",
	Value = 5,
	EnumType = ColorRole
}

ColorRole.OnSecondary = {
	Name = "OnSecondary",
	Value = 6,
	EnumType = ColorRole
}

ColorRole.OnTertiary = {
	Name = "OnTertiary",
	Value = 7,
	EnumType = ColorRole
}

ColorRole.OnError = {
	Name = "OnError",
	Value = 8,
	EnumType = ColorRole
}

ColorRole.PrimaryContainer = {
	Name = "PrimaryContainer",
	Value = 9,
	EnumType = ColorRole
}

ColorRole.SecondaryContainer = {
	Name = "SecondaryContainer",
	Value = 10,
	EnumType = ColorRole
}

ColorRole.TertiaryContainer = {
	Name = "TertiaryContainer",
	Value = 11,
	EnumType = ColorRole
}

ColorRole.ErrorContainer = {
	Name = "ErrorContainer",
	Value = 12,
	EnumType = ColorRole
}

ColorRole.OnPrimaryContainer = {
	Name = "OnPrimaryContainer",
	Value = 13,
	EnumType = ColorRole
}

ColorRole.OnSecondaryContainer = {
	Name = "OnSecondaryContainer",
	Value = 14,
	EnumType = ColorRole
}

ColorRole.OnTertiaryContainer = {
	Name = "OnTertiaryContainer",
	Value = 15,
	EnumType = ColorRole
}

ColorRole.OnErrorContainer = {
	Name = "OnErrorContainer",
	Value = 16,
	EnumType = ColorRole
}

ColorRole.PrimaryFixed = {
	Name = "PrimaryFixed",
	Value = 17,
	EnumType = ColorRole
}

ColorRole.PrimaryFixedDim = {
	Name = "PrimaryFixedDim",
	Value = 18,
	EnumType = ColorRole
}

ColorRole.SecondaryFixed = {
	Name = "SecondaryFixed",
	Value = 19,
	EnumType = ColorRole
}

ColorRole.SecondaryFixedDim = {
	Name = "SecondaryFixedDim",
	Value = 20,
	EnumType = ColorRole
}

ColorRole.TertiaryFixed = {
	Name = "TertiaryFixed",
	Value = 21,
	EnumType = ColorRole
}

ColorRole.TertiaryFixedDim = {
	Name = "TertiaryFixedDim",
	Value = 22,
	EnumType = ColorRole
}

ColorRole.OnPrimaryFixed = {
	Name = "OnPrimaryFixed",
	Value = 23,
	EnumType = ColorRole
}

ColorRole.OnSecondaryFixed = {
	Name = "OnSecondaryFixed",
	Value = 24,
	EnumType = ColorRole
}

ColorRole.OnTertiaryFixed = {
	Name = "OnTertiaryFixed",
	Value = 25,
	EnumType = ColorRole
}

ColorRole.OnPrimaryFixedVariant = {
	Name = "OnPrimaryFixedVariant",
	Value = 26,
	EnumType = ColorRole
}

ColorRole.OnSecondaryFixedVariant = {
	Name = "OnSecondaryFixedVariant",
	Value = 27,
	EnumType = ColorRole
}

ColorRole.OnTertiaryFixedVariant = {
	Name = "OnTertiaryFixedVariant",
	Value = 28,
	EnumType = ColorRole
}

ColorRole.SurfaceDim = {
	Name = "SurfaceDim",
	Value = 29,
	EnumType = ColorRole
}

ColorRole.Surface = {
	Name = "Surface",
	Value = 30,
	EnumType = ColorRole
}

ColorRole.SurfaceBright = {
	Name = "SurfaceBright",
	Value = 31,
	EnumType = ColorRole
}

ColorRole.InverseSurface = {
	Name = "InverseSurface",
	Value = 32,
	EnumType = ColorRole
}

ColorRole.InverseOnSurface = {
	Name = "InverseOnSurface",
	Value = 33,
	EnumType = ColorRole
}

ColorRole.SurfaceContainerLowest = {
	Name = "SurfaceContainerLowest",
	Value = 34,
	EnumType = ColorRole
}

ColorRole.SurfaceContainerLow = {
	Name = "SurfaceContainerLow",
	Value = 35,
	EnumType = ColorRole
}

ColorRole.SurfaceContainer = {
	Name = "SurfaceContainer",
	Value = 36,
	EnumType = ColorRole
}

ColorRole.SurfaceContainerHigh = {
	Name = "SurfaceContainerHigh",
	Value = 37,
	EnumType = ColorRole
}

ColorRole.SurfaceContainerHighest = {
	Name = "SurfaceContainerHighest",
	Value = 38,
	EnumType = ColorRole
}

ColorRole.InversePrimary = {
	Name = "InversePrimary",
	Value = 39,
	EnumType = ColorRole
}

ColorRole.OnSurface = {
	Name = "OnSurface",
	Value = 40,
	EnumType = ColorRole
}

ColorRole.OnSurfaceVariant = {
	Name = "OnSurfaceVariant",
	Value = 41,
	EnumType = ColorRole
}

ColorRole.Outline = {
	Name = "Outline",
	Value = 42,
	EnumType = ColorRole
}

ColorRole.OutlineVariant = {
	Name = "OutlineVariant",
	Value = 43,
	EnumType = ColorRole
}

ColorRole.Scrim = {
	Name = "Scrim",
	Value = 44,
	EnumType = ColorRole
}

ColorRole.Shadow = {
	Name = "Shadow",
	Value = 45,
	EnumType = ColorRole
}

local ElevationResting = {
	Name = "ElevationResting",
	GetEnumItems = function(self)
		local t = {}
		for _,v in pairs(self) do
			if type(v) == "table" then 
				 table.insert(t, v)  
			end
		end
		return t
	end,
}

ElevationResting.Level0 = {
	Name = "Level0",
	Value = 1,
	EnumType = ElevationResting
}

ElevationResting.Level1 = {
	Name = "Level1",
	Value = 2,
	EnumType = ElevationResting
}

ElevationResting.Level2 = {
	Name = "Level2",
	Value = 3,
	EnumType = ElevationResting
}

ElevationResting.Level3 = {
	Name = "Level3",
	Value = 4,
	EnumType = ElevationResting
}

ElevationResting.Level4 = {
	Name = "Level4",
	Value = 5,
	EnumType = ElevationResting
}

ElevationResting.Level5 = {
	Name = "Level5",
	Value = 6,
	EnumType = ElevationResting
}

local Easing = {
	Name = "Easing",
	GetEnumItems = function(self)
		local t = {}
		for _,v in pairs(self) do
			if type(v) == "table" then 
				 table.insert(t, v)  
			end
		end
		return t
	end,
}

Easing.Emphasized = {
	Name = "Emphasized",
	Value = 1,
	EnumType = Easing
}

Easing.EmphasizedDecelerate = {
	Name = "EmphasizedDecelerate",
	Value = 2,
	EnumType = Easing
}

Easing.EphasizedAccelerate = {
	Name = "EphasizedAccelerate",
	Value = 3,
	EnumType = Easing
}

Easing.Standard = {
	Name = "Standard",
	Value = 4,
	EnumType = Easing
}

Easing.StandardDecelerate = {
	Name = "StandardDecelerate",
	Value = 5,
	EnumType = Easing
}

Easing.StandardAccelerate = {
	Name = "StandardAccelerate",
	Value = 6,
	EnumType = Easing
}

local TransitionDuration = {
	Name = "TransitionDuration",
	GetEnumItems = function(self)
		local t = {}
		for _,v in pairs(self) do
			if type(v) == "table" then 
				 table.insert(t, v)  
			end
		end
		return t
	end,
}

TransitionDuration.Short1 = {
	Name = "Short1",
	Value = 1,
	EnumType = TransitionDuration
}

TransitionDuration.Short2 = {
	Name = "Short2",
	Value = 2,
	EnumType = TransitionDuration
}

TransitionDuration.Short3 = {
	Name = "Short3",
	Value = 3,
	EnumType = TransitionDuration
}

TransitionDuration.Short4 = {
	Name = "Short4",
	Value = 4,
	EnumType = TransitionDuration
}

TransitionDuration.Medium1 = {
	Name = "Medium1",
	Value = 5,
	EnumType = TransitionDuration
}

TransitionDuration.Medium2 = {
	Name = "Medium2",
	Value = 6,
	EnumType = TransitionDuration
}

TransitionDuration.Medium3 = {
	Name = "Medium3",
	Value = 7,
	EnumType = TransitionDuration
}

TransitionDuration.Medium4 = {
	Name = "Medium4",
	Value = 8,
	EnumType = TransitionDuration
}

TransitionDuration.Long1 = {
	Name = "Long1",
	Value = 9,
	EnumType = TransitionDuration
}

TransitionDuration.Long2 = {
	Name = "Long2",
	Value = 10,
	EnumType = TransitionDuration
}

TransitionDuration.Long3 = {
	Name = "Long3",
	Value = 11,
	EnumType = TransitionDuration
}

TransitionDuration.Long4 = {
	Name = "Long4",
	Value = 12,
	EnumType = TransitionDuration
}

local ShapeStyle = {
	Name = "ShapeStyle",
	GetEnumItems = function(self)
		local t = {}
		for _,v in pairs(self) do
			if type(v) == "table" then 
				 table.insert(t, v)  
			end
		end
		return t
	end,
}

ShapeStyle.None = {
	Name = "None",
	Value = 1,
	EnumType = ShapeStyle
}

ShapeStyle.ExtraSmall = {
	Name = "ExtraSmall",
	Value = 2,
	EnumType = ShapeStyle
}

ShapeStyle.Small = {
	Name = "Small",
	Value = 3,
	EnumType = ShapeStyle
}

ShapeStyle.Medium = {
	Name = "Medium",
	Value = 4,
	EnumType = ShapeStyle
}

ShapeStyle.Large = {
	Name = "Large",
	Value = 5,
	EnumType = ShapeStyle
}

ShapeStyle.ExtraLarge = {
	Name = "ExtraLarge",
	Value = 6,
	EnumType = ShapeStyle
}

ShapeStyle.Full = {
	Name = "Full",
	Value = 7,
	EnumType = ShapeStyle
}

local ShapeSymmetry = {
	Name = "ShapeSymmetry",
	GetEnumItems = function(self)
		local t = {}
		for _,v in pairs(self) do
			if type(v) == "table" then 
				 table.insert(t, v)  
			end
		end
		return t
	end,
}

ShapeSymmetry.Top = {
	Name = "Top",
	Value = 1,
	EnumType = ShapeSymmetry
}

ShapeSymmetry.Bottom = {
	Name = "Bottom",
	Value = 2,
	EnumType = ShapeSymmetry
}

ShapeSymmetry.Start = {
	Name = "Start",
	Value = 3,
	EnumType = ShapeSymmetry
}

ShapeSymmetry.End = {
	Name = "End",
	Value = 4,
	EnumType = ShapeSymmetry
}

ShapeSymmetry.Full = {
	Name = "Full",
	Value = 5,
	EnumType = ShapeSymmetry
}

local TypographyStyle = {
	Name = "TypographyStyle",
	GetEnumItems = function(self)
		local t = {}
		for _,v in pairs(self) do
			if type(v) == "table" then 
				 table.insert(t, v)  
			end
		end
		return t
	end,
}

TypographyStyle.DisplayLarge = {
	Name = "DisplayLarge",
	Value = 1,
	EnumType = TypographyStyle
}

TypographyStyle.DisplayMedium = {
	Name = "DisplayMedium",
	Value = 2,
	EnumType = TypographyStyle
}

TypographyStyle.DisplaySmall = {
	Name = "DisplaySmall",
	Value = 3,
	EnumType = TypographyStyle
}

TypographyStyle.HeadlineLarge = {
	Name = "HeadlineLarge",
	Value = 4,
	EnumType = TypographyStyle
}

TypographyStyle.HeadlineMedium = {
	Name = "HeadlineMedium",
	Value = 5,
	EnumType = TypographyStyle
}

TypographyStyle.HeadlineSmall = {
	Name = "HeadlineSmall",
	Value = 6,
	EnumType = TypographyStyle
}

TypographyStyle.TitleLarge = {
	Name = "TitleLarge",
	Value = 7,
	EnumType = TypographyStyle
}

TypographyStyle.TitleMedium = {
	Name = "TitleMedium",
	Value = 8,
	EnumType = TypographyStyle
}

TypographyStyle.TitleSmall = {
	Name = "TitleSmall",
	Value = 9,
	EnumType = TypographyStyle
}

TypographyStyle.BodyLarge = {
	Name = "BodyLarge",
	Value = 10,
	EnumType = TypographyStyle
}

TypographyStyle.BodyMedium = {
	Name = "BodyMedium",
	Value = 11,
	EnumType = TypographyStyle
}

TypographyStyle.BodySmall = {
	Name = "BodySmall",
	Value = 12,
	EnumType = TypographyStyle
}

TypographyStyle.LabelLarge = {
	Name = "LabelLarge",
	Value = 13,
	EnumType = TypographyStyle
}

TypographyStyle.LabelMedium = {
	Name = "LabelMedium",
	Value = 14,
	EnumType = TypographyStyle
}

TypographyStyle.LabelSmall = {
	Name = "LabelSmall",
	Value = 15,
	EnumType = TypographyStyle
}

local ButtonState = {
	Name = "ButtonState",
	GetEnumItems = function(self)
		local t = {}
		for _,v in pairs(self) do
			if type(v) == "table" then 
				 table.insert(t, v)  
			end
		end
		return t
	end,
}

ButtonState.Enabled = {
	Name = "Enabled",
	Value = 1,
	EnumType = ButtonState
}

ButtonState.Disabled = {
	Name = "Disabled",
	Value = 2,
	EnumType = ButtonState
}

ButtonState.Hovered = {
	Name = "Hovered",
	Value = 3,
	EnumType = ButtonState
}

ButtonState.Focused = {
	Name = "Focused",
	Value = 4,
	EnumType = ButtonState
}

ButtonState.Pressed = {
	Name = "Pressed",
	Value = 5,
	EnumType = ButtonState
}

local CustomEnum = {	
	ColorRole = ColorRole :: any,
	ElevationResting = ElevationResting :: any,
	Easing = Easing :: any,
	TransitionDuration = TransitionDuration :: any,
	ShapeStyle = ShapeStyle :: any,
	ShapeSymmetry = ShapeSymmetry :: any,
	TypographyStyle = TypographyStyle :: any,
	ButtonState = ButtonState :: any,
} :: CustomEnums

return CustomEnum