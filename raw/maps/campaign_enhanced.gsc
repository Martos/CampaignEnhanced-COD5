#include maps\_utility;

init() {
    dvars_init();

    level.onlineGame = true;
	level.cheating = false;

    players = get_players();
	for( i = 0; i < players.size; i++ ) {

        // Set safearea for controller mode
        if (GetDvarInt("cg_drawGamepadHUD", 0) == 1) {
			players[i] setClientDvar("safeArea_vertical", "0.85");
			players[i] setClientDvar("safeArea_horizontal", "0.85");
		} else {
			players[i] setClientDvar("safeArea_vertical", "1");
			players[i] setClientDvar("safeArea_horizontal", "1");
		}

        // Fix barra xp vuota con player a livello 1
		checkLevelMaxXP = players[i] statGet( "maxxp" );
		if (checkLevelMaxXP == 0) {
			players[i] statSet( "maxxp", 30 );
			players[i] iprintlnbold(players[i] statGet( "maxxp" ));
		}

        players[i] spawnShops();

        players[i] thread watchPlayerCheats();

        players[i] openMenu( "endofgame" );

        players[i] thread classSelectionThread();

        players[i] thread MenuResponses();

        players[i] thread TimePlayed();

        players[i] thread PatchPlayerScore();

        // Scoreboard colors
		if (level.campaign == "russian") {
			players[i] setClientDvar("cg_ScoresColor_Player", "0.76 0 0 1");
		} else {
			players[i] setClientDvar("cg_ScoresColor_Player", "0 0.3 0.76 1");
		}

        // DEBUG
        // players[i] thread debug_utils();
    }
}

debug_utils() {
    //DEBUG: Player positizion on map
    setdvar("ce_show_position", "1");
    setdvar("ce_rotation", "1");
    self thread PrintPlayerPosition();
}

dvars_init() {
    setdvar("psx", 0);
	setdvar("psa", 0);
	setdvar("psk", 0);
	setdvar("psh", 0);
	setdvar("ce_cheats", 0);

    setdvar("ui_cac_ingame", "1");
    setdvar("ui_ce_shop", "0");
    setdvar("ui_customclass_selected", "999");
    setdvar("ui_showEndOfGame", "1");
    setdvar("ce_show_jug", "0");
    setdvar("ce_show_sp", "0");
    setdvar("ce_show_be", "0");
    setdvar("ce_show_re", "0");

    setdvar( "ui_unlock_report", "1" );
}

spawnShops() {
	spawnPoints = (0, 0, 0);
	anglePoints = (0, 0, 0);
	secondSpawnPoints = (0, 0, 0);
	secondAnglePoints = (0, 0, 0);
	mapName = getdvar("mapname");
	
	switch(mapName) {
		case "mak":
			spawnPoints = (-9981, -19066, 69);
			anglePoints = (0, 180, 0);
			secondSpawnPoints = (-7064, -15523, 479);
			secondAnglePoints = (0, -90, 0);
			break;
		case "ber2":
			spawnPoints = (-1156.88, -2385.88, 856.125);
			anglePoints = (0, 90, 0);
			secondSpawnPoints = (834.197, 88.6863, -463.875);
			secondAnglePoints = (0, 25, 0);
			break;
		case "oki3":
			spawnPoints = (3932.2, 5198.82, -818.639);
			break;
		default: 
			spawnPoints = (0, 0, 0);
			break;
	}
	
	first_shop = spawn("script_model", spawnPoints);
	first_shop setmodel("zombie_vending_doubletap_on");
	first_shop setcontents(1);
	first_shop.targetname = "first_shop";
	first_shop.angles = anglePoints;
	first_shop solid();
	
	second_shop = spawn("script_model", secondSpawnPoints);
	second_shop setmodel("zombie_vending_doubletap_on");
	second_shop setcontents(1);
	second_shop.targetname = "second_shop";
	second_shop.angles = secondAnglePoints;
	second_shop solid();

	level thread open_shop_trigger();
	level thread open_second_shop_trigger();
}

