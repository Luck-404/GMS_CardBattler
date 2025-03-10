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
			_loadedcard = scr_create_card("Strike", "Deals 6 damage to the target in the front row", 1, scr_card_strike, spr_card_strike, "Uncolored", "Attack", 6, "Any", "Any", 20, false, "Melee");
		break;		
		
		case "Power Strike":
			_loadedcard = scr_create_card("Power Strike", "Deals 12 damage on the target in the front row", 2, scr_card_power_strike, spr_card_power_strike, "Uncolored", "Attack", 12, "Any", "Any", 20, false, "Melee");
		break;
		
		//GREEN
		case "Thorny Whip":
			_loadedcard = scr_create_card("Thorny Whip", "Deals 8 damage to any target", 0, scr_card_thorny_whip, spr_card_thorny_whip, "Green", "Attack", 8, "Any", "Any", 20, false, "Ranged");
		break;
		
		case "Fell":
			_loadedcard = scr_create_card("Fell", "Deals 10% max hp to the front unit", 2, scr_card_fell, spr_card_fell, "Green", "Attack", 10, "Any", "Any", 20, false, "Melee");
		break;	
		
		case "Beastial Bash":
			_loadedcard = scr_create_card("Beastial Bash", "Deal 10 damage to 3 targets, stun the center unit for 1 turn", 3, scr_card_beastial_bash, spr_card_beastial_bash, "Green", "Attack", 10, "Any", "Any", 20, false, "Ranged");
		break;		
		
		case "Stampede":
			_loadedcard = scr_create_card("Stampede", "Deal 30% max hp to all units, exhaust", 3, scr_card_stampede, spr_card_stampede, "Green", "Attack", 30, "Any", "Any", 20, true, "Ranged");
		break;		
		/////////////
		// DEFENSE //
		/////////////
		//UNCOLORED
		case "Block":
			_loadedcard = scr_create_card("Block", "Adds 5 defense to self", 1, scr_card_block, spr_card_block, "Uncolored", "Defend", 0, "Any", "Any", 20, false, "Self");
		break;			
		
		case "Bulwark":
			_loadedcard = scr_create_card("Bulwark", "Adds 10 defense to self", 2, scr_card_bulwark, spr_card_bulwark, "Uncolored", "Defend", 0, "Any", "Any", 20, false, "Self");
		break;
		//GREEN
		
		/////////////
		// UTILITY //
		/////////////
		//UNCOLORED
		case "Echo":
			_loadedcard = scr_create_card("Echo", "Repeat next spell for free, exhaust", 0, scr_card_echo, spr_card_echo, "Uncolored", "Utility", 0, "Any", "Any", 20, true, "Targetless");
		break;		
		
		case "Inspiration":
			_loadedcard = scr_create_card("Inspiration", "1 extra mana for a turn, exhaust", 0, scr_card_inspiration, spr_card_insirpation, "Uncolored", "Utility", 0, "Any", "Any", 20, true, "Targetless");
		break;
		
		//GREEN
		case "Grow Manavine":
			_loadedcard = scr_create_card("Grow Manavine", "Add 2 extra mana to the pool for 3 turns, exhaust", 3, scr_card_grow_manavine, spr_card_grow_manavine, "Green", "Utility", 0, "Technical", "Any", 20, true, "Targetless");	
		break;
		
		case "Life Spirit":
			_loadedcard = scr_create_card("Life Spirit", "Summon a healer minion with 5hp, heals host unit 5% hp per turn", 0, scr_card_life_spirit, spr_card_life_spirit, "Green", "Utility", 0, "Any", "Any", 20, false, "Ranged");	
		break;	

		case "Bramblet":
			_loadedcard = scr_create_card("Bramblet", "Summon bramble minion on self, passively generates 5 armor for host, when host is attacked 10% damage is dealt back to caster", 2, scr_card_bramblet, spr_card_bramblet, "Green", "Utility", 0, "Magical", "Summoner", 20, true, "Self");			
		break;	
		
		case "Bloodbeak":
			_loadedcard = scr_create_card("Bloodbeak", "Summon a bloodbeak minion, when the host deals damage the bloodbeak heals the host for 20% of their damage done, and also deals 5 damage to the same target", 2, scr_card_bloodbeak, spr_card_bloodbeak, "Green", "Utility", 0, "Any", "Any", 20, false, "Ranged");
		break;			
	
		///////////
		// BUFFS //
		///////////
		//UNCOLORED
		
		//GREEN
		case "Potent Fruit":
			_loadedcard = scr_create_card("Potent Fruit", "Increase damage by 2x for 3 turns, exhaust", 3, scr_card_potent_fruit, spr_card_potent_fruit, "Green", "Buff", 0, "Martial", "Any", 20, true, "Self");
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
			//_loadedcard = scr_create_card("Clear Battlefield", "Clear damage zones", 0, scr_card_clear_battlefield, spr_card_clear_battlefield, "Uncolored", "Utility", 0, "Any", "Any", 20, false, "Targetless");
		break;						

		//GREEN
		case "Nature's Remedy":
			_loadedcard = scr_create_card("Nature's Remedy", "Heal a unit for 20% HP", 2, scr_card_natures_remedy, spr_card_natures_remedy, "Green", "Heal", 0, "Magical", "Any", 20, false, "Ranged");	
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
			_loadedcard = scr_create_card("Poison Ivy", "Apply poison to 3 units for 1 turn", 1, scr_card_poison_ivy, spr_card_poison_ivy, "Green", "DoT", 0, "Any", "Any", 20, false, "Ranged");
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
		case "Serpent Summon":
			_loadedcard = scr_create_card("Serpent Summon", "Spawn three 6/6 coiled serpents, these serpents react to damage on the host and apply a stack of venom, while a serpent is alive hunter gets 10% leech and 10 bonus damage, exhaust.", 2, scr_card_serpent_summon, spr_card_serpent_summon, "Green", "Archetype", 0, "Technical", "Hunter", 20, true, "Self");
		break;	
		
		case "Sprigs of Ygg":
			_loadedcard = scr_create_card("Sprigs of Ygg", "For 5 rounds spawn a Spriggan at the beginning of each player round in all empty minion slots. This minion will deal damage and heal host for 2*stacks. If there is a Spriggan already in a spot, instead increase its stacks by 1 each, exhaust.", 3, scr_card_sprigs_of_ygg, spr_card_sprigs_of_ygg, "Green", "Archetype", 0, "Any", "Any", 20, true, "Targetless");
		break;		
	}
	return _loadedcard;
}