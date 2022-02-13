local AddOnName, ns = ...;
local K, C, L = unpack(ns);

-- PlayerFrame & TargetFrame;
do
	local unpack = unpack;
	if ( not C.SetPositions ) then 
		EprastPlayerFrame:SetPoint(unpack(C.PlayerFrame_DefaultPosition));
		TargetFrame:SetPoint(unpack(C.TargetFrame_DefaultPosition));
	else
		EprastPlayerFrame:SetPoint(unpack(C.PlayerFramePoint));
		TargetFrame:SetPoint(unpack(C.TargetFramePoint));
		K.EprastBossFrame:SetPoint(unpack(C.BossTargetFramePoint));
		K.EprastPartyFrame:SetPoint(unpack(C.PartyMemberFramePoint));
	end;
end;

-- PlayerFrame <Default>: xOffset = -19.000001572907; yOffset = -4;
-- TargetFrame <Default>: xOffset = 250.00000779615; yOffset = -4;