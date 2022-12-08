//rect	x y width height
#define SAFEAREA_X_OFFSET 40
#define SAFEAREA_Y_OFFSET 40

#define XPBAR_WIDTH 6

//bottom
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -SAFEAREA_Y_OFFSET 900 100 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	forecolor		1 1 1 1
	visible			1
	background		"white"
	decoration
}
//left
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -900 SAFEAREA_X_OFFSET 900 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	forecolor		1 0 0 1
	visible			1
	background		"white"
	decoration
}
//right
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			-SAFEAREA_X_OFFSET -900 SAFEAREA_X_OFFSET 900 HORIZONTAL_ALIGN_RIGHT VERTICAL_ALIGN_BOTTOM
	forecolor		0 1 0 1
	visible			1
	background		"white"
	decoration
}
//4:3
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 640 8 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp 			rect W( ( ( ( 560 ) ) ) )
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"white"
	forecolor		0 0 1 1
	visible			when( dvarbool("ui_ce_xenon_hud") && !dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") )
	decoration
}
//1176x664
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 640 8 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp 			rect W( ( ( ( 770.2 ) ) ) )
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"white"
	forecolor		0 0 1 1
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 6 )
	decoration
}
//1280x720
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 640 8 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp 			rect W( ( ( ( 773.2 ) ) ) )
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"white"
	forecolor		0 0 1 1
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 7 )
	decoration
}
//1280x768
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 640 8 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp 			rect W( ( ( ( 720 ) ) ) )
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"white"
	forecolor		0 0 1 1
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 8 )
	decoration
}
//1366x768
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 640 8 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp 			rect W( ( ( ( 774 ) ) ) )
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"white"
	forecolor		0 0 1 1
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 13 )
	decoration
}
//1600x900
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 640 8 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp 			rect W( ( ( ( 773.5 ) ) ) )
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"white"
	forecolor		0 0 1 1
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 15 )
	decoration
}
//1920x1080
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 640 8 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp 			rect W( ( ( ( 773.5 ) ) ) )
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"white"
	forecolor		0 0 1 1
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 18 )
	decoration
}