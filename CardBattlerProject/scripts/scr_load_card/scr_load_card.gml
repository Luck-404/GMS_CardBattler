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
			_loadedcard = scr_create_card("Strike", "Deals 6 damage", 1, scr_card_strike, spr_card_strike, "Uncolored", "Attack", 6, "Any", "Any", "Common", false, "Melee",1);
		break;		
		
		case "Power Strike":
			_loadedcard = scr_create_card("Power Strike", "Deals 15 damage", 2, scr_card_power_strike, spr_card_power_strike, "Uncolored", "Attack", 15, "Any", "Any", "Uncommon", false, "Melee",1);
		break;
		
		//GREEN
		case "Thorny Whip":
			_loadedcard = scr_create_card("Thorny Whip", "Deal 8 damage", 0, scr_card_thorny_whip, spr_card_thorny_whip, "Green", "Attack", 8, "Any", "Any", "Common", false, "Ranged",1);
		break;
		
		case "Fell":
			_loadedcard = scr_create_card("Fell", "Deal 15% of the target's max hp as melee damage.", 2, scr_card_fell, spr_card_fell, "Green", "Attack", 15, "Any", "Any", "Uncommon", false, "Melee",1);
		break;	
		
		case "Beastial Bash":
			_loadedcard = scr_create_card("Beastial Bash", "Deal 12 damage to each target, also stun the middle target for 1 turn. Exhausts.", 2, scr_card_beastial_bash, spr_card_beastial_bash, "Green", "Attack", 12, "Any", "Any", "Rare", true, "Ranged", 3);
		break;		
		
		case "Stampede":
			_loadedcard = scr_create_card("Stampede", "Deal 40% of each target's max hp as damage. Exhausts.", 3, scr_card_stampede, spr_card_stampede, "Green", "Attack", 40, "Any", "Any", "Epic", true, "Ranged",5);
		break;		
		
		case "Snarling Bite":
			_loadedcard = scr_create_card("Snarling Bite", "Deal 4 Melee damage and apply vulnerable if health is hit.", 2, scr_card_snarling_bite, spr_card_snarling_bite, "Green", "Attack", 4, "Technical", "Hunter", "Uncommon", false, "Melee", 1);
		break;		
		
		/////////////
		// DEFENSE //
		/////////////
		//UNCOLORED
		case "Block":
			_loadedcard = scr_create_card("Block", "Add 8 defense to self", 1, scr_card_block, spr_card_block, "Uncolored", "Defense", 0, "Any", "Any", "Common", false, "Self",1);
		break;			
		
		case "Bulwark":
			_loadedcard = scr_create_card("Bulwark", "Add 20 defense to self", 2, scr_card_bulwark, spr_card_bulwark, "Uncolored", "Defense", 0, "Any", "Any", "Uncommon", false, "Self",1);
		break;
		//GREEN
		
		/////////////
		// UTILITY //
		/////////////
		//UNCOLORED
		case "Echo":
			_loadedcard = scr_create_card("Echo", "Increase echo count by 1, echo causes the next spell to cast x more times. Exhausts.", 0, scr_card_echo, spr_card_echo, "Uncolored", "Utility", 0, "Any", "Any", "Rare", true, "Targetless",0);
		break;		
		
		case "Inspiration":
			_loadedcard = scr_create_card("Inspiration", "Generates 1 bonus mana per turn, effect lasts 3 turns. Exhausts.", 0, scr_card_inspiration, spr_card_insirpation, "Uncolored", "Utility", 0, "Any", "Any", "Rare", true, "Targetless",0);
		break;
		
		//GREEN
		case "Grow Manavine":
			_loadedcard = scr_create_card("Grow Manavine", "Generates 2 bonus mana per turn, effect lasts 3 turns. Exhausts.", 3, scr_card_grow_manavine, spr_card_grow_manavine, "Green", "Utility", 0, "Technical", "Any", "Rare", true, "Targetless",0);	
		break;
		
		case "Life Spirit":
			_loadedcard = scr_create_card("Life Spirit", "Summon a 7hp life spirit, minion heals host 8% hp per turn.", 0, scr_card_life_spirit, spr_card_life_spirit, "Green", "Utility", 0, "Any", "Any", "Uncommon", false, "Ranged",1);	
		break;	

		case "Bramblet":
			_loadedcard = scr_create_card("Bramblet", "Summon a 12hp bramblet, minion generates 2 armor for self and 5 armor for host per turn, when host takes damage, deal 25% damage back to attacker. Exhausts.", 2, scr_card_bramblet, spr_card_bramblet, "Green", "Utility", 0, "Magical", "Summoner", "Rare", true, "Self",1);			
		break;	
		
		case "Bloodbeak":
			_loadedcard = scr_create_card("Bloodbeak", "Summon a 7hp bloodbeak, when host attacks it deals 5 damage to the same target, host gains 20% leech.", 2, scr_card_bloodbeak, spr_card_bloodbeak, "Green", "Utility", 0, "Any", "Any", "Rare", false, "Ranged", 1);
		break;			
	
		///////////
		// BUFFS //
		///////////
		//UNCOLORED
		
		//GREEN
		case "Potent Fruit":
			_loadedcard = scr_create_card("Potent Fruit", "Increase damage dealt by this unit by 2x, lasts 3 turns. Exhausts.", 2, scr_card_potent_fruit, spr_card_potent_fruit, "Green", "Buff", 0, "Martial", "Any", "Epic", true, "Self",1);
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
		//case "Clear Battlefield":
		//	//_loadedcard = scr_create_card("Clear Battlefield", "TODO", 0, scr_card_clear_battlefield, spr_card_clear_battlefield, "Uncolored", "Utility", 0, "Any", "Any", "Common", false, "Targetless",0);
		//break;						

		//GREEN
		case "Nature's Remedy":
			_loadedcard = scr_create_card("Nature's Remedy", "Heal target for 33% of their max hp.", 2, scr_card_natures_remedy, spr_card_natures_remedy, "Green", "Heal", 0, "Magical", "Any", "Rare", false, "Ranged",1);	
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
			_loadedcard = scr_create_card("Poison Ivy", "Apply a poison stack to 3 targets, lasts 3 turns (stackable).", 1, scr_card_poison_ivy, spr_card_poison_ivy, "Green", "DoT", 0, "Any", "Any", "Uncommon", false, "Ranged",3);
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
			_loadedcard = scr_create_card("Serpent Summon", "Summon 3 7hp serpents, while a serpent is alive host hunter gets +10dmg and 20% leech. When host takes damage each serpent applies 1 stack of venom. Exhausts.", 2, scr_card_serpent_summon, spr_card_serpent_summon, "Green", "Archetype", 0, "Technical", "Hunter", "Legendary", true, "Self",1);
		break;	
		
		case "Sprigs of Ygg":
			_loadedcard = scr_create_card("Sprigs of Ygg", "Summon 1hp spriggans in every open minion slot on target team, effect triggers once every turn for 5 turns giving spriggans stacks. Every turn each spriggan attacks enemies for x damage and heals each host for x hp, x being its stacks. Exhausts.", 3, scr_card_sprigs_of_ygg, spr_card_sprigs_of_ygg, "Green", "Archetype", 0, "Any", "Any", "Legendary", true, "Targetless",5);
		break;		
	}
	return _loadedcard;
}