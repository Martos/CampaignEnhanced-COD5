//rect	x y width height
#define SAFEAREA_X_OFFSET 40
#define SAFEAREA_Y_OFFSET 40

#define XPBAR_WIDTH 6
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
			exp				rect X(SAFEAREA_X_OFFSET + (segID*dvarInt("xenon_xpbar_thiker_wide_x"))) \
			exp 			rect Y(-SAFEAREA_Y_OFFSET) \
			origin			0 0 \
			background		"hud_xpticker480ws" \
			forecolor		1 1 1 0.75 \
			visible			when( dvarInt( "wideScreen" ) ); \
			decoration \
		}

#define HUD_TICKER_XENON_EXTRA_1( segID ) \
		itemDef \
		{ \
			style			WINDOW_STYLE_SHADER \
			rect			TICKER_WIDTH_XENON( segID ) \
			exp				rect X(SAFEAREA_X_OFFSET + segID*dvarInt("xenon_xpbar_thiker_x")) \
			exp 			rect Y(-SAFEAREA_Y_OFFSET) \
			origin			0 0 \
			background		"hud_xpticker480" \
			forecolor		1 1 1 0.75 \
			visible			when( !dvarInt( "wideScreen" ) && ( dvarInt("xenon_xpbar_thiker_extra") >= 1 && dvarInt("xenon_xpbar_thiker_extra") != 0 ) ); \
			decoration \
		} \
		itemDef \
		{ \
			style			WINDOW_STYLE_SHADER \
			rect			TICKER_WIDTH_WS_XENON( segID ) \
			exp				rect X(SAFEAREA_X_OFFSET + (segID*dvarInt("xenon_xpbar_thiker_wide_x"))) \
			exp 			rect Y(-SAFEAREA_Y_OFFSET) \
			origin			0 0 \
			background		"hud_xpticker480ws" \
			forecolor		1 1 1 0.75 \
			visible			when( dvarInt( "wideScreen" ) && ( dvarInt("xenon_xpbar_thiker_extra") >= 1 && dvarInt("xenon_xpbar_thiker_extra") != 0 ) ); \
			decoration \
		}
		
#define HUD_TICKER_XENON_EXTRA_2( segID ) \
		itemDef \
		{ \
			style			WINDOW_STYLE_SHADER \
			rect			TICKER_WIDTH_XENON( segID ) \
			exp				rect X(SAFEAREA_X_OFFSET + segID*dvarInt("xenon_xpbar_thiker_x")) \
			exp 			rect Y(-SAFEAREA_Y_OFFSET) \
			origin			0 0 \
			background		"hud_xpticker480" \
			forecolor		1 1 1 0.75 \
			visible			when( !dvarInt( "wideScreen" ) && ( dvarInt("xenon_xpbar_thiker_extra") <= 2 && dvarInt("xenon_xpbar_thiker_extra") != 0 ) ); \
			decoration \
		} \
		itemDef \
		{ \
			style			WINDOW_STYLE_SHADER \
			rect			TICKER_WIDTH_WS_XENON( segID ) \
			exp				rect X(SAFEAREA_X_OFFSET + (segID*dvarInt("xenon_xpbar_thiker_wide_x"))) \
			exp 			rect Y(-SAFEAREA_Y_OFFSET) \
			origin			0 0 \
			background		"hud_xpticker480ws" \
			forecolor		1 1 1 0.75 \
			visible			when( dvarInt( "wideScreen" ) && ( dvarInt("xenon_xpbar_thiker_extra") <= 2 && dvarInt("xenon_xpbar_thiker_extra") != 0 ) ); \
			decoration \
		}		
		
#define HUD_TICKER_XENON_EXTRA_3( segID ) \
		itemDef \
		{ \
			style			WINDOW_STYLE_SHADER \
			rect			TICKER_WIDTH_XENON( segID ) \
			exp				rect X(SAFEAREA_X_OFFSET + segID*dvarInt("xenon_xpbar_thiker_x")) \
			exp 			rect Y(-SAFEAREA_Y_OFFSET) \
			origin			0 0 \
			background		"hud_xpticker480" \
			forecolor		1 1 1 0.75 \
			visible			when( !dvarInt( "wideScreen" ) && ( dvarInt("xenon_xpbar_thiker_extra") > 2 && dvarInt("xenon_xpbar_thiker_extra") != 0 ) ); \
			decoration \
		} \
		itemDef \
		{ \
			style			WINDOW_STYLE_SHADER \
			rect			TICKER_WIDTH_WS_XENON( segID ) \
			exp				rect X(SAFEAREA_X_OFFSET + (segID*dvarInt("xenon_xpbar_thiker_wide_x"))) \
			exp 			rect Y(-SAFEAREA_Y_OFFSET) \
			origin			0 0 \
			background		"hud_xpticker480ws" \
			forecolor		1 1 1 0.75 \
			visible			when( dvarInt( "wideScreen" ) && ( dvarInt("xenon_xpbar_thiker_extra") > 2 && dvarInt("xenon_xpbar_thiker_extra") != 0 ) ); \
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
	visible			when( dvarbool("ui_ce_xenon_hud_dev") )
	background		"white"
	decoration
}
//right
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			-SAFEAREA_X_OFFSET -900 SAFEAREA_X_OFFSET 900 HORIZONTAL_ALIGN_RIGHT VERTICAL_ALIGN_BOTTOM
	forecolor		0 0 0 1
	visible			when( dvarbool("ui_ce_xenon_hud_dev") )
	background		"white"
	decoration
}
//4:3
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 640 8 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp 			rect W( ( ( ( dvarInt("xenon_xpbar_back_w") ) ) ) )
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
	exp				rect W( dvarInt("xenon_xpbar_front_w") * ((stat(2301)-stat(2351))/(stat(2352)-stat(2351))) );
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y( (-SAFEAREA_Y_OFFSET) + (1) )
	exp				rect H(XPBAR_WIDTH-2)
	origin			0 0
	background		"scorebar_fadein"
	forecolor		1 0.8 0.4 XPBAR_ALPHA
	visible			when( dvarbool("ui_ce_xenon_hud") && !dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") );
	decoration
}
//widescreen
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 640 8 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp 			rect W( ( ( ( dvarInt("xenon_xpbar_back_wide_w") ) ) ) )
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y(-SAFEAREA_Y_OFFSET)
	exp				rect H(XPBAR_WIDTH)
	origin			0 0
	background		"white"
	forecolor		XPBAR_BACK_COLOR
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") )
	decoration
}
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			0 -200 540 4 HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_BOTTOM
	exp				rect W( dvarInt("xenon_xpbar_front_wide_w") * ((stat(2301)-stat(2351))/(stat(2352)-stat(2351))) );
	exp				rect X(SAFEAREA_X_OFFSET)
	exp 			rect Y( (-SAFEAREA_Y_OFFSET) + (1) )
	exp				rect H(XPBAR_WIDTH-2)
	origin			0 0
	background		"scorebar_fadein"
	forecolor		1 0.8 0.4 XPBAR_ALPHA
	visible			when( dvarbool("ui_ce_xenon_hud") && dvarbool("wideScreen") && !dvarInt("ce_cheats") && !dvarInt("ui_ce_hide_xpBar") );
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

HUD_TICKER_XENON_EXTRA_1( 8 )
HUD_TICKER_XENON_EXTRA_2( 9 )
HUD_TICKER_XENON_EXTRA_3( 10 )