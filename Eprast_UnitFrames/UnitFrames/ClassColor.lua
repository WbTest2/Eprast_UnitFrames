local AddOnName, ns = ...;
local K, C, L = unpack(ns);

local classColor = C["classColor"];
local reactionColor = true;

--------------------------------------------------------------------------------------------------------------------------------
local hooksecurefunc, unpack = hooksecurefunc, unpack;
local UnitIsPlayer, UnitClass, UnitIsConnected, UnitExists, UnitReaction  = UnitIsPlayer, UnitClass, UnitIsConnected, UnitExists, UnitReaction;
local UnitIsTapped, UnitIsTappedByPlayer, UnitIsTappedByAllThreatList = UnitIsTapped, UnitIsTappedByPlayer, UnitIsTappedByAllThreatList;
local CUSTOM_CLASS_COLORS, RAID_CLASS_COLORS, FACTION_BAR_COLORS = CUSTOM_CLASS_COLORS, RAID_CLASS_COLORS, FACTION_BAR_COLORS;
--------------------------------------------------------------------------------------------------------------------------------

--	Player class colors HP.
function unitClassColors(healthbar, unit)
	if UnitIsPlayer(unit) and unit == healthbar.unit and UnitClass(unit) and classColor then
		if not UnitIsConnected(unit) then
			healthbar:SetStatusBarColor(0.6, 0.6, 0.6, 0.5);
			return;
		end;
		
		local _, class = UnitClass(unit);
		local color = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class];
		healthbar:SetStatusBarColor(color.r, color.g, color.b);
	end;
end;
hooksecurefunc("UnitFrameHealthBar_Update", unitClassColors);
hooksecurefunc("HealthBar_OnValueChanged", function(self)
	unitClassColors(self, self.unit);
end);

--	Сustoms target unit reactions HP colors.
local function npcReactionColors(healthbar, unit)
	--if not unit or unit:find("boss") then return; end;
	if UnitExists(unit) and not UnitIsPlayer(unit) and unit == healthbar.unit and ( not UnitPlayerControlled(unit) and UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) and not UnitIsTappedByAllThreatList(unit) ) then
		healthbar:SetStatusBarColor(0.5, 0.5, 0.5);	-- Gray if npc is tapped by other player
	elseif UnitExists(unit) and not UnitIsPlayer(unit) and unit == healthbar.unit and reactionColor then
		local reaction = FACTION_BAR_COLORS[UnitReaction(unit,"player")];
		if reaction then
			healthbar:SetStatusBarColor(reaction.r, reaction.g, reaction.b);
		elseif not reaction then
			healthbar:SetStatusBarColor(0, 0.6, 0.1);
		end;
	end;
end;
hooksecurefunc("UnitFrameHealthBar_Update", npcReactionColors);
hooksecurefunc("HealthBar_OnValueChanged", function(self)
	npcReactionColors(self, self.unit);
end);