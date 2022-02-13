local AddOnName, ns = ...;
local K, C, L = unpack(ns);

local statusbarOn = C.statusbarOn;
local darkFrames = C.darkFrames;
local statusbarTexture = C.statusbarTexture;
local TargetNameOffset = C.TargetNameOffset;

--------------------------------------------------------------------------------------------------------------------------------
local hooksecurefunc = hooksecurefunc;
local unpack, _G = unpack, _G;
local UnitClassification, UnitFactionGroup, UnitIsPVPFreeForAll, UnitPowerType = UnitClassification, UnitFactionGroup, UnitIsPVPFreeForAll, UnitPowerType;
--------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------
--	Target frame
---------------------------------------------------
local function Eprast_UnitFrames_Style_TargetFrame(self)
	self.highLevelTexture:ClearAllPoints();
	self.highLevelTexture:SetPoint("CENTER", self.levelText, "CENTER", 1, 0);
	self.deadText:SetPoint("CENTER", self.healthbar, "CENTER", 0, -5);
	self.nameBackground:Hide();
	self.name:SetPoint(K.SetOffset(self.name, unpack(TargetNameOffset)));
	
	--self.healthbar:SetSize(119, 28);
	self.healthbar:SetHeight(28);
	self.healthbar:SetPoint("TOPLEFT", 5, -24);
	self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, -5);
	--self.manabar.TextString:SetPoint("CENTER", self.manabar, "CENTER", 0, 0);
	
	self.healthbar.lockColor = true;
	if ( statusbarOn ) then
		self.healthbar:SetStatusBarTexture(statusbarTexture);
		self.manabar:SetStatusBarTexture(statusbarTexture);
	end;
end;
Eprast_UnitFrames_Style_TargetFrame(TargetFrame);
Eprast_UnitFrames_Style_TargetFrame(FocusFrame);

local Path;
do
	if ( darkFrames ) then
		Path = "Interface\\Addons\\"..AddOnName.."\\Media\\Dark\\";
	else
		Path = "Interface\\Addons\\"..AddOnName.."\\Media\\Light\\";
	end;
end;

local function Eprast_UnitFrames_TargetFrame_CheckClassification (self, forceNormalTexture)
	local texture;
	local classification = UnitClassification(self.unit);
	if classification == "worldboss" or classification == "elite" then
		texture = Path.."UI-TargetingFrame-Elite";
	elseif classification == "rareelite" then
		texture = Path.."UI-TargetingFrame-Rare-Elite";
	elseif classification == "rare" then
		texture = Path.."UI-TargetingFrame-Rare";
	end;
	if texture and not forceNormalTexture then
		self.borderTexture:SetTexture(texture);
	else
		self.borderTexture:SetTexture(Path.."UI-TargetingFrame");
	end;
end;
hooksecurefunc("TargetFrame_CheckClassification", Eprast_UnitFrames_TargetFrame_CheckClassification);

local function Eprast_UnitFrames_TargetFrame_CheckFaction(self)
	if ( self.showPVP ) then
		local factionGroup = UnitFactionGroup(self.unit);
		if ( UnitIsPVPFreeForAll(self.unit) ) then
			self.pvpIcon:SetTexture(Path.."UI-PVP-FFA");
			self.pvpIcon:Show();
		elseif ( factionGroup and factionGroup ~= "Neutral" and UnitIsPVP(self.unit) ) then
			self.pvpIcon:SetTexture(Path.."UI-PVP-"..factionGroup);
			self.pvpIcon:Show();
		else
			self.pvpIcon:Hide();
		end;
	end;
end;
hooksecurefunc("TargetFrame_CheckFaction", Eprast_UnitFrames_TargetFrame_CheckFaction);

---------------------------------------------------
--	ToT & ToF
---------------------------------------------------
local function Eprast_UnitFrames_Style_ToTF(self)
	_G[self:GetName().."TextureFrameTexture"]:SetTexture(Path.."UI-TargetofTargetFrame");
	self.deadText:ClearAllPoints();
	self.deadText:SetPoint("CENTER", self:GetName().."HealthBar", "CENTER", 1, 0);
	self.name:SetSize(65, 10);
	self.healthbar:ClearAllPoints();
	self.healthbar:SetPoint("TOPLEFT", 45, -15);
	self.healthbar:SetHeight(10);
	self.manabar:ClearAllPoints();
	self.manabar:SetPoint("TOPLEFT", 45, -25);
	self.manabar:SetHeight(5);
	self.background:SetSize(50, 14);
	self.background:ClearAllPoints();
	self.background:SetPoint("CENTER", self, "CENTER", 20, 0);
end;
Eprast_UnitFrames_Style_ToTF(TargetFrameToT);
Eprast_UnitFrames_Style_ToTF(FocusFrameToT);

---------------------------------------------------
-- Focus frame
---------------------------------------------------
local function Eprast_UnitFrames_Style_FocusFrame()
	FocusFrame:SetScale(C.FocusScale);
	FocusFrameSpellBar:SetScale(C.FocusSpellBarScale);
	if ( C.FocusAuraLimit ) then
		FocusFrame.maxDebuffs = C.Focus_maxDebuffs;
		FocusFrame.maxBuffs = C.Focus_maxBuffs;
	end;
end;
Eprast_UnitFrames_Style_FocusFrame();

---------------------------------------------------
--	Create Backdrop
---------------------------------------------------
if ( C.statusbarBackdrop ) then
	K.CreateBackdrop(TargetFrame);
	K.CreateBackdrop(FocusFrame);
end;



