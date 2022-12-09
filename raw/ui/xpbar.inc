//rect	x y width height
#define SAFEAREA_X_OFFSET 40
#define SAFEAREA_Y_OFFSET 40

#define XPBAR_WIDTH 4
#define XPBAR_ALPHA 0.65

#define XPBAR_BACK_COLOR 0 0 0 0.25

#define TICKER_WIDTH_XENON( segID )			(segID*64) 1 64 XPBAR_WIDTH HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
#define TICKER_WIDTH_WS_XENON( segID )		(segID*85) 1 151 XPBAR_WIDTH HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM

#define HUD_TICKER_XENON( segID ) \
		itemDef \
		{ \
			style			WINDOW_STYLE_SHADER \
			rect			TICKER_WIDTH_XENON( segID ) \
			exp				rect X(SAFEAREA_X_OFFSET + segID*dvarInt("xenon_xpbar_thiker_x")) \
			exp 			rect Y(-SAFEAREA_Y_OFFSET) \
			origin			0 0 \
			background		"hud_xpticker480" \
			forecolor		1 1 1 0.75 \
			visible			when( !dvarInt( "wideScreen" ) ); \
			decoration \
		} \
		itemDef \
		{ \
			style			WINDOW_STYLE_SHADER \
			rect			TICKER_WIDTH_WS_XENON( segID ) \
			exp				rect X(SAFEAREA_X_OFFSET + segID*dvarInt("xenon_xpbar_thiker_wide_x")) \
			exp 			rect Y(-SAFEAREA_Y_OFFSET) \
			origin			0 0 \
			background		"hud_xpticker480ws" \
			forecolor		1 1 1 0.75 \
			visible			when( dvarInt( "wideScreen" ) ); \
			decoration \
		}

//bottom
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -SAFEAREA_Y_OFFSET 900 100 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	forecolor		1 1 1 1
	visible			0
	background		"white"
	decoration
}
//left
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -900 SAFEAREA_X_OFFSET 900 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	forecolor		0 0 0 1
	visible			0
	background		"white"
	decoration
}
//right
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			-SAFEAREA_X_OFFSET -900 SAFEAREA_X_OFFSET 900 HORIZONTAL_ALIGN_RIGHT VERTICAL_ALIGN_BOTTOM
	forecolor		0 0 0 1
	visible			0
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
	forecolor		XPBAR_BACK_COLOR
	visible			when( dvarbool("ui_ce_xenon_hud") && !dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") )
	decoration
}
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 540 4 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp				rect W( 541 * ((stat(2301)-stat(2351))/(stat(2352)-stat(2351))) );
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"scorebar_fadein"
	forecolor		1 0.8 0.4 XPBAR_ALPHA
	visible			when( dvarbool("ui_ce_xenon_hud") && !dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") );
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
	forecolor		XPBAR_BACK_COLOR
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 6 )
	decoration
}
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 540 4 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp				rect W( 743 * ((stat(2301)-stat(2351))/(stat(2352)-stat(2351))) );
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"scorebar_fadein"
	forecolor		1 0.8 0.4 XPBAR_ALPHA
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 6 );
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
	forecolor		XPBAR_BACK_COLOR
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 7 )
	decoration
}
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 540 4 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp				rect W( 746.2 * ((stat(2301)-stat(2351))/(stat(2352)-stat(2351))) );
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"scorebar_fadein"
	forecolor		1 0.8 0.4 XPBAR_ALPHA
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 7 );
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
	forecolor		XPBAR_BACK_COLOR
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 8 )
	decoration
}
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 540 4 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp				rect W( 695 * ((stat(2301)-stat(2351))/(stat(2352)-stat(2351))) );
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"scorebar_fadein"
	forecolor		1 0.8 0.4 XPBAR_ALPHA
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 8 );
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
	forecolor		XPBAR_BACK_COLOR
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 13 )
	decoration
}
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 540 4 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp				rect W( 747 * ((stat(2301)-stat(2351))/(stat(2352)-stat(2351))) );
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"scorebar_fadein"
	forecolor		1 0.8 0.4 XPBAR_ALPHA
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 13 );
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
	forecolor		XPBAR_BACK_COLOR
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 15 )
	decoration
}
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 540 4 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp				rect W( 746 * ((stat(2301)-stat(2351))/(stat(2352)-stat(2351))) );
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"scorebar_fadein"
	forecolor		1 0.8 0.4 XPBAR_ALPHA
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 15 );
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
	forecolor		XPBAR_BACK_COLOR
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 18 )
	decoration
}
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 540 4 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp				rect W( 746 * ((stat(2301)-stat(2351))/(stat(2352)-stat(2351))) );
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"scorebar_fadein"
	forecolor		1 0.8 0.4 XPBAR_ALPHA
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") && dvarInt("ui_r_mode") == 18 );
	decoration
}

HUD_TICKER_XENON( 0 )
HUD_TICKER_XENON( 1 )
HUD_TICKER_XENON( 2 )
HUD_TICKER_XENON( 3 )
HUD_TICKER_XENON( 4 )
HUD_TICKER_XENON( 5 )
HUD_TICKER_XENON( 6 )
HUD_TICKER_XENON( 7 )
HUD_TICKER_XENON( 8 )
HUD_TICKER_XENON( 9 )