watchPlayerCheats() {

	level endon( "death" );
	level endon( "disconnect" );

	for( ;; ) {

		if ( IsGodMode( self ) ) {
			level.cheating = true;
		}

		if( getDvarInt( "sf_use_ignoreammo" ) > 0 )
		{
			level.cheating = true;
		}
		
		if( getDvarInt("player_sustainAmmo") > 0 )
		{
			level.cheating = true;
		}
			
		if( getDvarInt( "revive_trigger_radius") > 60 )
		{
			level.cheating = true;
		}
			
		if( getDvarInt( "g_speed" ) > 190)
		{
			level.cheating = true;
		}
		
		if( getDvarInt( "g_gravity" ) != 800 )
		{
			level.cheating = true;
		}

		if(level.cheating == true && getdvarint("ce_cheats") == 0) {
			setdvar( "ce_cheats", 1 );
		}

		wait 0.05;
	}
}

classSelectionThread() {
	self thread watchClassCustomization();
}

watchClassCustomization() {
	for( ;; ) {
		
		level endon( "closed_cac" );
		
		primaryWeapon = getdvar("ce_weap_sel");
		primaryAttachment = getdvar("ce_cac_primary_attachment");
		sideWeapon = getdvar("ce_side_sel");
		primaryGrenade = getdvar("ce_pg_sel");
		specialGrenade = getdvar("ce_sp_sel");
		
		primaryWeaponOffset = (getdvarint("ce_cac_selected") - 300) + 201;
		primaryWeaponAttachmentOffset = (getdvarint("ce_cac_selected") - 300) + 202;
		sideWeaponOffset = (getdvarint("ce_cac_selected") - 300) + 203;
		primaryGrenadeOffset = (getdvarint("ce_cac_selected") - 300) + 200;
		specialGrenadeOffset = (getdvarint("ce_cac_selected") - 300) + 208;

		switch(sideWeapon) {
			case "colt":
				self setStat(sideWeaponOffset, 0);
				break;
			case "nambu":
				self setStat(sideWeaponOffset, 1);
				break;
			case "walther":
				self setStat(sideWeaponOffset, 2);
				break;
			case "tokarev":
				self setStat(sideWeaponOffset, 3);
				break;
			case "357magnum":
				self setStat(sideWeaponOffset, 4);
				break;
		}

		switch(primaryGrenade) {
			case "molotov":
				self setStat(primaryGrenadeOffset, 101);
				break;
			case "frag_grenade":
				self setStat(primaryGrenadeOffset, 100);
				break;
			case "sticky_grenade":
				self setStat(primaryGrenadeOffset, 104);
				break;
		}

		switch(specialGrenade) {
			case "m8_white_smoke":
				self setStat(specialGrenadeOffset, 102);
				break;
			case "tabun_gas":
				self setStat(specialGrenadeOffset, 103);
				break;
			case "signal_flare":
				self setStat(specialGrenadeOffset, 105);
				break;
		}
		
		switch(primaryWeapon) {
			case "thompson":
				self setStat(primaryWeaponOffset, 10);
				if(primaryAttachment == "silenced") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				}
				else if(primaryAttachment == "aperture") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				}
				else if(primaryAttachment == "bigammo") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "mp40":
				self setStat(primaryWeaponOffset, 11);
				if(primaryAttachment == "silenced") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				}
				else if(primaryAttachment == "aperture") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				}
				else if(primaryAttachment == "bigammo") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "type100smg":
				self setStat(primaryWeaponOffset, 12);
				if(primaryAttachment == "silenced") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				}
				else if(primaryAttachment == "aperture") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				}
				else if(primaryAttachment == "bigammo") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "type99lmg":
				self setStat(primaryWeaponOffset, 80);
				if(primaryAttachment == "bipod") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "bayonet") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "ppsh":
				self setStat(primaryWeaponOffset, 13);
				if(primaryAttachment == "aperture") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "bigammo") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "svt40":
				self setStat(primaryWeaponOffset, 20);
				if(primaryAttachment == "flash") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "aperture") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else if(primaryAttachment == "telescopic") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "gewehr43":
				self setStat(primaryWeaponOffset, 21);
				if(primaryAttachment == "silenced") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "aperture") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else if(primaryAttachment == "telescopic") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else if(primaryAttachment == "gl") {
					self setStat(primaryWeaponAttachmentOffset, 4);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "m1garand":
				self setStat(primaryWeaponOffset, 22);
				if(primaryAttachment == "flash") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "bayonet") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else if(primaryAttachment == "gl") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else if(primaryAttachment == "scoped") {
					self setStat(primaryWeaponAttachmentOffset, 4);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "stg44":
				self setStat(primaryWeaponOffset, 24);
				if(primaryAttachment == "flash") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "aperture") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else if(primaryAttachment == "telescopic") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "m1carbine":
				self setStat(primaryWeaponOffset, 23);
				if(primaryAttachment == "flash") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "aperture") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else if(primaryAttachment == "bayonet") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else if(primaryAttachment == "bigammo") {
					self setStat(primaryWeaponAttachmentOffset, 4);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "bar":
				self setStat(primaryWeaponOffset, 82);
				if(primaryAttachment == "bipod") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "fg42":
				self setStat(primaryWeaponOffset, 81);
				if(primaryAttachment == "bipod") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "dp28":
				self setStat(primaryWeaponOffset, 83);
				if(primaryAttachment == "bipod") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "telescopic") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "springfield":
				self setStat(primaryWeaponOffset, 60);
				if(primaryAttachment == "scoped") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "bayonet") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else if(primaryAttachment == "gl") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "mosinrifle":
				self setStat(primaryWeaponOffset, 61);
				if(primaryAttachment == "scoped") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "bayonet") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else if(primaryAttachment == "gl") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "type99rifle":
				self setStat(primaryWeaponOffset, 62);
				if(primaryAttachment == "scoped") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "bayonet") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else if(primaryAttachment == "gl") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "kar98k":
				self setStat(primaryWeaponOffset, 63);
				if(primaryAttachment == "scoped") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "bayonet") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else if(primaryAttachment == "gl") {
					self setStat(primaryWeaponAttachmentOffset, 3);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "shotgun":
				self setStat(primaryWeaponOffset, 70);
				break;
			case "doublebarreledshotgun":
				self setStat(primaryWeaponOffset, 71);
				if(primaryAttachment == "grip") {
					self setStat(primaryWeaponAttachmentOffset, 1);
				} else if(primaryAttachment == "sawoff") {
					self setStat(primaryWeaponAttachmentOffset, 2);
				} else {
					self setStat(primaryWeaponAttachmentOffset, 0);
				}
				break;
			case "ptrs41":
				self setStat(primaryWeaponOffset, 64);
				self setStat(primaryWeaponAttachmentOffset, 0);
				break;
		}
		
		wait 0.05;
	}
}

