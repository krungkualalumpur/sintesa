--!strict
--
local _Package = script
local _Packages = _Package.Parent

local Icons = require(_Package:WaitForChild("Icons"))
local BottomAppBar = require(_Package:WaitForChild("Molecules"):WaitForChild("AppBar"):WaitForChild("BottomAppBar"))
local CenterAlignedTopAppBar = require(_Package:WaitForChild("Molecules"):WaitForChild("AppBar"):WaitForChild("TopAppBar"):WaitForChild("CenterAligned"))
local LargeTopTopAppBar = require(_Package:WaitForChild("Molecules"):WaitForChild("AppBar"):WaitForChild("TopAppBar"):WaitForChild("LargeTop"))
local MediumTopTopAppBar = require(_Package:WaitForChild("Molecules"):WaitForChild("AppBar"):WaitForChild("TopAppBar"):WaitForChild("MediumTop"))
local SmallTopTopAppBar = require(_Package:WaitForChild("Molecules"):WaitForChild("AppBar"):WaitForChild("TopAppBar"):WaitForChild("SmallTop"))

local LargeBadge = require(_Package:WaitForChild("Molecules"):WaitForChild("Badges"):WaitForChild("Large"))
local SmallBadge = require(_Package:WaitForChild("Molecules"):WaitForChild("Badges"):WaitForChild("Small"))

local ElevatedCommonButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Elevated"))
local FilledCommonButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Filled"))
local OutlinedCommonButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Outlined"))
local TextCommonButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Text"))
local TonalCommonButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Tonal"))
local ExtendedFAB = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("ExtendedFAB"))
local FAB = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("FAB"))
local FilledIconButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Filled"))
local FilledTonalIconButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("FilledTonal"))
local OutlinedIconButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Outlined"))
local StandardIconButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
local SegmentedButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("SegmentedButton"))

local ElevatedCard = require(_Package:WaitForChild("Molecules"):WaitForChild("Cards"):WaitForChild("ElevatedCard"))
local FilledCard = require(_Package:WaitForChild("Molecules"):WaitForChild("Cards"):WaitForChild("FilledCard"))
local OutlinedCard = require(_Package:WaitForChild("Molecules"):WaitForChild("Cards"):WaitForChild("OutlinedCard"))

local Checkbox = require(_Package:WaitForChild("Molecules"):WaitForChild("Checkbox"):WaitForChild("Checkbox"))

local AssistChip = require(_Package:WaitForChild("Molecules"):WaitForChild("Chips"):WaitForChild("Assist"))
local FilterChip = require(_Package:WaitForChild("Molecules"):WaitForChild("Chips"):WaitForChild("Filter"))
local InputChip = require(_Package:WaitForChild("Molecules"):WaitForChild("Chips"):WaitForChild("Input"))
local SuggestionChip = require(_Package:WaitForChild("Molecules"):WaitForChild("Chips"):WaitForChild("Suggestion"))

local BasicDialog = require(_Package:WaitForChild("Molecules"):WaitForChild("Dialogs"):WaitForChild("Basic"))

local Divider = require(_Package:WaitForChild("Molecules"):WaitForChild("Divider"))

local Lists = require(_Package:WaitForChild("Molecules"):WaitForChild("Lists"))

local Menus = require(_Package:WaitForChild("Molecules"):WaitForChild("Menus"))

local NavigationBar = require(_Package:WaitForChild("Molecules"):WaitForChild("Navigation"):WaitForChild("NavigationBar"))
local NavigationDrawer = require(_Package:WaitForChild("Molecules"):WaitForChild("Navigation"):WaitForChild("NavigationDrawer"))
local NavigationRail = require(_Package:WaitForChild("Molecules"):WaitForChild("Navigation"):WaitForChild("NavigationRail"))

local CircularProgressIndicator = require(_Package:WaitForChild("Molecules"):WaitForChild("ProgressIndicator"):WaitForChild("Circular"))
local LinearProgressIndicator = require(_Package:WaitForChild("Molecules"):WaitForChild("ProgressIndicator"):WaitForChild("Linear"))

local RadioButton = require(_Package:WaitForChild("Molecules"):WaitForChild("RadioButton"):WaitForChild("RadioButton"))

local SearchBar = require(_Package:WaitForChild("Molecules"):WaitForChild("Search"):WaitForChild("SearchBar"))
local SearchView = require(_Package:WaitForChild("Molecules"):WaitForChild("Search"):WaitForChild("SearchView"))

local BottomSheets = require(_Package:WaitForChild("Molecules"):WaitForChild("Sheets"):WaitForChild("BottomSheet"))
local SideSheets = require(_Package:WaitForChild("Molecules"):WaitForChild("Sheets"):WaitForChild("SideSheet"))

local Slider = require(_Package:WaitForChild("Molecules"):WaitForChild("Slider"))
local Snackbar = require(_Package:WaitForChild("Molecules"):WaitForChild("Snackbar"))

