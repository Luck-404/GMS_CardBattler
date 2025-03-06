// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_init_enemy_deck(_creature,_ref_creature_name){
	switch(_ref_creature_name){
		case "Bush Monkey":
			//give them a list of cards
			var _card_1 = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Any","Uncolored",6,"Attack","Any","Any",irandom_range(30,45),false);
			var _card_2 = scr_create_card("Block", "Defend 5", 1, scr_card_block, spr_card_block,"Any","Uncolored","Defend",0,"Any","Any",irandom_range(30,45),false);
			var _card_3 = scr_create_card("Thorny Whip", "Attack 8", 0, scr_card_thorny_whip, spr_card_thorny_whip,"Any","Green","Attack",8,"Any","Any",irandom_range(30,45),false);
			ds_list_add(_creature._deck, _card_1);
			ds_list_add(_creature._deck, _card_2);
			ds_list_add(_creature._deck, _card_3);	
		break;
		
		case "Corpseflower":
			//give them a list of cards
			_card_1 = scr_create_card("Nature's Remedy", "Heal Ally 30% max HP", 2, scr_card_natures_remedy, spr_card_natures_remedy,"Any","Green","Heal",0,"Magical","Any",irandom_range(60,75),true);	
			_card_2 = scr_create_card("Poison Ivy", "Poison up to 3 targets for 2 turns", 1, scr_card_poison_ivy, spr_card_poison_ivy,"Any","Green","Attack",0,"Any","Any",irandom_range(45,60),false);
			_card_3 = scr_create_card("Thorny Whip", "Attack 8", 0, scr_card_thorny_whip, spr_card_thorny_whip,"Any","Green","Attack",8,"Any","Any",irandom_range(30,45),false);
			ds_list_add(_creature._deck, _card_1);
			ds_list_add(_creature._deck, _card_2);
			ds_list_add(_creature._deck, _card_3);	
		break;
		
		case "Furn":
			//give them a list of cards
			_card_1 = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Any","Uncolored","Attack",6,"Any","Any",irandom_range(30,45),false);
			_card_2 = scr_create_card("Fell", "Deal 30% hp damage to one unit", 2, scr_card_fell, spr_card_fell,"Any","Green","Attack",0.30,"Any","Any",irandom_range(60,75),false);
			_card_3 = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Any","Uncolored","Attack",6,"Any","Any",irandom_range(30,45),false);
			ds_list_add(_creature._deck, _card_1);
			ds_list_add(_creature._deck, _card_2);
			ds_list_add(_creature._deck, _card_3);	
		break;
	}
}