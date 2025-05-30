local AddOnName, ns = ...;
local K, C, L = unpack(ns);

if ( not C.HealthPercentage ) then return; end; 

local darkFrames = C.darkFrames;

local Font = {"Interface\\AddOns\\"..AddOnName.."\\Media\\Fonts\\PTSansNarrow.ttf", 12, "OUTLINE"}
local FontColor = {255/255, 218/255, 42/255, 1};
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

local pairs, select, UnitClass = pairs, select, UnitClass;
local UnitClass		=	UnitClass;
local math_ceil		=	math.ceil;
local hooksecurefunc = hooksecurefunc;

local Core = CreateFrame("FRAME","TargetFramePercent",TargetFrameTextureFrame);
Core:RegisterEvent("ADDON_LOADED");
Core:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end);

function Core:CreateMainFrame()
	self:SetSize(60, 32);
	self:Show();
	self.edge = self:CreateTexture(nil, "ARTWORK");
	self.edge:SetTexture([[Interface\TARGETINGFRAME\NumericThreatBorder]]);
	self.edge:SetPoint("CENTER", TargetFrame, "CENTER", -77.87, 30.48);
	self.edge:SetSize(60, 32);
	if darkFrames then self.edge:SetVertexColor(119/255, 119/255, 119/255, 1); end;	
	
    self.Backdrop = self:CreateTexture(nil, "BACKGROUND");
    self.Backdrop:SetPoint("TOPLEFT",self.edge, "TOPLEFT", 5, -3);
    self.Backdrop:SetPoint("BOTTOMRIGHT",self.edge, "BOTTOMRIGHT", -19, 13);
    self.Backdrop:SetTexture([[Interface\BUTTONS\WHITE8X8]]);
    self.Backdrop:SetVertexColor(0, 0, 0, 0.8);
	
	self.Text = self:CreateFontString(nil,"OVERLAY");
	self.Text:SetFont(unpack(Font));
	self.Text:SetTextColor(unpack(FontColor));
	self.Text:SetPoint("CENTER", self.Backdrop, "CENTER", 0, 0);
end;

function Core:ADDON_LOADED(addonName)
	self:UnregisterEvent("ADDON_LOADED");
	
	TargetFrameNumericalThreat:ClearAllPoints();			--	|Сдвигаем стандартный	|
	TargetFrameNumericalThreat:SetPoint("TOPLEFT",68,-4);	--	|агроиндикатор таргета;	|
	TargetFrameNumericalThreat:SetFrameLevel(TargetFrameTextureFrame:GetFrameLevel()-1);
	select(2, TargetFrameNumericalThreat:GetRegions()):SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\Statusbar\\whoa");
	FocusFrameNumericalThreat:SetFrameLevel(FocusFrameTextureFrame:GetFrameLevel()-1);
	select(2, FocusFrameNumericalThreat:GetRegions()):SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\Statusbar\\whoa");
	
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
	if HealthPercent < Core["ExecutePhase"] and select(1, Core.Backdrop:GetVertexColor()) == 0 then
		Core.Backdrop:SetVertexColor(1, 0, 0, .8);
	elseif HealthPercent >= Core["ExecutePhase"] and select(1, Core.Backdrop:GetVertexColor()) ~= 0 then
		Core.Backdrop:SetVertexColor(0, 0, 0, .8);
	end;
end;
hooksecurefunc("TextStatusBar_UpdateTextString", TextStatusBar_Update);