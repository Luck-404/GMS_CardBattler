//////////////////////////////////////////////////////////////////////
//							SCR_LOAD_CARD							//
//																	//
// > LOADS A CARD FROM THE SAVEFILE TO THE GAME BASED ON ITS NAME   //
//////////////////////////////////////////////////////////////////////
function scr_load_card(_cardname){
	_loadedcard = undefined;
	switch(_cardname){
		/////////////
		// ATTACKS //
		/////////////
		//UNCOLORED
		case "Strike":
			_loadedcard = scr_create_card("Strike", "Deals 6 damage to the target in the front row", 1, scr_card_strike, spr_card_strike, "Any", "Uncolored", "Attack", 6, "Any", "Any", 20, false);
		break;		
		
		case "Power Strike":
			_loadedcard = scr_create_card("Power Strike", "Deals 12 damage on the target in the front row", 2, scr_card_power_strike, spr_card_power_strike, "Any", "Uncolored", "Attack", 12, "Any", "Any", 20, false);
		break;		
		
		//GREEN
		case "Thorny Whip":
			_loadedcard = scr_create_card("Thorny Whip", "Deals 8 damage to any target", 0, scr_card_thorny_whip, spr_card_thorny_whip, "Any", "Green", "Attack", 8, "Any", "Any", 20, false);
		break;
		
		case "Fell":
			_loadedcard = scr_create_card("Fell", "Deals 30% hp to the front unit", 2, scr_card_fell, spr_card_fell, "Any", "Green", "Attack", 0.30, "Any", "Any", 20, false);
		break;	
		
		case "Beastial Bash":
			_loadedcard = scr_create_card("Beastial Bash", "Deal 10 damage to 3 targets, stun the center unit for 1 turn", 3, scr_card_beastial_bash, spr_card_beastial_bash, "Any", "Green", "Attack", 10, "Any", "Any", 20, false);
		break;		
		
		case "Stampede":
			_loadedcard = scr_create_card("Stampede", "Deal 20% hp to all units, exhaust", 3, scr_card_stampede, spr_card_stampede, "Any", "Green", "Attack", .20, "Any", "Any", 20, true);
		break;		
		/////////////
		// DEFENSE //
		/////////////
		//UNCOLORED
		case "Block":
			_loadedcard = scr_create_card("Block", "Adds 5 defense to self", 1, scr_card_block, spr_card_block, "Any", "Uncolored", "Defend", 0, "Any", "Any", 20, false);
		break;			
		
		case "Bulwark":
			_loadedcard = scr_create_card("Bulwark", "Adds 10 defense to self", 2, scr_card_bulwark, spr_card_bulwark, "Any", "Uncolored", "Defend", 0, "Any", "Any", 20, false);
		break;
		//GREEN
		
		/////////////
		// UTILITY //
		/////////////
		//UNCOLORED
		case "Echo":
			_loadedcard = scr_create_card("Echo", "Repeat next spell for free, exhaust", 0, scr_card_echo, spr_card_echo, "None", "Uncolored", "Utility", 0, "Any", "Any", 20, true);
		break;		
		
		case "Inspiration":
			_loadedcard = scr_create_card("Inspiration", "1 extra mana for a turn, exhaust", 0, scr_card_inspiration, spr_card_insirpation, "None", "Uncolored", "Utility", 0, "Any", "Any", 20, true);
		break;
		
		//GREEN
		case "Grow Manavine":
			_loadedcard = scr_create_card("Grow Manavine", "+3 max mana for 3 turns", 2, scr_card_grow_manavine, spr_card_grow_manavine, "None", "Green", "Utility", 0, "Technical", "Any", 20, true);	
		break;
	
		///////////
		// BUFFS //
		///////////
		//UNCOLORED
		
		//GREEN
		case "Potent Fruit":
			_loadedcard = scr_create_card("Potent Fruit", "Increase damage by 2x for 3 turns, exhaust", 3, scr_card_potent_fruit, spr_card_potent_fruit, "Any", "Green", "Buff", 0, "Martial", "Any", 20, true);
		break;
		/////////////
		// DEBUFFS //
		/////////////
		//UNCOLORED
		
		//GREEN
		
		///////////
		// HEALS //
		///////////
		//UNCOLORED
		case "Clear Battlefield":
			//_loadedcard = scr_create_card("Clear Battlefield", "Clear damage zones", 0, scr_card_clear_battlefield, spr_card_clear_battlefield, "None", "Uncolored", "Utility", 0, "Any", "Any", 20, false);
		break;						

		//GREEN
		case "Nature's Remedy":
			_loadedcard = scr_create_card("Nature's Remedy", "Heal a unit for 30% HP", 2, scr_card_natures_remedy, spr_card_natures_remedy, "Any", "Green", "Heal", 0, "Magical", "Any", 20, true);	
		break;
		
		////////
		// CC //
		////////	
		//UNCOLORED
		
		//GREEN
		
		/////////
		// DOT //
		/////////
		//UNCOLORED
		
		//GREEN
		case "Poison Ivy":
			_loadedcard = scr_create_card("Poison Ivy", "Apply poison to 3 units for 1 turn", 1, scr_card_poison_ivy, spr_card_poison_ivy, "Any", "Green", "DoT", 0, "Any", "Any", 20, false);
		break;
		
		///////////
		// AURAS //
		///////////	
		//UNCOLORED
		
		//GREEN
		
		///////////////
		// ARCHETYPE //
		///////////////	
		//UNCOLORED
		
		//GREEN
		
		case "Default":
			_loadedcard = scr_create_card("Strike", "Deals 6 damage to the target in the front row", 1, scr_card_strike, spr_card_strike, "Any", "Uncolored", "Attack", 6, "Any", "Any", 20, false);
		break;
	}
	return _loadedcard;
}