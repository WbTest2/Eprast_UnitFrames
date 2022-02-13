local AddOnName, ns = ...;
local K, C, L = unpack(ns);

if ( not C.PartyFrameOn ) then return; end;

local Scale = C.PartyFrameScale;
local Font = C.PartyFrameFont;
local darkFrames = C.darkFrames;
local Spacing = C.PartyMemberFrameSpacing;

--------------------------------------------------------------------------------------------------------------------------------
local _G, unpack = _G, unpack;
local hooksecurefunc = hooksecurefunc;
local UnitFactionGroup, UnitIsPVPFreeForAll, UnitIsPVP, UnitPowerMax = UnitFactionGroup, UnitIsPVPFreeForAll, UnitIsPVP, UnitPowerMax;
--------------------------------------------------------------------------------------------------------------------------------

local EprastPartyFrame;
local Path;
do
	if ( C.SetPositions ) then
		EprastPartyFrame = CreateFrame("Frame", nil, UIParent);
		EprastPartyFrame:SetSize(10, 10);
		EprastPartyFrame:SetFrameStrata(PartyMemberFrame1:GetFrameStrata());
		K.EprastPartyFrame = EprastPartyFrame;
	end;
	if ( darkFrames ) then 
		Path = "Interface\\Addons\\"..AddOnName.."\\Media\\Dark\\";
	else
		Path = "Interface\\Addons\\"..AddOnName.."\\Media\\Light\\";
	end;
end;

--	Party frame
local function Eprast_UnitFrames_Style_PartyMemberFrame(id)
	_G["PartyMemberFrame"..id]:SetScale(Scale);
	_G["PartyMemberFrame"..id.."Texture"]:SetTexture(Path.."UI-PartyFrame");
	_G["PartyMemberFrame"..id.."HealthBarText"]:ClearAllPoints();
	_G["PartyMemberFrame"..id.."HealthBarText"]:SetPoint("CENTER", _G["PartyMemberFrame"..id], "CENTER", 19, 10);
	_G["PartyMemberFrame"..id.."HealthBarText"]:SetFont(unpack(Font));
	_G["PartyMemberFrame"..id.."ManaBarText"]:SetFont(unpack(Font));
	
	-- SetPosition PartyMemberFrame; --
	if  ( not C.SetPositions ) then return; end;
	_G["PartyMemberFrame"..id]:ClearAllPoints();
	_G["PartyMemberFrame"..id]:SetParent(EprastPartyFrame);
	if ( id == 1 ) then
		_G["PartyMemberFrame"..id]:SetPoint("TOPLEFT", EprastPartyFrame, "TOPLEFT");
	else
		_G["PartyMemberFrame"..id]:SetPoint("TOPLEFT", _G["PartyMemberFrame"..(id - 1).."PetFrame"], "BOTTOMLEFT", -23, -10 + Spacing);
	end;
end;
for i = 1, MAX_PARTY_MEMBERS do
	Eprast_UnitFrames_Style_PartyMemberFrame(i);
end;

local function partyPvpIcon(self)
	local id = self:GetID();
	local unit = "party"..id;
	local icon = _G["PartyMemberFrame"..id.."PVPIcon"];
	local factionGroup = UnitFactionGroup(unit);
	if ( UnitIsPVPFreeForAll(unit) ) then
		icon:SetTexture(Path.."UI-PVP-FFA");
	elseif ( factionGroup and UnitIsPVP(unit) ) then
		icon:SetTexture(Path.."UI-PVP-"..factionGroup);
	end
end;
hooksecurefunc("PartyMemberFrame_UpdatePvPStatus", partyPvpIcon);

-- PetFrame;
local function Eprast_UnitFrames_PartyMemberFrame_UpdatePet(self, id)
	if ( id ) then return; end;
	_G[self:GetName().."PetFrameTexture"]:SetTexture(Path.."UI-PartyFrame");
end;
hooksecurefunc("PartyMemberFrame_UpdatePet", Eprast_UnitFrames_PartyMemberFrame_UpdatePet);