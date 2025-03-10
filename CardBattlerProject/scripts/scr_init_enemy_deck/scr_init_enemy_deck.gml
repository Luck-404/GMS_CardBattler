//////////////////////////////////////////////////////////////////////
//						SCR_INIT_ENEMY_DECK							//
//																	//
// > GIVE UP TO 5 CARDS TO EACH CREATURE							//
//////////////////////////////////////////////////////////////////////
function scr_init_enemy_deck(_creature,_ref_creature_name){
switch(_ref_creature_name){
		#region	Bush Monkey
		case "Bush Monkey": //GREEN MARTIAL ADVENTURER
			var _card_1 = scr_create_card("Strike", "Deals 6 damage to the target in the front row", 1, scr_card_strike, spr_card_strike, "Uncolored", "Attack", 6, "Any", "Any", 20, false, "Melee");
			var _card_2 = scr_create_card("Block", "Adds 5 defense to self", 1, scr_card_block, spr_card_block, "Uncolored", "Defend", 0, "Any", "Any", 20, false, "Self");
			var _card_3 = scr_create_card("Block", "Adds 5 defense to self", 1, scr_card_block, spr_card_block, "Uncolored", "Defend", 0, "Any", "Any", 20, false, "Self");
			var _card_4 = scr_create_card("Thorny Whip", "Deals 8 damage to any target", 0, scr_card_thorny_whip, spr_card_thorny_whip, "Green", "Attack", 8, "Any", "Any", 20, false, "Ranged");
			var _card_5 = scr_create_card("Thorny Whip", "Deals 8 damage to any target", 0, scr_card_thorny_whip, spr_card_thorny_whip, "Green", "Attack", 8, "Any", "Any", 20, false, "Ranged");
			
			//add to a tp list
			var _tmp_list = ds_list_create();
			ds_list_add(_tmp_list, _card_1);
			ds_list_add(_tmp_list, _card_2);
			ds_list_add(_tmp_list, _card_3);
			ds_list_add(_tmp_list, _card_4);
			ds_list_add(_tmp_list, _card_5);
			
			while (ds_list_size(_tmp_list) > 0){
				//pull from a random card in tmplist,
				var _index = irandom_range(0,ds_list_size(_tmp_list)-1);
				var _final_card = ds_list_find_value(_tmp_list,_index);
				// add to deck
				ds_list_add(_creature._deck,_final_card);	
				//remove from tmplist 
				ds_list_delete(_tmp_list, _index);	
			}
		break;
		#endregion
		
		
		
		#region Corpseflower
		case "Corpseflower": //GREEN MAGICAL SUMMONER
			_card_1 = scr_create_card("Nature's Remedy", "Heal a unit for 20% HP", 2, scr_card_natures_remedy, spr_card_natures_remedy, "Green", "Heal", 0, "Magical", "Any", 20, false, "Ranged");	
			_card_2 = scr_create_card("Poison Ivy", "Apply poison to 3 units for 1 turn", 1, scr_card_poison_ivy, spr_card_poison_ivy, "Green", "DoT", 0, "Any", "Any", 20, false, "Ranged");
			_card_3 = scr_create_card("Poison Ivy", "Apply poison to 3 units for 1 turn", 1, scr_card_poison_ivy, spr_card_poison_ivy, "Green", "DoT", 0, "Any", "Any", 20, false, "Ranged");
			_card_4 = scr_create_card("Life Spirit", "Summon a healer minion with 5hp, heals host unit 5% hp per turn", 0, scr_card_life_spirit, spr_card_life_spirit, "Green", "Utility", 0, "Any", "Any", 20, false, "Ranged");	
			_card_5 = scr_create_card("Bramblet", "Summon bramble minion on self, passively generates 5 armor for host, when host is attacked 10% damage is dealt back to caster", 2, scr_card_bramblet, spr_card_bramblet, "Green", "Utility", 0, "Magical", "Summoner", 20, true, "Self");	
			
			//add to a tp list
			_tmp_list = ds_list_create();
			ds_list_add(_tmp_list, _card_1);
			ds_list_add(_tmp_list, _card_2);
			ds_list_add(_tmp_list, _card_3);
			ds_list_add(_tmp_list, _card_4);
			ds_list_add(_tmp_list, _card_5);
			
			while (ds_list_size(_tmp_list) > 0){
				//pull from a random card in tmplist,
				var _index = irandom_range(0,ds_list_size(_tmp_list)-1);
				var _final_card = ds_list_find_value(_tmp_list,_index);
				// add to deck
				ds_list_add(_creature._deck,_final_card);	
				//remove from tmplist 
				ds_list_delete(_tmp_list, _index);	
			}			
		break;
		#endregion
		
		
		
		#region Furn
		case "Furn": //GREEN TECHNICAL HUNTER
			_card_1 = scr_create_card("Strike", "Deals 6 damage to the target in the front row", 1, scr_card_strike, spr_card_strike, "Uncolored", "Attack", 6, "Any", "Any", 20, false, "Melee");
			_card_2 = scr_create_card("Fell", "Deals 10% max hp to the front unit", 2, scr_card_fell, spr_card_fell, "Green", "Attack", 10, "Any", "Any", 20, false, "Melee");
			_card_3 = scr_create_card("Fell", "Deals 10% max hp to the front unit", 2, scr_card_fell, spr_card_fell, "Green", "Attack", 10, "Any", "Any", 20, false, "Melee");
			_card_4 = scr_create_card( "Strike", "Deals 6 damage to the target in the front row", 1, scr_card_strike, spr_card_strike, "Uncolored", "Attack", 6, "Any", "Any", 20, false, "Melee");
			_card_5 = scr_create_card("Thorny Whip", "Deals 8 damage to any target", 0, scr_card_thorny_whip, spr_card_thorny_whip, "Green", "Attack", 8, "Any", "Any", 20, false, "Ranged");
			
			//add to a tp list
			_tmp_list = ds_list_create();
			ds_list_add(_tmp_list, _card_1);
			ds_list_add(_tmp_list, _card_2);
			ds_list_add(_tmp_list, _card_3);
			ds_list_add(_tmp_list, _card_4);
			ds_list_add(_tmp_list, _card_5);
			
			while (ds_list_size(_tmp_list) > 0){
				//pull from a random card in tmplist,
				var _index = irandom_range(0,ds_list_size(_tmp_list)-1);
				var _final_card = ds_list_find_value(_tmp_list,_index);
				// add to deck
				ds_list_add(_creature._deck,_final_card);	
				//remove from tmplist 
				ds_list_delete(_tmp_list, _index);	
			}					
		break;
		#endregion	
	}
}