MenuResponses() {
	self endon("disconnect");
	
	SHOP_AMMO_PRICE = 500;
	SHOP_JUGGERNOG_PRICE = 2500;
	SHOP_SPEED_PRICE = 3000;
	SHOP_RAYGUN_SPEED = 20000;
	
	while(1) {
		self waittill("menuresponse",menu,response);
		if(menu == game["menu_shop"]) {
			if(response == "buy_ammo") {
				self setStat(2302, self getStat(2302) - SHOP_AMMO_PRICE);
				
				weapons = self GetWeaponsList(); 
				for( i = 0 ; i < weapons.size ; i++ )
				{				
					self GiveMaxAmmo(weapons[i]);
				}
			}
			if(response == "buy_raygun") {
				self GiveWeapon("ray_gun");
				self GiveMaxAmmo("ray_gun");
				self SwitchToWeapon("ray_gun");
			}
			if(response == "buy_xp") {
				self setStat(2301, 153940);	//XP
				self setStat(252, 64);	//RANK
				self setStat(2351, 5270);
				self setStat(2352, 148680);
				self setStat(2326, 0);	//PRESTIGE
			}
			if(response == "buy_juggernog") {
				self setStat(2302, self getStat(2302) - SHOP_JUGGERNOG_PRICE);
				
				self SetPerk( "specialty_armorvest" );
				
				self setblur(4, 0.1);
				wait(0.1);
				self setblur(0, 0.1);
				
				setdvar("ce_show_jug", "1");
			}
			if(response == "buy_speed") {
				self setStat(2302, self getStat(2302) - SHOP_SPEED_PRICE);
				
				self SetPerk( "specialty_fastreload" );
				
				self setblur(4, 0.1);
				wait(0.1);
				self setblur(0, 0.1);
				
				setdvar("ce_show_sp", "1");
			}
		}
		if(menu == game["endofgame"]) {
			if(response == "ceSelectedClass") {
				
				level notify( "closed_cac" );
				
				if(GetDvarInt("ce_change_prestige") == 1) {
					//self iprintlnbold("PRESTIGE: " + self getStat(2326));
					currentPrestige = self getStat(2326);
					if(self checkPrestigeAvailable() == true) {
						currentPrestige = currentPrestige + 1;

						//Reset stats
						self thread profileStatsReset(currentPrestige);
						
						//Sblocchi arma
						self thread weaponsUnlocksReset();
						
						self thread	maps\_challenges_coop::updateRankAnnounceHUD();
					}
					setdvar("ce_change_prestige", "0");
				}
				
				//self iprintlnbold("CLASS: " + getdvar("ui_customclass_selected"));
				
				switch(GetDvarInt("ui_customclass_selected")) {
					case 6:
						self customClassLogic(0);
						break;
					case 7:
						self customClassLogic(10);
						break;
					case 8:
						self customClassLogic(20);
						break;
					case 9:
						self customClassLogic(30);
						break;
					case 10:
						self customClassLogic(40);
						break;
					default:
						//No class selected, use standard weapons instead
						break;
					
				}
			}
		}
	}	
}