local Switch = require(_Package:WaitForChild("Molecules"):WaitForChild("Switch"))

local Tabs = require(_Package:WaitForChild("Molecules"):WaitForChild("Tabs"))

local FilledTextField = require(_Package:WaitForChild("Molecules"):WaitForChild("TextField"):WaitForChild("Filled"))
local OutlinedTextField = require(_Package:WaitForChild("Molecules"):WaitForChild("TextField"):WaitForChild("Outlined"))

local PlainToolTip = require(_Package:WaitForChild("Molecules"):WaitForChild("Tooltips"):WaitForChild("Plain"))
local RichToolTip = require(_Package:WaitForChild("Molecules"):WaitForChild("Tooltips"):WaitForChild("Rich"))

local ImageLabel = require(_Package:WaitForChild("Molecules"):WaitForChild("Util"):WaitForChild("ImageLabel"))
local TextBox = require(_Package:WaitForChild("Molecules"):WaitForChild("Util"):WaitForChild("TextBox"))
local TextLabel = require(_Package:WaitForChild("Molecules"):WaitForChild("Util"):WaitForChild("TextLabel"))
local ViewportFrame = require(_Package:WaitForChild("Molecules"):WaitForChild("Util"):WaitForChild("ViewportFrame"))


local sintesa = {}

sintesa.IconLists = Icons

sintesa.Molecules = {}
sintesa.Molecules.BottomAppBar = BottomAppBar
sintesa.Molecules.CenterAlignedTopAppBar = CenterAlignedTopAppBar
sintesa.Molecules.LargeTopTopAppBar = LargeTopTopAppBar
sintesa.Molecules.MediumTopTopAppBar = MediumTopTopAppBar
sintesa.Molecules.SmallTopTopAppBar = SmallTopTopAppBar

sintesa.Molecules.LargeBadge = LargeBadge
sintesa.Molecules.SmallBadge = SmallBadge

sintesa.Molecules.ElevatedCommonButton = ElevatedCommonButton
sintesa.Molecules.FilledCommonButton = FilledCommonButton
sintesa.Molecules.OutlinedCommonButton = OutlinedCommonButton
sintesa.Molecules.TextCommonButton = TextCommonButton
sintesa.Molecules.TonalCommonButton = TonalCommonButton
sintesa.Molecules.ExtendedFAB = ExtendedFAB
sintesa.Molecules.FAB = FAB
sintesa.Molecules.FilledIconButton = FilledIconButton
sintesa.Molecules.FilledTonalIconButton = FilledTonalIconButton
sintesa.Molecules.OutlinedIconButton = OutlinedIconButton
sintesa.Molecules.StandardIconButton = StandardIconButton
sintesa.Molecules.SegmentedButton = SegmentedButton

sintesa.Molecules.ElevatedCard = ElevatedCard
sintesa.Molecules.FilledCard = FilledCard
sintesa.Molecules.OutlinedCard = OutlinedCard

sintesa.Molecules.Checkbox = Checkbox

sintesa.Molecules.AssistChip = AssistChip
sintesa.Molecules.FilterChip = FilterChip
sintesa.Molecules.InputChip = InputChip
sintesa.Molecules.SuggestionChip = SuggestionChip

sintesa.Molecules.BasicDialog = BasicDialog

sintesa.Molecules.Divider = Divider

sintesa.Molecules.Lists = Lists

sintesa.Molecules.Menus = Menus

sintesa.Molecules.NavigationBar = NavigationBar
sintesa.Molecules.NavigationDrawer = NavigationDrawer
sintesa.Molecules.NavigationRail = NavigationRail

sintesa.Molecules.CircularProgressIndicator = CircularProgressIndicator
sintesa.Molecules.LinearProgressIndicator = LinearProgressIndicator

sintesa.Molecules.RadioButton = RadioButton

sintesa.Molecules.SearchBar = SearchBar
sintesa.Molecules.SearchView = SearchView

sintesa.Molecules.BottomSheets = BottomSheets
sintesa.Molecules.SideSheets = SideSheets

sintesa.Molecules.Slider = Slider
sintesa.Molecules.Snackbar = Snackbar 

sintesa.Molecules.Switch = Switch

sintesa.Molecules.Tabs = Tabs

sintesa.Molecules.FilledTextField = FilledTextField
sintesa.Molecules.OutlinedTextField = OutlinedTextField

sintesa.Molecules.PlainToolTip = PlainToolTip
sintesa.Molecules.RichToolTip = RichToolTip

sintesa.InterfaceUtil = {}
sintesa.InterfaceUtil.ImageLabel = ImageLabel
sintesa.InterfaceUtil.TextBox = TextBox
sintesa.InterfaceUtil.TextLabel = TextLabel
sintesa.InterfaceUtil.ViewportFrame = ViewportFrame

return sintesa