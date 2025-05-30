local AddOnName, ns = ...;
local K, C, L = unpack(ns);

local Add;
do
	local select = select;
	Add = function(relativeTo, ...)
		local Temp = {};
		for i = 1, 5 do
			Temp[i] = select(i, ...);
		end;
		Temp[2] = relativeTo;
		return Temp;
	end;
end;

C.PlayerFrame_DefaultPosition = Add(UIParent, PlayerFrame:GetPoint(1));
C.TargetFrame_DefaultPosition = Add(UIParent, TargetFrame:GetPoint(1));