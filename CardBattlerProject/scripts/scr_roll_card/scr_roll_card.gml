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
			//var _rand = choose("block","strike","clear","thorny");		
			var _rand = choose("block","strike","thorny","life spirit");					
			switch(_rand){
				case "block":			
				_card = scr_create_card("Block", "Adds 5 defense to self", 1, scr_card_block, spr_card_block, "Any", "Uncolored", "Defend", 0, "Any", "Any", irandom_range(10,20), false);
				break;
				case "strike":			
				_card = scr_create_card("Strike", "Deals 6 damage to the target in the front row", 1, scr_card_strike, spr_card_strike, "Any", "Uncolored", "Attack", 6, "Any", "Any", irandom_range(10,20), false);
				break;		
				case "clear":			
				//_card = scr_create_card("Clear Battlefield", "Clear damage zones", 0, scr_card_clear_battlefield, spr_card_clear_battlefield, "None", "Uncolored", "Utility", 0, "Any", "Any", irandom_range(10,20), false);
				break;
				case "thorny":
				_card = scr_create_card("Thorny Whip", "Deals 8 damage to any target", 0, scr_card_thorny_whip, spr_card_thorny_whip, "Any", "Green", "Attack", 8, "Any", "Any", irandom_range(10,20), false);
				break;
				case "life spirit":
				_card = scr_create_card("Life Spirit", "Summon a healer minion with 5hp, heals host unit 5% hp per turn", 0, scr_card_life_spirit, spr_card_life_spirit, "Green", "Utility", 0, "Any", "Any", irandom_range(10,20), false, "Ranged");	
				break;			
			}
            break;
			
        case "uncommon":
			_rand = choose(,"power","bulwark","fell","ivy");	
			switch(_rand){			
				case "power":			
					 _card = scr_create_card("Power Strike", "Deals 12 damage on the target in the front row", 2, scr_card_power_strike, spr_card_power_strike, "Any", "Uncolored", "Attack", 12, "Any", "Any", irandom_range(20,40), false);
				break;
				case "bulwark":			
					 _card = scr_create_card("Bulwark", "Adds 10 defense to self", 2, scr_card_bulwark, spr_card_bulwark, "Any", "Uncolored", "Defend", 0, "Any", "Any", irandom_range(20,40), false);
				break;
				case "fell":			
					 _card = scr_create_card("Fell", "Deals 30% hp to the front unit", 2, scr_card_fell, spr_card_fell, "Any", "Green", "Attack", 0.30, "Any", "Any", irandom_range(20,40), false);
				break;			
				case "ivy":			
					 _card = scr_create_card("Poison Ivy", "Apply poison to 3 units for 1 turn", 1, scr_card_poison_ivy, spr_card_poison_ivy, "Any", "Green", "DoT", 0, "Any", "Any", irandom_range(20,40), false);
				break;							
			}
            break;
			
        case "rare":
			_rand = choose("echo","inspire","bash","remedy","manavine","bramblet");
			switch(_rand){
				case "echo":			
					 _card = scr_create_card("Echo", "Repeat next spell for free, exhaust", 0, scr_card_echo, spr_card_echo, "None", "Uncolored", "Utility", 0, "Any", "Any", irandom_range(40,60), true);
				break;		
				case "inspire":			
					 _card = scr_create_card("Inspiration", "1 extra mana for a turn, exhaust", 0, scr_card_inspiration, spr_card_insirpation, "None", "Uncolored", "Utility", 0, "Any", "Any", irandom_range(40,60), true);
				break;
				case "bash":			
					 _card = scr_create_card("Beastial Bash", "Deal 10 damage to 3 targets, stun the center unit for 1 turn", 3, scr_card_beastial_bash, spr_card_beastial_bash, "Any", "Green", "Attack", 10, "Any", "Any", irandom_range(40,60), true);
				break;	
				case "remedy":			
					 _card = scr_create_card("Nature's Remedy", "Heal a unit for 30% HP", 2, scr_card_natures_remedy, spr_card_natures_remedy, "Any", "Green", "Heal", 0, "Magical", "Any", irandom_range(40,60), true);	
				break;	
				case "manavine":			
					 _card = scr_create_card("Grow Manavine", "Add 2 extra mana to the pool for 3 turns, exhaust", 3, scr_card_grow_manavine, spr_card_grow_manavine, "None", "Green", "Utility", 0, "Technical", "Any", irandom_range(40,60), true);	
				break;			
				case "bramblet":
					_card = scr_create_card("Bramblet", "Summon bramble minion on self, passively generates 5 armor for host, when host is attacked 10% damage is dealt back to caster", 2, scr_card_bramblet, spr_card_bramblet, "Green", "Utility", 0, "Magical", "Summoner", irandom_range(40,60), true, "Self");
				break;
			}
		break;
		
        case "epic":
			_rand = choose("stampede","potent");
			//irandom_range(60,80)
			switch(_rand){			
			case "stampede":			
				_card = scr_create_card("Stampede", "Deal 20% hp to all units, exhaust", 3, scr_card_stampede, spr_card_stampede, "Any", "Green", "Attack", .20, "Any", "Any", irandom_range(60,80), true);
			break;			
			case "potent":			
				_card = scr_create_card("Potent Fruit", "Increase damage by 2x for 3 turns, exhaust", 3, scr_card_potent_fruit, spr_card_potent_fruit, "Any", "Green", "Buff", 0, "Martial", "Any", 20, true);
			break;				
			}
		break;	
		
        case "legendary":
			_rand = choose("");
			//irandom_range(80,100)
		break;		
    }
    return _card;
}