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
			var _rand = choose("Block","Strike","Thorny Whip","Life Spirit");	//clear battlefield card
			_card = scr_load_card(_rand);				
            break;
			
        case "uncommon":
			_rand = choose("Power Strike","Bulwark","Fell","Poison Ivy");
			_card = scr_load_card(_rand);				
            break;
			
        case "rare":
			_rand = choose("Echo","Inspiration","Beastial Bash","Nature's Remedy","Grow Manavine","Bramblet","Bloodbeak");
			_card = scr_load_card(_rand);	
		break;
		
        case "epic":
			_rand = choose("Stampede","Potent Fruit");
			_card = scr_load_card(_rand);			
		break;	
		
        case "legendary":
			_rand = choose("");
		break;		
    }
    return _card;
}