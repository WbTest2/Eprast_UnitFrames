# Eprast_UnitFrames - Wrath of the Lich King (3.3.5a)
-----------------------------------------------------
<details>
<summary>**Player & Target frames:**</summary>
  
![Image alt](https://i.ibb.co/8bh0pSY/Player-Target.jpg "Player&Target")  
![Image alt](https://i.ibb.co/7S1Q8L2/Player-Target2.jpg "Player&Target")
</details>
<details>
<summary>**Party frames:**</summary>
  
![Image alt](https://i.ibb.co/N18hLQ9/Party-Frame.jpg  "Party")
</details>
<details>
<summary>**Boss frames:**</summary>
  
![Image alt](https://i.ibb.co/Z2QXppT/Boss2.jpg "Boss")
</details>
<details>
<summary>**Arena frames:**</summary>
  
![Image alt](https://i.ibb.co/600RLBn/Screenshot-1.jpg "Arena")
</details>
-----------------------------------------------------

**Все настройки выполняются редактированием файла** `/Config/Settings.lua`:

= G E N E R A L =
- `C["classColor"]` = **true** - Окрашивать полосу здоровья по цвету класса или отношению *(true/false)*
- `C["statusbarOn"]` = **true** - Изменить стандартные текстуры статусбаров(healthbar\manabar) *(true/false)*
- `C["statusbarTexture"]` = **"Interface\\\Addons\\\\"..AddOnName.."\\\Media\\\Statusbar\\\whoa"** - Имя текстуры для статусбаров (с полным путем), при `C["statusbarOn"] = true`
- `C["statusbarBackdrop"]` = **true** - Фон для статусбаров *(true/false)*
- `C["statusbarBackdropColor"]` = **{0, 0 , 0, 0.8}** - Цвет фона RGB(0.0 - 1.0)  
[Пример:](https://colorscheme.ru/html-colors.html) `IndianRed RGB: 205, 92, 92` -> ***RGB(0.0-1.0): 205/255, 92/255, 92/255** или **0.8, 0.36, 0.36***
- `C["darkFrames"]` = **true** - Темные фреймы *(true/false)*
- `C["SetPositions"]` = **false** - Включить возможность изменения позиции фреймов *(true/false)*

= PlayerFrame =
- `C["PlayerFramePoint"]` = **{"TOPLEFT", UIParent, "TOPLEFT", 239, -4}** - Позиция PlayerFrame (только если ***C["SetPositions"] = true***)
- `C["PlayerNameOffset"]` = **{0, 0}** - Смещение Имени **Player** по осям x,y
- `C["styleFont"]` = **true** - Шрифт для петов*

= TargetFrame =
- `C["TargetFramePoint"]` = **{"TOPLEFT", UIParent, "TOPLEFT", 509, -4}** - Позиция TargetFrame (только если ***C["SetPositions"] = true***)
- `C["TargetNameOffset"]` = **{0, 0}** - Смещение Имени **Target\Focus** по осям x,y

= FocusFrame =
- `C["FocusScale"]` = **0.8** - Маштаб **FocusFrame**
- `C["FocusSpellBarScale"]` = **1.2** - Маштаб **Кастбара** для **FocusFrame**
- `C["FocusAuraLimit"]` = false - Установить свой лимит кол-ва Бафов\ДеБафов *(true/false)*
- `C["Focus_maxDebuffs"]` = **0** - Лимит на максимальное количество ДеБафов (только если ***C["FocusAuraLimit"]` = true***)
- `C["Focus_maxBuffs"]` = **0** - Лимит на максимальное количество Бафов (только если ***C["FocusAuraLimit"]` = true***)

= PartyFrame =
- `C["PartyMemberFramePoint"]` = **{"TOPLEFT", UIParent, "TOPLEFT", 10, -160}** - - Позиция PartyFrame (только если ***C["SetPositions"] = true***)
- `C["PartyMemberFrameSpacing"]` = **15** - Отступ между фреймами
- `C["PartyFrameScale"]` = **1.1** - Маштаб PartyFrame
- `C["PartyFrameFont"]` = **{"Fonts\\\FRIZQT__.TTF", 9, "OUTLINE"}** - Шрифт (Имя с путем, размер шрифта, граница шрифта)

= BossFrame =
- `C["BossTargetFramePoint"]` = **{"TOPLEFT", UIParent, 1300, -220}** - Позиция BossFrame (только если ***C["SetPositions"] = true***)
- `C["BossTargetFrameSpacing"]` = **0** - Отступ между фреймами

= ArenaFrame =
- `C["ArenaFrameOn"]` = **false** - Включить модификацию аренафреймов *(true/false)*
- `C["ArenaFramePoint"]` = **{"TOPRIGHT", UIParent, "TOPRIGHT", -20, -200}** - Позиция ArenaFrame (только если ***C["SetPositions"] = true*** и ***C["ArenaFrameOn"]` = true***)
- `C["ArenaFrameScale"]` = **1.1** - Маштаб ArenaEnemyFrames (только если ***C["ArenaFrameOn"]` = true***)
- `C["ArenaFrameFont"]` = **{"Fonts\\\FRIZQT__.TTF", 7, "OUTLINE"}** - Шрифт (Имя с путем, размер шрифта, граница шрифта)

= Modules =
- `C["HealthPercentage"]` = **false** - Проценты на таргет фрейме *(true/false)*
-----------------------------------------------------
