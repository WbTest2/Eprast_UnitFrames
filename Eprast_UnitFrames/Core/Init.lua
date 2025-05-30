-- Initiation / Engine of Eprast_UnitFrames;
local AddOnName, ns = ...;
ns[1] = {};	-- K, Functions;
ns[2] = {};	-- C, Config;
ns[3] = {};	-- L, Localization;

--[[
This should be at the top of every file inside of the Eprast_UnitFrames AddOn:
local K, C, L, _ = unpack(select(2, ...))
]]