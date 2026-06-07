//
//
// SCRIPT: SCR_GET_CARD_INFO | GET THE INFO OF AN INPUT CARD | RETURNS NEW DSMAP OF A CARD
//
//

function scr_get_card_info(_card_name){
	// NAME				- string
	// SPRITE			- sprite index
	// COLOR(S)			- ["COLOR1","COLOR2"] or ["COLOR1",undefined]
	// RANGE			- SELF, MELEE, RANGED, BACK, GLOBAL, TEAN
	// MAIN TYPE		- ATTACK, DEFENSE, SUPPORT, UTILITY, ARCHETYPE
	// STAT TYPE		- NEU, MAG, PHY
	// MAGNITUDE		- int
	// TARGETS			- int
	// ARCHETYPE REQ	- MAGICAL, MARTIAL, TECHNICAL
	// CLASS REQ		- MAGE, SUMMONER, PRIEST, SOLDIER, SAILOR, ADVENTURER, ENGINEER, MERCHANT, HUNTER
	// RARITY			- I, II, III, IV
	// MANA COST		- int
	// EXHAUSTS			- true or false
	// SCRIPT			- script index
	// DESC				- string
	
	
	
	//INIT NEW CARD MAP
	var _return_card = ds_map_create();
	
	//POPULATE WITH INFO GIVEN ITS NAME
	switch(_card_name){
		#region CERULEAN
		
		#endregion
		
		#region VERMILION
		
		#endregion
		
		#region VIRIDIAN
			#region LIFE_SPIRIT
			case "LIFE_SPIRIT":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","LIFE SPIRIT"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_viridian_life_spirit); //SPRITE
				ds_map_add(_return_card,"card_colors",["VIRIDIAN",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","RANGED"); //RANGE 
				ds_map_add(_return_card,"card_type","UTILITY"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",undefined); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","II"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",1); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_viridian_life_spirit); //SCRIPT
				ds_map_add(_return_card,"card_description","Ranged, ST, Summons 2/2 Life Spirit that heals host for +2 each round."); //DESCRIPTION	
			break;
			#endregion
			
			#region MIRACLE_MUSA
			case "MIRACLE_MUSA":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","MIRACLE MUSA"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_viridian_miracle_musa); //SPRITE
				ds_map_add(_return_card,"card_colors",["VIRIDIAN",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","RANGED"); //RANGE 
				ds_map_add(_return_card,"card_type","SUPPORT"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",undefined); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","II"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",1); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_viridian_miracle_musa); //SCRIPT
				ds_map_add(_return_card,"card_description","Ranged, ST, OVERHEALTH by [linear], lasts 3 turns."); //DESCRIPTION	
			break;		
			#endregion
		
			#region DISEASE
			case "DISEASE":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","DISEASE"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_viridian_disease); //SPRITE
				ds_map_add(_return_card,"card_colors",["VIRIDIAN",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","RANGED"); //RANGE 
				ds_map_add(_return_card,"card_type","ATTACK"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",undefined); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCHETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","II"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",2); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_viridian_disease); //SCRIPT
				ds_map_add(_return_card,"card_description","Ranged, ST, Weaken for 3 rounds"); //DESCRIPTION	
			break;		
			#endregion
		
			#region EMERALD_SLAM
			case "EMERALD_SLAM":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","EMERALD SLAM"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_viridian_emerald_slam); //SPRITE
				ds_map_add(_return_card,"card_colors",["VIRIDIAN",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","MELEE"); //RANGE 
				ds_map_add(_return_card,"card_type","ATTACK"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",undefined); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req","MARTIAL"); //ARCHETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","I"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",2); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_viridian_emerald_slam); //SCRIPT
				ds_map_add(_return_card,"card_description","Melee, ST, Stun for 1 turn"); //DESCRIPTION	
			break;		
			#endregion			
			
			#region GROWTH_SIGIL
			case "GROWTH_SIGIL":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","GROWTH SIGIL"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_viridian_growth_sigil); //SPRITE
				ds_map_add(_return_card,"card_colors",["VIRIDIAN",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","GLOBAL"); //RANGE 
				ds_map_add(_return_card,"card_type","UTILITY"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",undefined); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req","MAGICAL"); //ARCHETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","III"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",3); //MANA COST
				ds_map_add(_return_card,"card_exhausts",true); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_viridian_growth_sigil); //SCRIPT
				ds_map_add(_return_card,"card_description","Exhausts. Global. Set up rapid growth weather."); //DESCRIPTION	
			break;		
			#endregion
			
			#region EMERALD_WISDOM
			case "EMERALD_WISDOM":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","EMERALD WISDOM"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_viridian_emerald_wisdom); //SPRITE
				ds_map_add(_return_card,"card_colors",["VIRIDIAN",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","GLOBAL"); //RANGE 
				ds_map_add(_return_card,"card_type","UTILITY"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",undefined); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCHETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","III"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",3); //MANA COST
				ds_map_add(_return_card,"card_exhausts",true); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_viridian_emerald_wisdom); //SCRIPT
				ds_map_add(_return_card,"card_description","Exhausts. Global. Draw 2 more cards per turn, also heal lowest beast."); //DESCRIPTION	
			break;		
			#endregion			
		#endregion	
		
		#region UNCOLORED
			#region HIDDEN_CARD
			case "HIDDEN_CARD":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","HIDDEN CARD"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_hidden_card); //SPRITE
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","GLOBAL"); //RANGE 
				ds_map_add(_return_card,"card_type","UTILITY"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",1); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req","TECHNICAL"); //ARCHETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","I"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",0); //MANA COST
				ds_map_add(_return_card,"card_exhausts",true); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_hidden_card); //SCRIPT
				ds_map_add(_return_card,"card_description","Exhausts. Global. Draw a card."); //DESCRIPTION	
			break;		
			#endregion
			
			#region STRIKE		
			case "STRIKE":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","STRIKE"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_strike); //SPRITE
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","MELEE"); //RANGE 
				ds_map_add(_return_card,"card_type","ATTACK"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",5); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","I"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",1); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_strike); //SCRIPT
				ds_map_add(_return_card,"card_description","Melee, ST, Deals [linear] melee damage."); //DESCRIPTION	
			break;
			#endregion
		
			#region POWER_STRIKE		
			case "POWER_STRIKE":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","POWER STRIKE"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_power_strike); //SPRITE
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","MELEE"); //RANGE 
				ds_map_add(_return_card,"card_type","ATTACK"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",8); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","II"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",1); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_power_strike); //SCRIPT
				ds_map_add(_return_card,"card_description","Melee, ST, Deals [linear] melee damage."); //DESCRIPTION			
			break;	
			#endregion
		
			#region BLOCK		
			case "BLOCK":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","BLOCK"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_block); //SPRITE
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","SELF"); //RANGE 
				ds_map_add(_return_card,"card_type","DEFENSE"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",6); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","I"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",1); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_block); //SCRIPT
				ds_map_add(_return_card,"card_description","Self, ST, Add [linear] armor to self."); //DESCRIPTION
			break;
			#endregion
		
			#region BULWARK
			case "BULWARK":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","BULWARK"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_bulwark); //SPRITE
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","SELF"); //RANGE 
				ds_map_add(_return_card,"card_type","DEFENSE"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",12); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","II"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",2); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_bulwark); //SCRIPT
				ds_map_add(_return_card,"card_description","Self, ST, Add [linear] armor to self."); //DESCRIPTION
			break;		
			#endregion
		
			#region INSPIRATION
			case "INSPIRATION":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","INSPIRATION"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_inspiration); //SPRITE		
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","GLOBAL"); //RANGE 
				ds_map_add(_return_card,"card_type","UTILITY"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",undefined); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",0); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","II"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",1); //MANA COST
				ds_map_add(_return_card,"card_exhausts",true); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_inspiration); //SCRIPT
				ds_map_add(_return_card,"card_description","Exhausts. Global, Generates 1 bonus mana per turn, effect lasts 3 turns."); //DESCRIPTION
			break;		
			#endregion		
	
			#region ECHO
			case "ECHO":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","ECHO"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_echo); //SPRITE					
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","GLOBAL"); //RANGE 
				ds_map_add(_return_card,"card_type","UTILITY"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",1); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",0); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","III"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",0); //MANA COST
				ds_map_add(_return_card,"card_exhausts",true); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_echo); //SCRIPT
				ds_map_add(_return_card,"card_description","Exhausts. Global, Increase echo count by 1, echo causes the next non-echo spell to cast X more times."); //DESCRIPTION
			break;		
			#endregion
		
			#region DEFT_STRIKE
			case "DEFT_STRIKE":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","DEFT STRIKE"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_deft_strike); //SPRITE			
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","BACK"); //RANGE 
				ds_map_add(_return_card,"card_type","ATTACK"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",3); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","II"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",1); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_deft_strike); //SCRIPT
				ds_map_add(_return_card,"card_description","Backline, ST, Deals [linear] damage, apply one bleed stack"); //DESCRIPTION
			break;		
			#endregion
		
			#region RESPOSITION
			case "RESPOSITION":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","RESPOSITION"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_reposition); //SPRITE		
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","TEAM"); //RANGE 
				ds_map_add(_return_card,"card_type","UTILITY"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",0); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","I"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",0); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_reposition); //SCRIPT
				ds_map_add(_return_card,"card_description","Self, ST, Swap Positions with another team unit"); //DESCRIPTION
			break;		
			#endregion
		
			#region CLEARCAST
			case "CLEARCAST":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","CLEARCAST"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_clearcast); //SPRITE			
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","GLOBAL"); //RANGE 
				ds_map_add(_return_card,"card_type","UTILITY"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",0); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",0); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","I"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",1); //MANA COST
				ds_map_add(_return_card,"card_exhausts",true); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_clearcast); //SCRIPT
				ds_map_add(_return_card,"card_description","Exhausts. Global, Clear all weather"); //DESCRIPTION
			break;		
			#endregion
		
			#region RAPID_STRIKES
			case "RAPID_STRIKES":
				//INIT VARIABLESs
				ds_map_add(_return_card,"card_name","RAPID STRIKES"); //NAME
				ds_map_add(_return_card,"card_sprite",spr_card_uncolored_rapid_strikes); //SPRITE					
				ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
				ds_map_add(_return_card,"card_range","RANGED"); //RANGE 
				ds_map_add(_return_card,"card_type","ATTACK"); //TYPE
				ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
				ds_map_add(_return_card,"card_magnitude",2); //MAGNITUDE
				ds_map_add(_return_card,"card_targets",1); //TARGETS
				ds_map_add(_return_card,"card_archetype_req",undefined); //ARCJETYPE REQ
				ds_map_add(_return_card,"card_class_req",undefined); //CLASS REQ
				ds_map_add(_return_card,"card_rarity","II"); //RARITY
				ds_map_add(_return_card,"card_mana_cost",1); //MANA COST
				ds_map_add(_return_card,"card_exhausts",false); //EXHAUSTS
				ds_map_add(_return_card,"card_script",scr_card_uncolored_rapid_strikes); //SCRIPT
				ds_map_add(_return_card,"card_description","Ranged, ST, Deals [linear] damage 3x."); //DESCRIPTION
			break;		
			#endregion
		
		#endregion
	}
	
	//ADD UID
	ds_map_add(_return_card,"card_uid",global.card_uid);
	global.card_uid++;
	
	//RETURN NEW CARD MAP
	return _return_card;
}