TimePlayed()
{
	self endon("disconnect");
	
	while(1)
	{
		wait(1);
		self maps\_challenges_coop::statAdd("time_played_total", 1);
		
		secondsPlayed = self maps\_challenges_coop::statGet("time_played_total");
		self setStat(2311, secondsPlayed);
	}
}

PatchPlayerScore() {
	self endon("disconnect");
	
	while(1) {
		wait(0.05);
		
		self.score = self getStat(2302);
		self.totalScore = self getStat(2302);
	}
}

customClassLogic(offset) {
	if(!isplayer(self))
		return;
	
	if(!isdefined(offset))
		return;
	
	self TakeAllWeapons();
	
	cac_selected_primary = self getStat(offset + 201);
	cac_primary_grenade = self getStat(offset + 200);
	cac_special_grenade = self getStat(offset + 208);

	switch(cac_primary_grenade) {
		case 100:
			setdvar("ce_gameskill_primary_grenade", "fraggrenade");
			break;
		case 101:
			setdvar("ce_gameskill_primary_grenade", "molotov");
			break;
		case 104:
			setdvar("ce_gameskill_primary_grenade", "stick_grenade");
			break;
		default:
			setdvar("ce_gameskill_primary_grenade", "fraggrenade");
			break;
	}

	switch(cac_special_grenade) {
		case 102:
			setdvar("ce_gameskill_special_grenade", "m8_white_smoke");
			break;
		case 103:
			setdvar("ce_gameskill_special_grenade", "tabun_gas");
			break;
		case 105:
			setdvar("ce_gameskill_special_grenade", "signal_flare");
			break;
		default:
			setdvar("ce_gameskill_special_grenade", "m8_white_smoke");
			break;
	}
	
	if(cac_selected_primary == 12) {
		setdvar("ce_gameskill_weap_test", "type100_smg");
	} else {
		setdvar("ce_gameskill_weap_test", ""+tablelookup("mp/statsTable.csv", 0, cac_selected_primary, 4));
	}
	
	cac_selected_attachment = self getStat(offset + 202);
	
	// If is ppsh
	if(cac_selected_primary == 13) {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "aperture");
				break;
			case 2:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "single");
				break;
		}
	} else if(cac_selected_primary == 21) {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "silenced");
				break;
			case 2:
				setdvar("ce_gameskill_weap_attachment", "aperture");
				break;
			case 3:
				setdvar("ce_gameskill_weap_attachment", "telescopic");
				break;
			case 4:
				setdvar("ce_gameskill_weap_attachment", "gl");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
	} else if(cac_selected_primary == 22) {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "flash");
				break;
			case 2:
				setdvar("ce_gameskill_weap_attachment", "bayonet");
				break;
			case 3:
				setdvar("ce_gameskill_weap_attachment", "gl");
				break;
			case 4:
				setdvar("ce_gameskill_weap_attachment", "scoped");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
	} else if(cac_selected_primary == 20 || cac_selected_primary == 24) {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "flash");
				break;
			case 2:
				setdvar("ce_gameskill_weap_attachment", "aperture");
				break;
			case 3:
				setdvar("ce_gameskill_weap_attachment", "telescopic");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
	} else if(cac_selected_primary == 23) {	// If is m1carbine
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "flash");
				break;
			case 2:
				setdvar("ce_gameskill_weap_attachment", "aperture");
				break;
			case 3:
				setdvar("ce_gameskill_weap_attachment", "bayonet");
				break;
			case 4:
				setdvar("ce_gameskill_weap_attachment", "bigammo");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
	} else if(cac_selected_primary == 40 || cac_selected_primary == 41 || cac_selected_primary == 42) {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "bipod");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
	} else if(cac_selected_primary == 80) {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "bipod");
				break;
			case 2:
				setdvar("ce_gameskill_weap_attachment", "bayonet");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
	} else if(cac_selected_primary == 81) {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "bipod");
				break;
			case 2:
				setdvar("ce_gameskill_weap_attachment", "telescopic");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
	} else if(cac_selected_primary == 83 || cac_selected_primary == 82) {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "bipod");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
	} else if(cac_selected_primary == 60 || cac_selected_primary == 61 || cac_selected_primary == 62 || cac_selected_primary == 63 || cac_selected_primary == 64) {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "scoped");
				break;
			case 2:
				setdvar("ce_gameskill_weap_attachment", "bayonet");
				break;
			case 3:
				setdvar("ce_gameskill_weap_attachment", "gl");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
		//PTRS-41 No attachments
		if(cac_selected_primary == 64) {
			cac_selected_attachment = 0;
			setdvar("ce_gameskill_weap_attachment", "");
		}
	} else if(cac_selected_primary == 71) {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "grip");
				break;
			case 2:
				setdvar("ce_gameskill_weap_attachment", "sawoff");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
	} else {
		switch(cac_selected_attachment) {
			case 1:
				setdvar("ce_gameskill_weap_attachment", "silenced");
				break;
			case 2:
				setdvar("ce_gameskill_weap_attachment", "aperture");
				break;
			case 3:
				setdvar("ce_gameskill_weap_attachment", "bigammo");
				break;
			default:
				setdvar("ce_gameskill_weap_attachment", "");
				break;
		}
	}

	
	cac_selected_secondary = self getStat(offset + 203);
	setdvar("ce_gameskill_weap_secondary", ""+tablelookup("mp/statsTable.csv", 0, cac_selected_secondary, 4));
	
	primaryWeaponString = getdvar("ce_gameskill_weap_test");
	secondaryWeaponString = getdvar("ce_gameskill_weap_secondary");
	primaryGrenadeString = getdvar("ce_gameskill_primary_grenade");
	specialGrenadeString = getdvar("ce_gameskill_special_grenade");
	
	if(getdvar("ce_gameskill_weap_attachment") != "") {
		primaryWeaponString = primaryWeaponString + "_" + getdvar("ce_gameskill_weap_attachment");
	}
	//self iprintlnbold(cac_selected_primary + "-" + cac_selected_attachment + "(" + primaryWeaponString + ")");
	self GiveWeapon(primaryWeaponString);
	self GiveWeapon(secondaryWeaponString);
	self GiveWeapon(primaryGrenadeString);
	self GiveWeapon(specialGrenadeString);
	self GiveMaxAmmo(primaryWeaponString);
	self SwitchToWeapon(primaryWeaponString);
	
	if(level.script == "pel1") {
		self maps\_loadout::add_weapon( "rocket_barrage" );
		self maps\_loadout::set_action_slot( 4, "weapon", "rocket_barrage" );
	}
}

