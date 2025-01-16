function scr_generate_card(_rarity) {
    var _card;
    switch (_rarity) {
        case "normal":
			var _rand = choose("inspire","block","strike");		
			switch(_rand){
				case "inspire":			
				_card = scr_create_card("Inspiration", "Gain 1 mana, exhaust", 0, scr_card_inspiration, spr_card_insirpation,"None","Uncolored","Utility","Any");
				break;
				case "block":			
				_card = scr_create_card("Block", "Defend 5", 1, scr_card_block, spr_card_block,"Ally","Uncolored","Defend","Any");
				break;
				case "strike":			
				_card = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Enemy","Uncolored","Attack","Any");
				break;				
			}
            break;
        case "rare":
			_rand = choose("echo","power","bulwark");	
			switch(_rand){
				case "echo":			
					 _card = scr_create_card("Echo", "Next spell cast twice, exhaust", 0, scr_card_echo, spr_card_echo,"None","Uncolored","Utility","Any");
				break;
				case "power":			
					 _card = scr_create_card("Power Strike", "Attack 12", 2, scr_card_power_strike, spr_card_power_strike,"Enemy","Uncolored","Attack","Any");
				break;
				case "bulwark":			
					 _card = scr_create_card("Bulwark", "Defend 10", 2, scr_card_bulwark, spr_card_bulwark,"Ally","Uncolored","Defend","Any");
				break;				
			}
            break;
    }
    return _card;
}