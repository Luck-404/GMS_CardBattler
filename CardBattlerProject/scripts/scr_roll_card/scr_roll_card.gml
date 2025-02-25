//////////////////////////////////////////////////////////////////////
//						SCR_ROLL_CARD								//
//																	//
// > USED WHEN STOCKING THE CARD SHOPS. STOCK THE SHOPS WITH A		//
//   VARIETY OF CARDS. THE SHOP RESETS EVERY TIME 3 ENCOUNTERS HAVE //
//   BEEN COMPLETED, HIGHER RARITY GENERATES A BETTER CARD.			//
//////////////////////////////////////////////////////////////////////
function scr_roll_card(_rarity) {
    var _card;
    switch (_rarity) {
        case "common":
			var _rand = choose("block","strike");		
			switch(_rand){
				case "block":			
				_card = scr_create_card("Block", "Defend 5", 1, scr_card_block, spr_card_block,"Ally","Uncolored","Defend","Any","Any",irandom_range(30,45),false);
				break;
				case "strike":			
				_card = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Enemy","Uncolored","Attack","Any","Any",irandom_range(30,45),false);
				break;				
			}
            break;
			
        case "uncommon":
			_rand = choose(,"power","bulwark","inspire");	
			switch(_rand){
				case "inspire":			
				_card = scr_create_card("Inspiration", "Gain 1 mana, exhaust", 0, scr_card_inspiration, spr_card_insirpation,"None","Uncolored","Utility","Any","Any",irandom_range(60,75),true);
				break;				
				case "power":			
					 _card = scr_create_card("Power Strike", "Attack 12", 2, scr_card_power_strike, spr_card_power_strike,"Enemy","Uncolored","Attack","Any","Any",irandom_range(60,75),false);
				break;
				case "bulwark":			
					 _card = scr_create_card("Bulwark", "Defend 10", 2, scr_card_bulwark, spr_card_bulwark,"Ally","Uncolored","Defend","Any","Any",irandom_range(60,75),false);
				break;				
			}
            break;
			
        case "rare":
			_rand = choose("echo");
			switch(_rand){
				case "echo":			
					 _card = scr_create_card("Echo", "Next spell cast twice, exhaust", 0, scr_card_echo, spr_card_echo,"None","Uncolored","Utility","Any","Any",irandom_range(60,75),true);
				break;		
			}
		break;
		
        case "epic":
			_rand = choose("");
		break;	
		
        case "legendary":
			_rand = choose("");
		break;		
    }
    return _card;
}