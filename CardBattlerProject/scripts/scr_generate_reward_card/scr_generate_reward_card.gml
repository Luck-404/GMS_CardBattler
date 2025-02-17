//////////////////////////////////////////////////////////////////////
//					SCR_GENERATE_REWARD_CARD						//
//																	//
// > CALLED WHEN A TREASURE IS PICKED UP, GENERATES A REWARD		//
//////////////////////////////////////////////////////////////////////
function scr_generate_reward_card(_amount){
	for (var _i = 0; _i < _amount; _i++){
	show_debug_message("!!=== SCR_GEN_CARDS: CREATING A CARD ===!!");		
	//pick a random card from the entire pool, add it to the inventory
		var _rand = choose("echo","inspire","block","strike","bulwark","power");
		switch(_rand){
			//0 cost
			case "echo":
				var _card_echo = scr_create_card("Echo", "Next spell cast twice, exhaust", 0, scr_card_echo, spr_card_echo,"None","Uncolored","Utility","Any","Any",irandom_range(60,75),true);
				ds_list_add(global.card_inventory, _card_echo);
			break;
		
			case "inspire":
				var _card_inspiration = scr_create_card("Inspiration", "Gain 1 mana, exhaust", 0, scr_card_inspiration, spr_card_insirpation,"None","Uncolored","Utility","Any","Any",irandom_range(60,75),true);
				ds_list_add(global.card_inventory, _card_inspiration);
			break;
		
			//1 cost
			case "block":
				var _card_block = scr_create_card("Block", "Defend 5", 1, scr_card_block, spr_card_block,"Ally","Uncolored","Defend","Any","Any",irandom_range(30,45),false);
				ds_list_add(global.card_inventory, _card_block);
			break;
		
			case "strike":
				var _card_strike = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Enemy","Uncolored","Attack","Any","Any",irandom_range(30,45),false);
				ds_list_add(global.card_inventory, _card_strike);
			break;
		
			//2 cost
			case "bulwark":
				var _card_bulwark = scr_create_card("Bulwark", "Defend 10", 2, scr_card_bulwark, spr_card_bulwark,"Ally","Uncolored","Defend","Any","Any",irandom_range(60,75),false);
				ds_list_add(global.card_inventory, _card_bulwark);
			break;
		
			case "power":
				var _card_power_strike = scr_create_card("Power Strike", "Attack 12", 2, scr_card_power_strike, spr_card_power_strike,"Enemy","Uncolored","Attack","Any","Any",irandom_range(60,75),false);
				ds_list_add(global.card_inventory, _card_power_strike);
			break;
		}
	}
	
}