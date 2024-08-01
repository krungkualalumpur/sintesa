--!strict
--
local _Package = script
local _Packages = _Package.Parent

local sintesa = {}

sintesa.IconLists = require(_Package:WaitForChild("Icons"))

sintesa.Molecules = {}
sintesa.Molecules.BottomAppBar = require(_Package:WaitForChild("Molecules"):WaitForChild("AppBar"):WaitForChild("BottomAppBar"))
sintesa.Molecules.CenterAlignedTopAppBar = require(_Package:WaitForChild("Molecules"):WaitForChild("AppBar"):WaitForChild("TopAppBar"):WaitForChild("CenterAligned"))
sintesa.Molecules.LargeTopTopAppBar = require(_Package:WaitForChild("Molecules"):WaitForChild("AppBar"):WaitForChild("TopAppBar"):WaitForChild("LargeTop"))
sintesa.Molecules.MediumTopTopAppBar = require(_Package:WaitForChild("Molecules"):WaitForChild("AppBar"):WaitForChild("TopAppBar"):WaitForChild("MediumTop"))
sintesa.Molecules.SmallTopTopAppBar = require(_Package:WaitForChild("Molecules"):WaitForChild("AppBar"):WaitForChild("TopAppBar"):WaitForChild("SmallTop"))

sintesa.Molecules.LargeBadge = require(_Package:WaitForChild("Molecules"):WaitForChild("Badges"):WaitForChild("Large"))
sintesa.Molecules.SmallBadge = require(_Package:WaitForChild("Molecules"):WaitForChild("Badges"):WaitForChild("Small"))

sintesa.Molecules.ElevatedCommonButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Elevated"))
sintesa.Molecules.FilledCommonButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Filled"))
sintesa.Molecules.OutlinedCommonButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Outlined"))
sintesa.Molecules.TextCommonButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Text"))
sintesa.Molecules.TonalCommonButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Tonal"))
sintesa.Molecules.ExtendedFAB = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("ExtendedFAB"))
sintesa.Molecules.FAB = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("FAB"))
sintesa.Molecules.FilledIconButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Filled"))
sintesa.Molecules.FilledTonalIconButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("FilledTonal"))
sintesa.Molecules.OutlinedIconButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Outlined"))
sintesa.Molecules.StandardIconButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
sintesa.Molecules.SegmentedButton = require(_Package:WaitForChild("Molecules"):WaitForChild("Buttons"):WaitForChild("SegmentedButton"))

sintesa.Molecules.ElevatedCard = require(_Package:WaitForChild("Molecules"):WaitForChild("Cards"):WaitForChild("ElevatedCard"))
sintesa.Molecules.FilledCard = require(_Package:WaitForChild("Molecules"):WaitForChild("Cards"):WaitForChild("FilledCard"))
sintesa.Molecules.OutlinedCard = require(_Package:WaitForChild("Molecules"):WaitForChild("Cards"):WaitForChild("OutlinedCard"))

sintesa.Molecules.Checkbox = require(_Package:WaitForChild("Molecules"):WaitForChild("Checkbox"):WaitForChild("Checkbox"))

sintesa.Molecules.AssistChip = require(_Package:WaitForChild("Molecules"):WaitForChild("Chips"):WaitForChild("Assist"))
sintesa.Molecules.FilterChip = require(_Package:WaitForChild("Molecules"):WaitForChild("Chips"):WaitForChild("Filter"))
sintesa.Molecules.InputChip = require(_Package:WaitForChild("Molecules"):WaitForChild("Chips"):WaitForChild("Input"))
sintesa.Molecules.SuggestionChip = require(_Package:WaitForChild("Molecules"):WaitForChild("Chips"):WaitForChild("Suggestion"))

sintesa.Molecules.BasicDialog = require(_Package:WaitForChild("Molecules"):WaitForChild("Dialogs"):WaitForChild("Basic"))

sintesa.Molecules.Divider = require(_Package:WaitForChild("Molecules"):WaitForChild("Divider"))

sintesa.Molecules.Lists = require(_Package:WaitForChild("Molecules"):WaitForChild("Lists"))

sintesa.Molecules.Menus = require(_Package:WaitForChild("Molecules"):WaitForChild("Menus"))

sintesa.Molecules.NavigationBar = require(_Package:WaitForChild("Molecules"):WaitForChild("Navigation"):WaitForChild("NavigationBar"))
sintesa.Molecules.NavigationDrawer = require(_Package:WaitForChild("Molecules"):WaitForChild("Navigation"):WaitForChild("NavigationDrawer"))
sintesa.Molecules.NavigationRail = require(_Package:WaitForChild("Molecules"):WaitForChild("Navigation"):WaitForChild("NavigationRail"))

sintesa.Molecules.CircularProgressIndicator = require(_Package:WaitForChild("Molecules"):WaitForChild("ProgressIndicator"):WaitForChild("Circular"))
sintesa.Molecules.LinearProgressIndicator = require(_Package:WaitForChild("Molecules"):WaitForChild("ProgressIndicator"):WaitForChild("Linear"))

sintesa.Molecules.RadioButton = require(_Package:WaitForChild("Molecules"):WaitForChild("RadioButton"):WaitForChild("RadioButton"))

sintesa.Molecules.SearchBar = require(_Package:WaitForChild("Molecules"):WaitForChild("Search"):WaitForChild("SearchBar"))
sintesa.Molecules.SearchView = require(_Package:WaitForChild("Molecules"):WaitForChild("Search"):WaitForChild("SearchView"))

sintesa.Molecules.BottomSheets = require(_Package:WaitForChild("Molecules"):WaitForChild("Sheets"):WaitForChild("BottomSheet"))
sintesa.Molecules.SideSheets = require(_Package:WaitForChild("Molecules"):WaitForChild("Sheets"):WaitForChild("SideSheet"))

sintesa.Molecules.Slider = require(_Package:WaitForChild("Molecules"):WaitForChild("Slider"))
sintesa.Molecules.Snackbar = require(_Package:WaitForChild("Molecules"):WaitForChild("Snackbar"))

sintesa.Molecules.Switch = require(_Package:WaitForChild("Molecules"):WaitForChild("Switch"))

sintesa.Molecules.Tabs = require(_Package:WaitForChild("Molecules"):WaitForChild("Tabs"))

sintesa.Molecules.FilledTextField = require(_Package:WaitForChild("Molecules"):WaitForChild("TextField"):WaitForChild("Filled"))
sintesa.Molecules.OutlinedTextField = require(_Package:WaitForChild("Molecules"):WaitForChild("TextField"):WaitForChild("Outlined"))

sintesa.Molecules.PlainToolTip = require(_Package:WaitForChild("Molecules"):WaitForChild("Tooltips"):WaitForChild("Plain"))
sintesa.Molecules.RichToolTip = require(_Package:WaitForChild("Molecules"):WaitForChild("Tooltips"):WaitForChild("Rich"))

sintesa.InterfaceUtil = {}
sintesa.InterfaceUtil.ImageLabel = require(_Package:WaitForChild("Molecules"):WaitForChild("Util"):WaitForChild("ImageLabel"))
sintesa.InterfaceUtil.TextBox = require(_Package:WaitForChild("Molecules"):WaitForChild("Util"):WaitForChild("TextBox"))
sintesa.InterfaceUtil.TextLabel = require(_Package:WaitForChild("Molecules"):WaitForChild("Util"):WaitForChild("TextLabel"))
sintesa.InterfaceUtil.ViewportFrame = require(_Package:WaitForChild("Molecules"):WaitForChild("Util"):WaitForChild("ViewportFrame"))

return sintesa