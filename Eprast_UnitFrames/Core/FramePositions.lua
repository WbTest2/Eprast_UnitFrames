local AddOnName, ns = ...;
local K, C, L = unpack(ns);

-- PlayerFrame & TargetFrame;
do
	local unpack = unpack;
	if ( not C.SetPositions ) then 
		if ( EprastPlayerFrame ) then EprastPlayerFrame:SetPoint(unpack(C.PlayerFrame_DefaultPosition)); end;
		TargetFrame:SetPoint(unpack(C.TargetFrame_DefaultPosition));
	else
		if ( EprastPlayerFrame ) then EprastPlayerFrame:SetPoint(unpack(C.PlayerFramePoint)); end;
		TargetFrame:SetPoint(unpack(C.TargetFramePoint));
		if ( K.EprastBossFrame ) then K.EprastBossFrame:SetPoint(unpack(C.BossTargetFramePoint)); end;
		if ( K.EprastPartyFrame ) then K.EprastPartyFrame:SetPoint(unpack(C.PartyMemberFramePoint)); end;
	end;
end;

-- PlayerFrame <Default>: xOffset = -19.000001572907; yOffset = -4;
-- TargetFrame <Default>: xOffset = 250.00000779615; yOffset = -4;