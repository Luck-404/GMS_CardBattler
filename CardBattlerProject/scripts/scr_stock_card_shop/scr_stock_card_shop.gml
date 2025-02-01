function scr_stock_card_shop(_card_count) {
    ds_list_clear(global.card_shop_stock);

    // Determine rarity logic based on the number of cards
    for (var _i = 0; _i < _card_count; _i++) {
        var _rarity_roll = irandom_range(1, 100); // Determine rarity
        var _card = undefined;

        if (_card_count <= 5 && _rarity_roll > 50) {
            // Higher rarity for fewer cards
            _card = scr_generate_card("rare");
        } else if (_rarity_roll > 80) {
            // Chance for rare cards in larger shops
            _card = scr_generate_card("rare");
        } else {
            _card = scr_generate_card("normal");
        }

        ds_list_add(global.card_shop_stock, _card);
    }
	
	if (global.overworld_pipeline_state == PIPELINE_STATE.IDLE){
		show_debug_message("SCR_STOCK_CARD_SHOP: SUCESS...");
		global.overworld_pipeline_state = PIPELINE_STATE.CHECK_NPC;
	}
}