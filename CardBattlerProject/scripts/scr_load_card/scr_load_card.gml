//////////////////////////////////////////////////////////////////////
//							SCR_LOAD_CARD							//
//																	//
// > LOADS A CARD FROM THE SAVEFILE TO THE GAME BASED ON ITS NAME   //
//////////////////////////////////////////////////////////////////////
function scr_load_card(_cardname){
	_loadedcard = undefined;
	switch(_cardname){
		case "Potent Fruit":
			_loadedcard = scr_create_card("Potent Fruit", "2x Damage for 3 Turns", 3, scr_card_potent_fruit, spr_card_potent_fruit,"Any","Green","Buff",0,"Martial","Any",irandom_range(75,90),true);
		break;
		
		case "Grow Manavine":
			_loadedcard = scr_create_card("Grow Manavine", "+3 max mana for 3 turns", 2, scr_card_grow_manavine, spr_card_grow_manavine,"None","Green","Utility",0,"Technical","Any",irandom_range(60,75),true);	
		break;
		
		case "Nature's Remedy":
			_loadedcard = scr_create_card("Nature's Remedy", "Heal Ally 30% max HP", 2, scr_card_natures_remedy, spr_card_natures_remedy,"Any","Green","Heal",0,"Magical","Any",irandom_range(60,75),true);	
		break;

		case "Thorny Whip":
			_loadedcard = scr_create_card("Thorny Whip", "Attack 8", 0, scr_card_thorny_whip, spr_card_thorny_whip,"Any","Green","Attack",8,"Any","Any",irandom_range(30,45),false);
		break;
		
		case "Poison Ivy":
			_loadedcard = scr_create_card("Poison Ivy", "Poison up to 3 targets for 2 turns", 1, scr_card_poison_ivy, spr_card_poison_ivy,"Any","Green","DoT",0,"Any","Any",irandom_range(45,60),false);
		break;
		
		case "Fell":
			_loadedcard = scr_create_card("Fell", "Deal 30% hp damage to one unit", 2, scr_card_fell, spr_card_fell,"Any","Green","Attack",0.30,"Any","Any",irandom_range(60,75),false);
		break;
		
		case "Beastial Bash":
			_loadedcard = scr_create_card("Beastial Bash", "Deal damage to 3 units, stun 1", 3, scr_card_beastial_bash, spr_card_beastial_bash,"Any","Green","Attack",15,"Any","Any",irandom_range(75,90),true);
		break;
		
		case "Stampede":
			_loadedcard = scr_create_card("Stampede", "Deal damage to all units", 3, scr_card_stampede, spr_card_stampede,"Any","Green","Attack",30,"Any","Any",irandom_range(75,90),true);
		break;
		
		case "Echo":
			_loadedcard = scr_create_card("Echo", "Next spell cast twice, exhaust", 0, scr_card_echo, spr_card_echo,"None","Uncolored","Utility",0,"Any","Any",irandom_range(60,75),true);
		break;
		
		case "Inspiration":
			_loadedcard = scr_create_card("Inspiration", "Gain 1 mana, exhaust", 0, scr_card_inspiration, spr_card_insirpation,"None","Uncolored","Utility",0,"Any","Any",irandom_range(60,75),true);

		break;
		
		case "Strike":
			_loadedcard = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Any","Uncolored","Attack",6,"Any","Any",irandom_range(30,45),false);
		break;
		
		case "Power Strike":
			_loadedcard = scr_create_card("Power Strike", "Attack 12", 2, scr_card_power_strike, spr_card_power_strike,"Any","Uncolored","Attack",12,"Any","Any",irandom_range(60,75),false);
		break;
		
		case "Bulwark":
			_loadedcard = scr_create_card("Bulwark", "Defend 10", 2, scr_card_bulwark, spr_card_bulwark,"Any","Uncolored","Defend",0,"Any","Any",irandom_range(60,75),false);
		break;
		
		case "Block":
			_loadedcard = scr_create_card("Block", "Defend 5", 1, scr_card_block, spr_card_block,"Any","Uncolored","Defend",0,"Any","Any",irandom_range(30,45),false);
		break;		
		
		case "Default":
			_loadedcard = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Any","Uncolored","Attack",6,"Any","Any",irandom_range(30,45),false);
		break;
	}
	return _loadedcard;
}