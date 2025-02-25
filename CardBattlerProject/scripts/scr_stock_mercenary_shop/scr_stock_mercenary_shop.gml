//////////////////////////////////////////////////////////////////////
//					SCR_STOCK_MERC_SHOP								//
//																	//
// > STOCKS THE MERC SHOP WITH X MERCS.								//
//////////////////////////////////////////////////////////////////////
function scr_stock_mercenary_shop(_merc_count) {
    //clear current shop
	ds_list_clear(global.mercenary_shop_stock);

    for (var _i = 0; _i < _merc_count; _i++) {
        var _merc = scr_roll_creature();
        ds_list_add(global.mercenary_shop_stock, _merc);
    }
}