profileStatsReset(currentPrestige) {
	//Crea una classe
	self setStat(260, 0);
	
	self setStat(2301, 0);
	self setStat(252, 0);
	self setStat(2351, 0);
	self setStat(2352, 30);
	
	self setStat(2326, currentPrestige);
}

weaponsUnlocksReset() {
	self setStat(3000, 0);
	self setStat(3001, 0);
	self setStat(3002, 0);
	self setStat(3010, 0);
	self setStat(3020, 0);
	self setStat(3060, 0);
	self setStat(3062, 0);
	self setStat(3070, 0);
	self setStat(3080, 0);
	self setStat(3082, 0);
	self setStat(3021, 0);
	self setStat(3011, 0);
	self setStat(3042, 0);
	self setStat(3083, 0);
	self setStat(3022, 0);
	self setStat(3003, 0);
	self setStat(3061, 0);
	self setStat(3091, 0);
	self setStat(3012, 0);
	self setStat(3071, 0);
	self setStat(3041, 0);
	self setStat(3024, 0);
	self setStat(3063, 0);
	self setStat(3081, 0);
	self setStat(3004, 0);
	self setStat(3013, 0);
	self setStat(3064, 0);
	self setStat(3040, 0);
	self setStat(3023, 0);
	self setStat(3050, 0);
}

