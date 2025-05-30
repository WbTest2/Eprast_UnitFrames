local AddOnName, ns = ...;
local K, C, L = unpack(ns);

if ( not C.ArenaFrameOn ) or ( not C.ArenaFrame_Trinkets) then return; end;

local darkFrames = C.darkFrames;

--------------------------------------------------------------------------------------------------------------------------------
local select, pairs, _G, UnitFactionGroup, IsInInstance, GetSpellInfo, GetTime = select, pairs, _G, UnitFactionGroup, IsInInstance, GetSpellInfo, GetTime;
local string_sub, tonumber, CooldownFrame_SetTimer = string.sub, tonumber, CooldownFrame_SetTimer;
--------------------------------------------------------------------------------------------------------------------------------

ns.ArenaFrame_Trinkets = CreateFrame("Frame");
local Core = ns.ArenaFrame_Trinkets;
Core:RegisterEvent("ADDON_LOADED");
Core:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end);

function Core:CreateTrinket(Frame, Index)
	local Border = CreateFrame("Frame", nil, Frame);
	Border:SetFrameStrata("MEDIUM");
	Border:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", -22, -11) ;
	Border:SetSize(32, 32);
	Border:SetBackdrop({bgFile = "Interface\\CharacterFrame\\TotemBorder"});
	if ( darkFrames ) then 
		Border:SetBackdropColor(0.2, 0.2, 0.2, 1);
	end;

	local Trinket = CreateFrame("Frame", nil, Frame);
	Trinket:SetFrameStrata("MEDIUM");
	Trinket:SetFrameLevel(Border:GetFrameLevel() - 2);
	Trinket:SetPoint("CENTER", Border, 0, 0) ;
	Trinket:SetSize(18, 18);
	Trinket.icon = Trinket:CreateTexture(nil, "BACKGROUND ");
	Trinket.icon:SetAllPoints();
	
	if select(1, UnitFactionGroup("player")) == "Alliance" then
		Trinket.icon:SetTexture("Interface\\Icons\\inv_jewelry_trinketpvp_01");
	elseif select(1, UnitFactionGroup("player")) == "Horde" then
		Trinket.icon:SetTexture("Interface\\Icons\\inv_jewelry_trinketpvp_02");
	end;
	local CoolDownFrame = CreateFrame("Cooldown", nil, Trinket, "CooldownFrameTemplate")
	Core["arena"..Index] = CoolDownFrame;
end;

function Core:ADDON_LOADED(addonName)
	if addonName ~= "Blizzard_ArenaUI" then return; end;
	local MAX_ARENA_ENEMIES = MAX_ARENA_ENEMIES;
	for i = 1, MAX_ARENA_ENEMIES do
		self:CreateTrinket(_G["ArenaEnemyFrame"..i], i);
	end;
	self:UnregisterEvent("ADDON_LOADED");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end;

function Core:PLAYER_ENTERING_WORLD()
local _, instanceType = IsInInstance();
	if instanceType == "arena" then  
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	elseif self:IsEventRegistered("UNIT_SPELLCAST_SUCCEEDED") then  
		self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		for i = 1, MAX_ARENA_ENEMIES do
			CooldownFrame_SetTimer(self["arena"..i], GetTime(), 0, 1);
		end;
	end;
end;

local PlaySoundFile = PlaySoundFile;
local Voice = C.ArenaFrame_Trinket_Voice;
function Core:UNIT_SPELLCAST_SUCCEEDED(unitID, spell)  
	if not unitID:find("arena") or unitID:find("pet") then return; end;
	if not self[unitID] then return end;
	if  spell == GetSpellInfo(59752) or spell == GetSpellInfo(42292) then
		CooldownFrame_SetTimer(self[unitID], GetTime(), 120, 1);
		if ( Voice ) then PlaySoundFile("Interface\\Addons\\"..AddOnName.."\\Media\\Voice\\Trinket.mp3"); end;
	elseif spell == GetSpellInfo(7744) then
		CooldownFrame_SetTimer(self[unitID], GetTime(), 45, 1);
		if ( Voice ) then PlaySoundFile("Interface\\Addons\\"..AddOnName.."\\Media\\Voice\\WillOfTheForsaken.mp3"); end;
	end;
end;