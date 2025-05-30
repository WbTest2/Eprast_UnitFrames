local AddOnName, ns = ...;
local K, C, L = unpack(ns);

local statusbarOn = C.statusbarOn;
local darkFrames = C.darkFrames;
local statusbarTexture = C.statusbarTexture;
local PartyFrameOn = C.PartyFrameOn;
local ArenaFrameOn = C.ArenaFrameOn;
local Font, FontName = C.Font, C.FontName;
--------------------------------------------------------------------------------------------------------------------------------

local hooksecurefunc = hooksecurefunc;
local MAX_BOSS_FRAMES = MAX_BOSS_FRAMES;
local pairs, select, _G, unpack = pairs, select, _G, unpack;
local GetNumGroupMembers, GetRaidRosterInfo, tonumber, math_ceil, UnitPowerType, PowerBarColor, UnitName = GetNumGroupMembers, GetRaidRosterInfo, tonumber, math.ceil, UnitPowerType, PowerBarColor, UnitName;
local UnitIsDead, UnitIsGhost, UnitExists, UnitIsPlayer, UnitIsConnected = UnitIsDead, UnitIsGhost, UnitExists, UnitIsPlayer, UnitIsConnected;
--local string.lower = string_lower;
--------------------------------------------------------------------------------------------------------------------------------

-- Healthbar texture;
local SetStatusBar;
do
	local UnitFrames = {PlayerFrame, PetFrame, TargetFrame, FocusFrame, TargetFrameToT, FocusFrameToT};
	SetStatusBar = function()
		for _, frame in pairs(UnitFrames) do
			frame.healthbar:SetStatusBarTexture(statusbarTexture);
			if frame:GetName() == "PlayerFrame" then
				--select(6, frame:GetChildren()):SetStatusBarTexture(statusbarTexture); -- PlayerFrameAlternateManaBar;
			end;
		end;
		for i = 1, MAX_BOSS_FRAMES do
			_G["Boss"..i.."TargetFrame"].healthbar:SetStatusBarTexture(statusbarTexture);
		end;
		if PartyFrameOn then
			for i = 1, 4 do
				_G["PartyMemberFrame"..i].healthbar:SetStatusBarTexture(statusbarTexture);
			end;
		end;
		if ArenaFrameOn then
			for i = 1, MAX_ARENA_ENEMIES do
				_G["ArenaEnemyFrame"..i].healthbar:SetStatusBarTexture(statusbarTexture);
			end;
		end;
	end;
end;
if ( statusbarOn ) then SetStatusBar(); end;

-- Manabar texture;
function SetColorManaBar(manaBar)
	local powerType, powerToken, altR, altG, altB = UnitPowerType(manaBar.unit);
	local info = PowerBarColor[powerToken];
	if ( info ) then
		if ( not manaBar.lockColor ) then
			if not ( info.atlas ) then
				manaBar:SetStatusBarTexture(statusbarTexture);
			end;
		end;
	end;
end;
hooksecurefunc("UnitFrameManaBar_UpdateType", SetColorManaBar);
--------------------------------------------------------------------------------------------------------------------------------

-- FontString;
local function SetFontStringStyle(Obj, Font)
	if not Obj.healthbar then
		Obj.TextString:SetFont(unpack(Font));
		return;
	end;
	if Obj.healthbar.TextString then
		Obj.healthbar.TextString:SetFont(unpack(Font));
	end;	
	if Obj.manabar.TextString then
		Obj.manabar.TextString:SetFont(unpack(Font));
	end;
	if not Obj:GetName():find("Boss") then 
		Obj.name:SetFont(unpack(FontName));
	end;
end;

local GetFramesList;
do
	local UnitFrames = {PlayerFrame, TargetFrame, FocusFrame, PetFrame, PlayerFrameAlternateManaBar};
	local table_insert = table.insert;
	GetFramesList = function()
		if PartyFrameOn then
			for i = 1, 4 do
				table_insert(UnitFrames, _G["PartyMemberFrame"..i]);
			end;
		end;
		if ArenaFrameOn then
			for i = 1, MAX_ARENA_ENEMIES do
				table_insert(UnitFrames, _G["ArenaEnemyFrame"..i]);
			end;
		end;
		for i = 1, MAX_BOSS_FRAMES do
			table_insert(UnitFrames, _G["Boss"..i.."TargetFrame"]);
		end;
		return UnitFrames;
	end;