unlocksAllWeapons() {
	//Stat 3010: 1	Stat 3010: 196611	Stat 3010: 458759	Stat 3010: 983055	Stat 3021: 2031647
	self setStat(3000, 1);
	self setStat(3001, 1);
	self setStat(3002, 1);
	self setStat(3010, 1);	//THOMPSON
	self setStat(3020, 1);
	self setStat(3060, 1);
	self setStat(3062, 1);
	self setStat(3070, 1);
	self setStat(3080, 1);
	self setStat(3082, 1);
	self setStat(3021, 1);	//GEWHER43
	self setStat(3011, 1);	//MP40
	self setStat(3042, 1);
	self setStat(3083, 1);
	self setStat(3022, 1);
	self setStat(3003, 1);
	self setStat(3061, 1);
	self setStat(3091, 1);
	self setStat(3012, 1);
	self setStat(3071, 1);
	self setStat(3041, 1);
	self setStat(3024, 1);
	self setStat(3063, 1);
	self setStat(3081, 1);
	self setStat(3004, 1);
	self setStat(3013, 1);
	self setStat(3064, 1);
	self setStat(3040, 1);
	self setStat(3023, 1);
	self setStat(3050, 1);
}

unlocksChallenges() {
	//Gewer
	self setStat(501, 255);		//[1 - 4]Tier - 255 Completed
	self setStat(502, 255);
	self setStat(2501, 150);
	self setStat(2502, 150);
	//svt40
	self setStat(503, 255);
	self setStat(504, 255);
	self setStat(2503, 100);
	self setStat(2504, 150);
	//m1garand
	self setStat(505, 255);
	self setStat(506, 255);
	self setStat(2505, 150);
	self setStat(2506, 150);
	//m1ai
	self setStat(507, 255);
	self setStat(508, 255);
	self setStat(2507, 150);
	self setStat(2508, 150);
	//stg44
	self setStat(509, 255);
	self setStat(510, 255);
	self setStat(2509, 100);
	self setStat(2510, 150);
	//thompson
	self setStat(521, 255);
	self setStat(522, 255);
	self setStat(2521, 150);
	self setStat(2522, 150);
	//type100
	self setStat(523, 255);
	self setStat(524, 255);
	self setStat(2523, 150);
	self setStat(2524, 150);
	//mp40
	self setStat(525, 1);
	self setStat(526, 1);
	self setStat(2525, 150);
	self setStat(2526, 150);
	//ppsh
	self setStat(527, 255);
	self setStat(528, 255);
	self setStat(2527, 75);
	self setStat(2528, 150);
	//type99
	self setStat(541, 255);
	self setStat(542, 255);
	self setStat(2541, 150);
	self setStat(2542, 150);
	//trenchgun
	self setStat(561, 255);
	self setStat(562, 255);
	self setStat(2561, 150);
	self setStat(2562, 150);
	//mosin-nagant
	self setStat(581, 255);
	self setStat(582, 255);
	self setStat(2581, 150);
	self setStat(2582, 150);
	//springfield
	self setStat(583, 255);
	self setStat(584, 255);
	self setStat(2583, 150);
	self setStat(2584, 150);
	//kar98k
	self setStat(585, 255);
	self setStat(586, 255);
	self setStat(2585, 150);
	self setStat(2586, 150);
	//arisaka
	self setStat(587, 255);
	self setStat(588, 255);
	self setStat(2587, 150);
	self setStat(2588, 150);
	
	slot = 1;
	//self iprintlnbold("CHALLENGE PROGRESS " + slot + ":" + int( tablelookup( "mp/challengeTable_tier3.csv", 1, slot, 3 ) ) );
}

