//////////////////////////////////////////////////////////////////////
//					SCR_STOCK_CARD_SHOP								//
//																	//
// > STOCKS THE CARD SHOP WITH x CARDS WITH VARYING RARITIES		//
//////////////////////////////////////////////////////////////////////
function scr_stock_card_shop(_card_count) {
	//clear current shop
    ds_list_clear(global.card_shop_stock);

    // Roll a rarity for each card
    for (var _i = 0; _i < _card_count; _i++) {
        var _rarity_roll = irandom_range(1, 100); // Determine rarity
        var _card = undefined;
		
		if (50 < _rarity_roll < 100){ //50% common
			_card = scr_roll_card("common");
		} else if (20 < _rarity_roll < 50){ //30% uncommon
			_card = scr_roll_card("uncommon");
		} else if (10 < _rarity_roll < 20){ //10% rare
			_card = scr_roll_card("rare");
		} else if (3 < _rarity_roll < 10){ //7% epic
			_card = scr_roll_card("epic");
		} else if (1 < _rarity_roll < 3){ //3% legendary
			_card = scr_roll_card("legendary");
		}
			
        ds_list_add(global.card_shop_stock, _card);
    }
}