end;

for _, value in pairs(GetFramesList()) do
	SetFontStringStyle(value, Font);
end;
--------------------------------------------------------------------------------------------------------------------------------

-- GroupIndicator;
function SetGroupIndicator()
	local name, rank, subgroup;
	if ( not IsInRaid() ) then
		return;
	end;
	local NumRaidMembers = GetNumRaidMembers();
	for i = 1, MAX_RAID_MEMBERS do
		if ( i <= NumRaidMembers ) then
			name, rank, subgroup = GetRaidRosterInfo(i);
			if ( name == UnitName("player") ) then
				PlayerFrameGroupIndicatorText:SetText("G"..subgroup);
				PlayerFrameGroupIndicator:SetWidth(PlayerFrameGroupIndicatorText:GetWidth());-- +40);
				PlayerFrameGroupIndicator:Show();
			end;
		end;
	end;
end;
hooksecurefunc("PlayerFrame_UpdateGroupIndicator", SetGroupIndicator);
--------------------------------------------------------------------------------------------------------------------------------

local function SetValueDisplay(value, party)
	return ((value > 1e3 and value < 1e5 and party and format("%1.0f K", value / 1e3)) or
		   (value > 1e3 and value < 1e5 and format("%1.3f", value / 1e3)) or 
		   (value >= 1e5 and value < 1e6 and format("%1.0f K", value / 1e3)) or
		   (value >= 1e6 and value < 1e9 and format("%1.2f M", value / 1e6)) or
		   (value >= 1e9 and format("%1.1f M", value / m)) or value);
end;

-- Unit frames Status text reformat.
local function customStatusTex(self)
	if self:GetName():find("Raid") then return; end;
	------------------------------------------------
	local Text = self.TextString;
	local Value = self:GetValue();
	------------------------------------------------
	if Value and Value > 0 and Text then
		local _, MaxValue = self:GetMinMaxValues();
		if self:GetName():find("Party") then 
			Text:SetText(SetValueDisplay(Value, true).." / "..SetValueDisplay(MaxValue, true));
		else
			Text:SetText(SetValueDisplay(Value).." / "..SetValueDisplay(MaxValue));
		end;
	end
end;
--TextStatusBar_UpdateTextString
hooksecurefunc("TextStatusBar_UpdateTextString", customStatusTex);

--------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------
--	Check dead events.
---------------------------------------------------
------------------------------------------------------------------------------------------
local Core = CreateFrame("Frame");

function Core:RegisterEvents(...)
	for i = 1, select('#', ...) do
		self:RegisterEvent(select(i, ...));
	end;
end;
function Core:UnregisterEvents(...)
	for i = 1, select('#', ...) do
		self:UnregisterEvent(select(i, ...));
	end; 
end;

Core:RegisterEvents(
	"PLAYER_ENTERING_WORLD", 
	"PLAYER_DEAD", 
	"PLAYER_ALIVE", 
	"PLAYER_UNGHOST", 
	"UNIT_CONNECTION",
	"PLAYER_TARGET_CHANGED",
	"PLAYER_FOCUS_CHANGED",
	"UNIT_HEALTH"
);
Core:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...); end);
------------------------------------------------------------------------------------------

local UnitFrames = {
	["target"] = TargetFrame,
	["focus"] = FocusFrame,
};
if ( PartyFrameOn ) then
	for i = 1, 4 do
		UnitFrames["party"..i] = _G["PartyMemberFrame"..i];
	end;
end;

local function SetHealthBarFontAlpha(Obj, Alpha)
	local FrameList = {Obj.TextString};
	for _, value in pairs(FrameList) do
		if value then 
			value:SetAlpha(Alpha); 
		end;
	end;
end;

local function SetPlayerStatusText()
	local Frame = PlayerFrame;
	if UnitIsDead("player") then
		Frame.deadText:Show();
		Frame.ghostText:Hide();
	elseif UnitIsGhost("player") then
		Frame.deadText:Hide();
		Frame.ghostText:Show();
	elseif not (UnitIsDead("player") or UnitIsGhost("player")) then
		Frame.deadText:Hide();
		Frame.ghostText:Hide();
	end;
	if UnitExists("player") and UnitIsDead("player") or UnitIsGhost("player") then
		SetHealthBarFontAlpha(Frame.healthbar, 0);
	else
		SetHealthBarFontAlpha(Frame.healthbar, 1);
	end;
