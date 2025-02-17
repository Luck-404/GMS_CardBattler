//////////////////////////////////////////////////////////////////////
//					SCR_STOCK_MERC_SHOP								//
//																	//
// > STOCKS THE MERC SHOP WITH X MERCS.								//
//////////////////////////////////////////////////////////////////////
function scr_stock_mercenary_shop(_merc_count) {
    ds_list_clear(global.mercenary_shop_stock);

    // Determine rarity logic based on the number of mercs
    for (var _i = 0; _i < _merc_count; _i++) {
        var _merc = scr_generate_creature();
        ds_list_add(global.mercenary_shop_stock, _merc);
    }
}