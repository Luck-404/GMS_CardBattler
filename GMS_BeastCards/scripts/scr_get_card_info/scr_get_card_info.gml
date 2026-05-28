//
//
// SCRIPT: SCR_GET_CARD_INFO | GET THE INFO OF AN INPUT CARD | RETURNS NEW DSMAP OF A CARD
//
//

function scr_get_card_info(_card_name){
	// NAME				- string
	// SPRITE			- sprite index
	// COLOR(S)			- ["COLOR1","COLOR2"] or ["COLOR1",undefined]
	// RANGE			- SELF, MELEE, RANGED, BACK, GLOBAL
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
			
		#endregion
		
		#region UNCOLORED
		#region STRIKE		
		case "STRIKE":
			//INIT VARIABLESs
			ds_map_add(_return_card,"card_name","STRIKE"); //NAME
			ds_map_add(_return_card,"card_sprite",spr_card_uncolored_strike); //SPRITE
			ds_map_add(_return_card,"card_colors",["UNCOLORED",undefined]); //COLOR(s)
			ds_map_add(_return_card,"card_range","MELEE"); //RANGE 
			ds_map_add(_return_card,"card_type","ATTACK"); //TYPE
			ds_map_add(_return_card,"card_stat","NEU"); //STAT TYPE- WHAY KIND OF POW (MPOW OR PPOW) CAUSES THE MAGNITUDE TO GO UP
			ds_map_add(_return_card,"card_magnitude",8); //MAGNITUDE
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
			ds_map_add(_return_card,"card_magnitude",16); //MAGNITUDE
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
			ds_map_add(_return_card,"card_magnitude",8); //MAGNITUDE
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
			ds_map_add(_return_card,"card_magnitude",20); //MAGNITUDE
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
			ds_map_add(_return_card,"card_description","X. Global, Increase echo count by 1, echo causes the next non-echo spell to cast X more times."); //DESCRIPTION
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
			ds_map_add(_return_card,"card_magnitude",4); //MAGNITUDE
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
			ds_map_add(_return_card,"card_range","SELF"); //RANGE 
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
			ds_map_add(_return_card,"card_description","Self, Adjacent, Swap Positions with adjacent unit"); //DESCRIPTION
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