end;

local function SetUnitStatusText(unitID)
	--if unitID:find("party") then return; end;
	local Frame = UnitFrames[unitID];
	if UnitIsDead(unitID) then
		Frame.ghostText:Hide();
		Frame.offlineText:Hide();
		if Frame.deadText then Frame.deadText:Show(); end;
	elseif UnitIsGhost(unitID) then
		Frame.ghostText:Show();
		Frame.offlineText:Hide();
		if Frame.deadText then Frame.deadText:Hide(); end;
	elseif UnitIsPlayer(unitID) and not UnitIsConnected(unitID) then
		Frame.ghostText:Hide();
		Frame.offlineText:Show();
		if Frame.deadText then Frame.deadText:Hide(); end;
	else
		Frame.ghostText:Hide();
		Frame.offlineText:Hide();
		if Frame.deadText then Frame.deadText:Hide(); end;
	end;
	if UnitExists(unitID) and UnitIsDead(unitID) or UnitIsGhost(unitID) or not UnitIsConnected(unitID) then
		SetHealthBarFontAlpha(Frame.healthbar, 0);
	else
		SetHealthBarFontAlpha(Frame.healthbar, 1);
	end;
end;

function Core:PLAYER_ENTERING_WORLD()
	SetPlayerStatusText();
	if ( PartyFrameOn ) then
		for i = 1, 4 do
			SetUnitStatusText("party"..i);
		end;
	end;
end;

function Core:PLAYER_DEAD()
	SetPlayerStatusText();
end;

function Core:PLAYER_ALIVE()
	SetPlayerStatusText();
end;

function Core:PLAYER_UNGHOST()
	SetPlayerStatusText();
end;

function Core:UNIT_CONNECTION(unitTarget, isConnected)
	if not UnitFrames[unitTarget] then return; end;
	local Frame = UnitFrames[unitTarget];
	if not isConnected then 
		Frame.offlineText:Show();
		--StatusBar:SetValue(select(2, StatusBar:GetMinMaxValues()));
		Frame.ghostText:Hide();
		SetHealthBarFontAlpha(Frame.healthbar, 0);
	else
		Frame.offlineText:Hide();
		if UnitIsGhost(unitTarget) then 
			Frame.ghostText:Show(); 
			--StatusBar:SetValue(0);
			SetHealthBarFontAlpha(Frame.healthbar, 0);
		else
			SetHealthBarFontAlpha(Frame.healthbar, 1);
		end;
	end;
end;

function Core:PLAYER_TARGET_CHANGED()
	SetUnitStatusText("target");
end;

function Core:PLAYER_FOCUS_CHANGED()
	SetUnitStatusText("focus");
end;

function Core:UNIT_HEALTH(unitTarget)
	--if not UnitFrames[unitTarget] or not UnitFrames[unitTarget]:IsShown() or unitTarget:find("party") then return; end;
	if not UnitFrames[unitTarget] or not UnitFrames[unitTarget]:IsShown() then return; end;
	local Frame = UnitFrames[unitTarget];
	if UnitIsDead(unitTarget) then
		Frame.deadText:Show()
		SetHealthBarFontAlpha(Frame.healthbar, 0);
	elseif Frame.deadText:IsShown() then
		Frame.deadText:Hide()
		SetHealthBarFontAlpha(Frame.healthbar, 1);
	end;
	if UnitIsGhost(unitTarget) then
		Frame.ghostText:Show();
		SetHealthBarFontAlpha(Frame.healthbar, 0);
	elseif Frame.ghostText:IsShown() then
		Frame.ghostText:Hide();
		SetHealthBarFontAlpha(Frame.healthbar, 1);
	end;
end;
--]]
--[[
function Core:PLAYER_FLAGS_CHANGED(unitTarget)
	if not UnitFrames[unitTarget] then return; end;
	local StatusBar = UnitFrames[unitTarget].healthbar;
	if UnitIsGhost(unitTarget) then
		StatusBar.ghostText:Show();
		SetHealthBarFontAlpha(StatusBar, 0);
	else
		StatusBar.ghostText:Hide();
		SetHealthBarFontAlpha(StatusBar, 1);
	end;
end;
--]]

--]]
