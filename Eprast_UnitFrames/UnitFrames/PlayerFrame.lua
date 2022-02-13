local AddOnName, ns = ...;
local K, C, L = unpack(ns);

local statusbarOn = C.statusbarOn;
local darkFrames = C.darkFrames;
local SetPositions = C.SetPositions;
local statusbarTexture = C.statusbarTexture;
local PlayerNameOffset = C.PlayerNameOffset;

--------------------------------------------------------------------------------------------------------------------------------
local hooksecurefunc = hooksecurefunc;
local UnitFactionGroup, UnitIsPVP, UnitIsVisible, UnitPowerMax = UnitFactionGroup, UnitIsPVP, UnitIsVisible, UnitPowerMax;
local unpack = unpack;
--------------------------------------------------------------------------------------------------------------------------------

K.MoveFrame(PlayerFrame, "EprastPlayerFrame", "Player", 105, 27);	--	Move PlayerFrame;

---------------------------------------------------
--	Player frame.
---------------------------------------------------
local function Eprast_UnitFrames_Style_PlayerFrame(self)
	if ( statusbarOn ) then
		self.healthbar:SetStatusBarTexture(statusbarTexture);
		self.manabar:SetStatusBarTexture(statusbarTexture);
	end;
	PlayerStatusTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\UI-Player-Status2");
	PlayerStatusTexture:ClearAllPoints();
	PlayerStatusTexture:SetPoint("CENTER", EprastPlayerFrame, "CENTER", 16, 8);
	PlayerFrameGroupIndicatorText:ClearAllPoints();
	PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT", EprastPlayerFrame, "TOP", 0, -20);
	PlayerFrameGroupIndicatorLeft:Hide();
	PlayerFrameGroupIndicatorMiddle:Hide();
	PlayerFrameGroupIndicatorRight:Hide();
	-- playerFrameSelector;
	if ( darkFrames ) then
		PlayerFrameTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\Dark\\UI-TargetingFrame");
		PlayerPVPIcon:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\Dark\\UI-PVP-FFA");
	else
		PlayerFrameTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\Light\\UI-TargetingFrame");
		PlayerPVPIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
	end;
end;
Eprast_UnitFrames_Style_PlayerFrame(PlayerFrame);

local function Eprast_UnitFrames_PlayerFrame_ToPlayerArt(self)
	--PlayerFrameBackground:SetWidth(120);
	self.name:SetPoint(K.SetOffset(self.name, unpack(PlayerNameOffset)));
	self.healthbar:SetPoint("TOPLEFT", 106, -24);
	self.healthbar:SetHeight(28);
	self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, -5);	-- 0  0
	RuneFrame:ClearAllPoints();											-- DK RUNES;
	RuneFrame:SetPoint("TOP", EprastPlayerFrame, "BOTTOM", 52, 34);		-- DK RUNES;

	PlayerFrameFlash:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
	PlayerFrameFlash:SetTexCoord(0.9453125, 0, 0, 0.181640625);
end;
hooksecurefunc("PlayerFrame_ToPlayerArt", Eprast_UnitFrames_PlayerFrame_ToPlayerArt);

function playerPvpIcon()
	local factionGroup = UnitFactionGroup("player");
	if ( factionGroup and factionGroup ~= "Neutral" and UnitIsPVP("player") ) then
		if ( darkFrames ) then
			PlayerPVPIcon:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\Dark\\UI-PVP-"..factionGroup);
		else
			PlayerPVPIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
		end;
	end;
end;
hooksecurefunc("PlayerFrame_UpdatePvPStatus", playerPvpIcon);

---------------------------------------------------
--	Player vehicle frame.
---------------------------------------------------
local function Eprast_UnitFrames_PlayerFrame_ToVehicleArt(self, vehicleType)
	if ( vehicleType == "Natural" ) then
		PlayerFrameFlash:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\Vehicles\\UI-Vehicle-Frame-Organic-Flash");
		PlayerFrameFlash:SetTexCoord(-0.02, 1, 0.07, 0.86);
		self.healthbar:SetSize(103, 12);
	else
		PlayerFrameFlash:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame-Flash");
		PlayerFrameFlash:SetTexCoord(-0.02, 1, 0.07, 0.86);
		self.healthbar:SetSize(100, 12);
	end;
	self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
end;
hooksecurefunc("PlayerFrame_ToVehicleArt", Eprast_UnitFrames_PlayerFrame_ToVehicleArt);

---------------------------------------------------
-- Pet frame
---------------------------------------------------
local function Eprast_UnitFrames_PetFrame_Update(self, override)
	if ( (not PlayerFrame.animating) or (override) ) then
		if ( UnitIsVisible(self.unit) and not PlayerFrame.vehicleHidesPet ) then
			if ( UnitPowerMax(self.unit) == 0 ) then
				if ( darkFrames ) then
					PetFrameTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\\Dark\\UI-SmallTargetingFrame-NoMana");
				else
					PetFrameTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\\Light\\UI-SmallTargetingFrame-NoMana");
				end;
				PetFrameManaBarText:Hide();
			else
				if ( darkFrames ) then
					PetFrameTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\\Dark\\UI-SmallTargetingFrame");
				else
					PetFrameTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\\Light\\UI-SmallTargetingFrame");
				end;
			end;
		end;
	end;
end;
hooksecurefunc("PetFrame_Update", Eprast_UnitFrames_PetFrame_Update);

---------------------------------------------------
-- Backdrop;
---------------------------------------------------
if ( C.statusbarBackdrop ) then
	K.CreateBackdrop(PlayerFrame);
end;