local AddOnName, ns = ...;
local K, C, L = unpack(ns);

if ( not C.HealthPercentage ) then return; end; 


local ExecutePhase = {
	["MAGE"]		=	0,
	["PRIEST"]		=	0,
	["WARLOCK"]		=	25,
	["DRUID"]		=	0,
	["ROGUE"]		=	0,
	["HUNTER"]		=	20,
	["SHAMAN"]		=	0,
	["DEATHKNIGHT"]	=	0,
	["PALADIN"]		=	20,
	["WARRIOR"]		=	20,
};

local select		=	select;
local UnitClass		=	UnitClass;
local math_ceil		=	math.ceil;
local hooksecurefunc = hooksecurefunc;

local Core = CreateFrame("FRAME","TargetFramePercent",TargetFrameTextureFrame);
Core:RegisterEvent("ADDON_LOADED");
Core:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end);

function Core:CreateMainFrame()
	self:SetSize(46, 19);
	--self:SetBackdrop({bgFile = [[Interface\Tooltips\UI-Tooltip-Background]]});
	self:SetBackdrop({bgFile = "Interface\\Addons\\"..AddOnName.."\\Media\\Statusbar\\whoa"});
	self:SetPoint("TOPLEFT", 17, -2);
	self:SetFrameLevel(TargetFrameTextureFrame:GetFrameLevel()-1);
	self:Show();
	self.edge = self:CreateTexture(nil, "ARTWORK");
	self.edge:SetTexture([[Interface\TARGETINGFRAME\NumericThreatBorder]]);
	self.edge:SetPoint("TOPLEFT", self, "TOPLEFT", -8, 3); -- -8 3
	self.edge:SetSize(80, 40);
	self.Text = self:CreateFontString(nil,"OVERLAY","GameFontNormal");
	self.Text:SetPoint("CENTER",0, 0);
end;

function Core:ADDON_LOADED(addonName)
	self:UnregisterEvent("ADDON_LOADED");
	
	TargetFrameNumericalThreat:ClearAllPoints();			--	|Сдвигаем стандартный	|
	TargetFrameNumericalThreat:SetPoint("TOPLEFT",68,-4);	--	|агроиндикатор таргета;	|
	TargetFrameNumericalThreat:SetFrameLevel(TargetFrameTextureFrame:GetFrameLevel()-1);
	select(2, TargetFrameNumericalThreat:GetRegions()):SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\Statusbar\\whoa");
	FocusFrameNumericalThreat:SetFrameLevel(FocusFrameTextureFrame:GetFrameLevel()-1);
	
	self:CreateMainFrame();
	for Key, Value in pairs(ExecutePhase) do
		if Key == select(2, UnitClass("player")) then self["ExecutePhase"] = Value; break; end;
	end;
end;


local function TextStatusBar_Update(self)
	if self ~= TargetFrameHealthBar then return end;
	local Value = self.currValue;
	local _, MaxValue = self:GetMinMaxValues();
	local HealthPercent = (Value / MaxValue)*100;
	if Value == 0 then
		Core.Text:SetText("Dead");
	else
		Core.Text:SetText(math_ceil(HealthPercent).."%");
	end;
	if HealthPercent < Core["ExecutePhase"] and select(1, Core:GetBackdropColor()) == 0 then
		Core:SetBackdropColor(1, 0, 0, .8);
	elseif HealthPercent >= Core["ExecutePhase"] and select(1, Core:GetBackdropColor()) ~= 0 then
		Core:SetBackdropColor(0, 0, 0, .8);
	end;
end;
hooksecurefunc("TextStatusBar_UpdateTextString", TextStatusBar_Update);