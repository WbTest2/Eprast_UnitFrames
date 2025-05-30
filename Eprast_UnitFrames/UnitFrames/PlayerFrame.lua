local AddOnName, ns = ...;
local K, C, L = unpack(ns);

local darkFrames = C.darkFrames;
local SetPositions = C.SetPositions;
local statusbarTexture = C.statusbarTexture;
local PlayerNameOffset = C.PlayerNameOffset;
local Font = C.Font;
--------------------------------------------------------------------------------------------------------------------------------
local hooksecurefunc = hooksecurefunc;
local UnitFactionGroup, UnitIsPVP, UnitIsVisible, UnitPowerMax = UnitFactionGroup, UnitIsPVP, UnitIsVisible, UnitPowerMax;
local unpack = unpack;
--------------------------------------------------------------------------------------------------------------------------------

K.MoveFrame(PlayerFrame, "EprastPlayerFrame", "Player", 105, 27);	--	Move PlayerFrame;


local Path = (darkFrames and "Dark") or "Light";

---------------------------------------------------
--	Player frame.
---------------------------------------------------
local function SetStyleGroupIndicator(Left, Right)
	if darkFrames then
		Left:SetVertexColor(119/255, 119/255, 119/255, 0.7);
		Right:SetVertexColor(119/255, 119/255, 119/255, 0.7);
	else
		Left:SetAlpha(0.7);
		Right:SetAlpha(0.7);
	end;
	Left:SetPoint(K.SetOffset(Left, 0, -4));
	Right:SetPoint(K.SetOffset(Right, 0, -4));
	Left:SetHeight(22);
	Right:SetHeight(22);
end;

local function Eprast_UnitFrames_Style_PlayerFrame(self)
	PlayerStatusTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\UI-Player-Status2");
	PlayerStatusTexture:ClearAllPoints();
	PlayerStatusTexture:SetPoint("CENTER", EprastPlayerFrame, "CENTER", 16, 8);
	PlayerFrameGroupIndicatorText:ClearAllPoints();
	PlayerFrameGroupIndicatorText:SetPoint("CENTER", EprastPlayerFrame,"TOP",-41,-7);
	PlayerFrameGroupIndicatorLeft:ClearAllPoints();
	PlayerFrameGroupIndicatorLeft:SetPoint("BOTTOMLEFT", EprastPlayerFrame,"TOP",-65,-13);
	PlayerFrameGroupIndicatorRight:ClearAllPoints();
	PlayerFrameGroupIndicatorRight:SetPoint("BOTTOMLEFT", EprastPlayerFrame,"TOP",-41,-13);
	
	-- playerFrameSelector;
	PlayerFrameTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\"..Path.."\\UI-TargetingFrame");
	PlayerPVPIcon:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\"..Path.."\\UI-PVP-FFA");
	PlayerFrameAlternateManaBarBorder:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\"..Path.."\\numeric");
	SetStyleGroupIndicator(PlayerFrameGroupIndicatorLeft, PlayerFrameGroupIndicatorRight);				-- Set Color GroupIndicator;
	K.CreateFont(self, self.healthbar, "deadText", Font, 0, -6, L.DeadText, false);		-- Create deadText;	[GameFontNormalSmall]
	K.CreateFont(self, self.healthbar, "ghostText", Font, 0, -6, L.GhostText, false);	-- Create ghostText;
end;
Eprast_UnitFrames_Style_PlayerFrame(PlayerFrame);

local function Eprast_UnitFrames_PlayerFrame_ToPlayerArt(self)
	--PlayerFrameBackground:SetWidth(120);
	self.name:SetPoint(K.SetOffset(self.name, unpack(PlayerNameOffset)));
	self.healthbar:SetPoint("TOPLEFT", 106, -24);
	self.healthbar:SetHeight(28);
	self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, -6);	-- 0  0
	RuneFrame:ClearAllPoints();											-- DK RUNES;
	RuneFrame:SetPoint("TOP", EprastPlayerFrame, "BOTTOM", 52, 34);		-- DK RUNES;

	PlayerFrameFlash:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
	PlayerFrameFlash:SetTexCoord(0.9453125, 0, 0, 0.181640625);
end;
hooksecurefunc("PlayerFrame_ToPlayerArt", Eprast_UnitFrames_PlayerFrame_ToPlayerArt);

function playerPvpIcon()
	local factionGroup = UnitFactionGroup("player");
	if ( UnitIsPVPFreeForAll("player") ) then
		PlayerPVPIcon:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\"..Path.."\\UI-PVP-FFA")
	elseif ( factionGroup and factionGroup ~= "Neutral" and UnitIsPVP("player") ) then
		PlayerPVPIcon:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\"..Path.."\\UI-PVP-"..factionGroup);
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
		if ( UnitIsVisible(self.unit) --[[and PetUsesPetFrame()--]] and not PlayerFrame.vehicleHidesPet ) then
			if ( UnitPowerMax(self.unit) == 0 ) then
				PetFrameTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\"..Path.."\\UI-SmallTargetingFrame-NoMana");
				PetFrameManaBarText:Hide();
			else
				PetFrameTexture:SetTexture("Interface\\Addons\\"..AddOnName.."\\Media\\"..Path.."\\UI-SmallTargetingFrame");
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