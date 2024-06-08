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

export type CustomEnums = {

	Easings : 	{		
		Emphasized : CustomEnumItem <EasingsEnum, "Emphasized">,
		EmphasizedDecelerate : CustomEnumItem <EasingsEnum, "EmphasizedDecelerate">,
		EphasizedAccelerate : CustomEnumItem <EasingsEnum, "EphasizedAccelerate">,
		Standard : CustomEnumItem <EasingsEnum, "Standard">,
		StandardDecelerate : CustomEnumItem <EasingsEnum, "StandardDecelerate">,
		StandardAccelerate : CustomEnumItem <EasingsEnum, "StandardAccelerate">,
	} & EasingsEnum,

}
--constants
--remotes
--local function


local Easings = {
	Name = "Easings" :: any,
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
	Name = "Emphasized" :: any,
	Value = 1,
	EnumType = Easings
}

Easings.EmphasizedDecelerate = {
	Name = "EmphasizedDecelerate" :: any,
	Value = 2,
	EnumType = Easings
}

Easings.EphasizedAccelerate = {
	Name = "EphasizedAccelerate" :: any,
	Value = 3,
	EnumType = Easings
}

Easings.Standard = {
	Name = "Standard" :: any,
	Value = 4,
	EnumType = Easings
}

Easings.StandardDecelerate = {
	Name = "StandardDecelerate" :: any,
	Value = 5,
	EnumType = Easings
}

Easings.StandardAccelerate = {
	Name = "StandardAccelerate" :: any,
	Value = 6,
	EnumType = Easings
}

local CustomEnum = {	
	Easings = Easings :: any,
} :: CustomEnums

return CustomEnum