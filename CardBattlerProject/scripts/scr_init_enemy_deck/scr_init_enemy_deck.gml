function scr_init_enemy_deck(_creature,_ref_creature_name){
	switch(_ref_creature_name){
		case "Bush Monkey":
			//give them a list of cards
			var _card_1 = scr_create_card("Strike", "Deals 6 damage to the target in the front row", 1, scr_card_strike, spr_card_strike, "Any", "Uncolored", "Attack", 6, "Any", "Any", 20, false);
			var _card_2 = scr_create_card("Block", "Adds 5 defense to self", 1, scr_card_block, spr_card_block, "Any", "Uncolored", "Defend", 0, "Any", "Any", 20, false);
			var _card_3 = scr_create_card("Thorny Whip", "Deals 8 damage to any target", 0, scr_card_thorny_whip, spr_card_thorny_whip, "Any", "Green", "Attack", 8, "Any", "Any", 20, false);
			ds_list_add(_creature._deck, _card_1);
			ds_list_add(_creature._deck, _card_2);
			ds_list_add(_creature._deck, _card_3);		
		break;
		
		case "Corpseflower":
			//give them a list of cards
			_card_1 = scr_create_card("Nature's Remedy", "Heal a unit for 30% HP", 2, scr_card_natures_remedy, spr_card_natures_remedy, "Any", "Green", "Heal", 0, "Magical", "Any", 20, true);	
			_card_2 = scr_create_card("Poison Ivy", "Apply poison to 3 units for 1 turn", 1, scr_card_poison_ivy, spr_card_poison_ivy, "Any", "Green", "DoT", 0, "Any", "Any", 20, false);
			_card_3 = scr_create_card("Thorny Whip", "Deals 8 damage to any target", 0, scr_card_thorny_whip, spr_card_thorny_whip, "Any", "Green", "Attack", 8, "Any", "Any", 20, false);
			ds_list_add(_creature._deck, _card_1);
			ds_list_add(_creature._deck, _card_2);
			ds_list_add(_creature._deck, _card_3);	
		break;
		
		case "Furn":
			//give them a list of cards
			_card_1 = scr_create_card("Strike", "Deals 6 damage to the target in the front row", 1, scr_card_strike, spr_card_strike, "Any", "Uncolored", "Attack", 6, "Any", "Any", 20, false);
			_card_2 = scr_create_card("Fell", "Deals 30% hp to the front unit", 2, scr_card_fell, spr_card_fell, "Any", "Green", "Attack", 0.30, "Any", "Any", 20, false);
			_card_3 = scr_create_card("Strike", "Deals 6 damage to the target in the front row", 1, scr_card_strike, spr_card_strike, "Any", "Uncolored", "Attack", 6, "Any", "Any", 20, false);
			ds_list_add(_creature._deck, _card_1);
			ds_list_add(_creature._deck, _card_2);
			ds_list_add(_creature._deck, _card_3);			
		break;
	}
}