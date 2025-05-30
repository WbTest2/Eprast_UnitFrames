local AddOnName, ns = ...;
local K, C, L = unpack(ns);

local darkFrames = C.darkFrames;
local SetPositions = C.SetPositions
local statusbarTexture = C.statusbarTexture;

--------------------------------------------------------------------------------------------------------------------------------
local hooksecurefunc = hooksecurefunc;
local MAX_BOSS_FRAMES = MAX_BOSS_FRAMES;
local _G = _G;
--------------------------------------------------------------------------------------------------------------------------------

local EprastBossFrame = CreateFrame("Frame", nil, UIParent);
EprastBossFrame:SetSize(10, 10);
K.EprastBossFrame = EprastBossFrame;

local Path = (darkFrames and "Interface\\Addons\\"..AddOnName.."\\Media\\Dark\\") or "Interface\\Addons\\"..AddOnName.."\\Media\\Light\\";

local function Eprast_UnitFrames_Style_BossFrame(self)
	self.borderTexture:SetTexture(Path.."UI-TargetingFrame");
	
	self.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
	self.threatIndicator:SetTexCoord(0, 0.9453125, 0, 0.181640625);
	self.threatIndicator:SetWidth(242);
	self.threatIndicator:SetHeight(93);
	self.threatIndicator:SetPoint(K.SetOffset(self.threatIndicator, 0, 0));

	self.nameBackground:Hide();
	self.name:SetPoint(K.SetOffset(self.name, 0, 1));
	self.name:SetFont("Fonts\\FRIZQT__.TTF", 12);

	self.healthbar:SetSize(119, 28);
	self.healthbar:SetPoint("TOPLEFT", 5, -24);
	self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, -5);
	self.deadText:SetPoint("CENTER", self.healthbar, "CENTER", 0, -5);
	
	self.levelText:SetPoint(K.SetOffset(self.levelText, 51, 0));
	
	self.portrait = _G[self:GetName().."Portrait"];	--	Load Portrait;
	self:SetScale(0.65);
end;

for i = 1, MAX_BOSS_FRAMES do
	if ( SetPositions ) then 
		K.MoveFrame(_G["Boss"..i.."TargetFrame"], "EprastBoss"..i.."TargetFrame", "Boss"..i, 0, 0, EprastBossFrame);	--	Move BossTargetFrame;
	end;
	Eprast_UnitFrames_Style_BossFrame(_G["Boss"..i.."TargetFrame"]);
	if ( C.statusbarBackdrop ) then
		K.CreateBackdrop(_G["Boss"..i.."TargetFrame"]);
	end;
end;