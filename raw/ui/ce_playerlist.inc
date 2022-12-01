#define ORIGIN_COLUMN_RANK_X 0
#define ORIGIN_COLUMN_NAME_X 32
#define ORIGIN_COLUMN_SCORE_X 225//236
#define COLUMN_RANK_WIDTH 36
#define COLUMN_NAME_WIDTH 256
#define COLUMN_SCORE_WIDTH 54
#define BACKGROUND_TEXTURE_COLOR 0 0 0 0.7
#define ORIGIN_READY_X				-26
#define ORIGIN_TALKER_WITH_READY_X	-42
#define ORIGIN_TALKER_WITHOUT_READY_X	-20

#define LIST_BOX_WIDTH		278
#define LIST_BOX_HEIGHT		334//326
#define LIST_BOX_SIZE 		LIST_BOX_WIDTH LIST_BOX_HEIGHT

#define COLUMN_HEADER_COLOR 1 1 1 1

#ifndef PLAYERLIST_SELECTED_ACTIONS
	#define PLAYERLIST_SELECTED_ACTIONS ;
#endif

#define PLAYERSTATS_X			-288
#define PLAYERSTATS_Y			25

#define ORIGIN_PLAYERSTATS 		PLAYERSTATS_X PLAYERSTATS_Y

#define LOADOUT_ALIGN 	HORIZONTAL_ALIGN_RIGHT VERTICAL_ALIGN_TOP
#define LEVEL_NAME_X			10
#define LEVEL_NAME_Y			(164-30)

#define PLAYERLIST_PARTYVIS (1)
#define PLAYERLIST_MEMBERVIS (1)
#define PLAYERLIST_TEAMSVIS (1)

#define PREPROC_RANK_ICON_VIS( x_offset, y_offset, pshader, visArg ) \
	PREPROC_SHADER_DRAW_ALIGNED_VIS( (30+x_offset) (y_offset-75) 12 12 LOADOUT_ALIGN, ORIGIN_PLAYERSTATS, pshader, 1 1 1 1, 0, 0, 0 0 0 0, visArg )

#define PREPROC_RANK_ICON( x_offset, y_offset, pshader ) \
		PREPROC_RANK_ICON_VIS( x_offset, y_offset, pshader, 1 )

#define PLAYERLIST_PLAYERFEEDER( feederName, feederArg, yOffsetArg, heightArg, disableColorArg, backColorArg, actionsArg, visArg ) \	
	itemDef	{ \
		name			feederName \
		feeder			feederArg \
		type			ITEM_TYPE_LISTBOX \
		rect			(ORIGIN_COLUMN_NAME_X-COLUMN_RANK_WIDTH) yOffsetArg (COLUMN_NAME_WIDTH+COLUMN_RANK_WIDTH) heightArg RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP \
		origin			ORIGIN_PLAYERLIST \
		elementwidth	COLUMN_NAME_WIDTH \
		elementheight	18 \
		textfont		UI_FONT_SMALL \
		textscale		FONTSCALE_LOBBY \
		textalignx		COLUMN_RANK_WIDTH \
		textaligny		-1 \
		forecolor		CHOICE_TEXTCOLOR \
		focusColor		1 1 1 1 \
		disableColor	disableColorArg \
		outlinecolor	1 1 1 0 \
		highlightTexture	"menu_button_backing_highlight" \
		selectBorder	0.8 0.95 1 0 \
		backcolor		backColorArg \
		backgroundItemListbox	"menu_lobby_strip_whole" \
		visible			when( visArg ) \
		columns			1		6		(PLAYERLIST_WIDTH-COLUMN_NAME_WIDTH) 40			0 \
		noscrollbars \
		actionsArg \
		onFocus	{ \
			play "mouse_over"; \
			hide selection_left; \
			show selection_right; \
		} \
	}

itemDef
{
	type			ITEM_TYPE_TEXT
	visible			1
	rect			ORIGIN_COLUMN_RANK_X -2 0 0 RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP
	origin			ORIGIN_PLAYERLIST
	text			"@MPUI_RANK"
	align			ITEM_ALIGN_LEFT
	textstyle		ITEM_TEXTSTYLE_SHADOWED
	textfont		CHOICE_TEXTFONT
	textscale		TEXTSIZE_SMALL
	textaligny 		12
	forecolor		COLUMN_HEADER_COLOR
	visible 		1
	decoration
}

itemDef
{
	type			ITEM_TYPE_TEXT
	rect			ORIGIN_COLUMN_NAME_X -2 0 0 RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP
	origin			ORIGIN_PLAYERLIST
	text			"@MPUI_NAME"
	align			ITEM_ALIGN_LEFT
	textstyle		ITEM_TEXTSTYLE_SHADOWED
	textfont		CHOICE_TEXTFONT
	textscale		TEXTSIZE_SMALL
	textalignx		6
	textaligny 		12
	forecolor		COLUMN_HEADER_COLOR
	visible 		1
	decoration
}

itemDef
{
	type			ITEM_TYPE_TEXT
	rect			ORIGIN_COLUMN_NAME_X -2 0 0 RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP
	origin			ORIGIN_PLAYERLIST
	exp				text( stat(252) + 1 )
	align			ITEM_ALIGN_LEFT
	textstyle		ITEM_TEXTSTYLE_SHADOWED
	textfont		CHOICE_TEXTFONT
	textscale		TEXTSIZE_SMALL
	textalignx		-28
	textaligny 		30
	forecolor		COLUMN_HEADER_COLOR
	visible 		1
	decoration
}

PLAYERLIST_PLAYERFEEDER( "myMembersList", FEEDER_PARTY_MEMBERS, 8, 334, CHOICE_TEXTCOLOR, BACKGROUND_TEXTURE_COLOR, PLAYERLIST_SELECTED_ACTIONS, 1 )
PREPROC_RANK_ICON( LEVEL_NAME_X, LEVEL_NAME_Y, tablelookup( "mp/rankIconTable.csv", 0, stat(252), stat(2326)+1 ) )