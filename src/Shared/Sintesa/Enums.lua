--This is an auto generated script, please do not modify this!
--!strict
--services
--packages
--modules
--types
export type CustomEnum <N> = {
	Name : N,
	GetEnumItems : (self : CustomEnum<N>) -> {[number] : CustomEnumItem<CustomEnum<N>, string>}
}

export type CustomEnumItem <E, N> = {
	Name : string,
	Value : number,
	EnumType : E
}
type EasingsEnum = CustomEnum<"Easings">
export type Easings = CustomEnumItem<EasingsEnum, string>

type TransitionDurationEnum = CustomEnum<"TransitionDuration">
export type TransitionDuration = CustomEnumItem<TransitionDurationEnum, string>

type ShapeStyleEnum = CustomEnum<"ShapeStyle">
export type ShapeStyle = CustomEnumItem<ShapeStyleEnum, string>

type ShapeSymmetryEnum = CustomEnum<"ShapeSymmetry">
export type ShapeSymmetry = CustomEnumItem<ShapeSymmetryEnum, string>

type TypographyStyleEnum = CustomEnum<"TypographyStyle">
export type TypographyStyle = CustomEnumItem<TypographyStyleEnum, string>

export type CustomEnums = {

	Easings : 	{		
		Emphasized : CustomEnumItem <EasingsEnum, "Emphasized">,
		EmphasizedDecelerate : CustomEnumItem <EasingsEnum, "EmphasizedDecelerate">,
		EphasizedAccelerate : CustomEnumItem <EasingsEnum, "EphasizedAccelerate">,
		Standard : CustomEnumItem <EasingsEnum, "Standard">,
		StandardDecelerate : CustomEnumItem <EasingsEnum, "StandardDecelerate">,
		StandardAccelerate : CustomEnumItem <EasingsEnum, "StandardAccelerate">,
	} & EasingsEnum,

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

}
--constants
--remotes
--local function


local Easings = {
	Name = "Easings",
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

Easings.Emphasized = {
	Name = "Emphasized",
	Value = 1,
	EnumType = Easings
}

Easings.EmphasizedDecelerate = {
	Name = "EmphasizedDecelerate",
	Value = 2,
	EnumType = Easings
}

Easings.EphasizedAccelerate = {
	Name = "EphasizedAccelerate",
	Value = 3,
	EnumType = Easings
}

Easings.Standard = {
	Name = "Standard",
	Value = 4,
	EnumType = Easings
}

Easings.StandardDecelerate = {
	Name = "StandardDecelerate",
	Value = 5,
	EnumType = Easings
}

Easings.StandardAccelerate = {
	Name = "StandardAccelerate",
	Value = 6,
	EnumType = Easings
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

local CustomEnum = {	
	Easings = Easings :: any,
	TransitionDuration = TransitionDuration :: any,
	ShapeStyle = ShapeStyle :: any,
	ShapeSymmetry = ShapeSymmetry :: any,
	TypographyStyle = TypographyStyle :: any,
} :: CustomEnums

return CustomEnum