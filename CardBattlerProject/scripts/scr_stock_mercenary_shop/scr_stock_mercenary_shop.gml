function scr_stock_mercenary_shop(_merc_count) {
    ds_list_clear(global.mercenary_shop_stock);

    // Determine rarity logic based on the number of mercs
    for (var _i = 0; _i < _merc_count; _i++) {
        var _merc = scr_generate_creature();
        ds_list_add(global.mercenary_shop_stock, _merc);
    }
	
	//if (global.overworld_pipeline_state == PIPELINE_STATE.IDLE){
	//	show_debug_message("SCR_STOCK_MERC_SHOP: SUCESS...");
	//	global.overworld_pipeline_state = PIPELINE_STATE.CHECK_NPC;
	//}	
}