unlockAllChallengesMP() {
	//self setStat(202, 3);
	self setStat(2301, 153950);	//XP
	self setStat(252, 64);	//RANK
	self setStat(2351, 5270);
	self setStat(2352, 148680);
	self setStat(2326, 0);	//PRESTIGE
	
	self setStat(260, 1);	//CLASS UNLOCK

	self unlocksAllWeapons();
	//self unlocksChallenges();
	
	/*
	for(i = 501; i < 840; i++) {
		iPrintLn("UNLOCK: " + i);
		self setStat(i, 1);
		wait 0.05;
	}
	*/
}

checkPrestigeAvailable() {
	ret = false;
	
	if(self getStat(252) == 64 && self getStat(2301) >= 153950 && self getStat(2326) < 10) {
		ret = true;
	}
	
	//self iprintlnbold("AVAIL: " + ret);
	//self iprintlnbold("XP: " + self getStat(2301));
	
	return ret;
}

open_shop_trigger() {
	self endon("disconnect");
	
	first_shop_entity = getent("first_shop","targetname");
	flagtrig = Spawn("trigger_radius", first_shop_entity.origin, 0, 64, 200);

	flagtrig sethintstring("Press F to open Shop");
	flagtrig SetCursorHint("HINT_NOICON");
	
	players = get_players();

	while(1)
	{
		flagtrig waittill( "trigger", who );
		
		if(IsPlayer(players[0])) {
			if(players[0] UseButtonPressed()) {
				players[0] openMenu( "menu_shop" );
			}
		}

		wait(0.1);
	}
}

open_second_shop_trigger() {
	self endon("disconnect");
	
	second_shop_entity = getent("second_shop","targetname");
	flagtrig = Spawn("trigger_radius", second_shop_entity.origin, 0, 64, 200);

	flagtrig sethintstring("Press F to open Shop");
	flagtrig SetCursorHint("HINT_NOICON");
	
	players = get_players();

	while(1)
	{
		flagtrig waittill( "trigger", who );
		
		if(IsPlayer(players[0])) {
			if(players[0] UseButtonPressed()) {
				players[0] openMenu( "menu_shop" );
			}
		}

		wait(0.1);
	}
}

PrintPlayerPosition() {
	self endon("disconnect");

	while(1) {
		if(isplayer(self)) {
			if(GetDvarInt("ce_show_position") == 1) {
				self iprintlnbold(self.origin);
				self iprintlnbold(self.angles);

				shop = getent("first_shop","targetname");
				//shop MoveTo( (-1156.88, -2385.88, 856.125), .5, .05, .05 );
				shop RotateTo( (0, GetDvarInt("ce_rotation"), 0), .05 );

				second_shop = getent("second_shop","targetname");
				second_shop RotateTo( (0, GetDvarInt("ce_rotation"), 0), .05 );
			}
		}
		wait(1);
	}
}

//--------------------------------------------------------------------------
// from _persistence.gsc in MP
//--------------------------------------------------------------------------

/*
=============
statGet

Returns the value of the named stat
=============
*/

statGet( dataName )
{
	return self getStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )) );
}

/*
=============
setStat

Sets the value of the named stat
=============
*/

statSet( dataName, value )
{
	self setStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )), value );	
}