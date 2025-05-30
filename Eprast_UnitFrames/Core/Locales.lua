local AddOnName, ns = ...;
local K, C, L = unpack(ns);
-------------------------------
local GetLocale = GetLocale;
-------------------------------

L["DeadText"] = (GetLocale() == "ruRU" and "Мертв") or "Dead";
L["GhostText"] = (GetLocale() == "ruRU" and "Призрак") or "Ghost";
L["OfflineText"] = (GetLocale() == "ruRU" and "Не в сети") or "Offline";
