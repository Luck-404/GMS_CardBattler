//////////////////////////////////////////////////////////////////////
//					OBJ_MERC_SHOP CREATE							//
//																	//
// > ESTABLISH VARIABLES AND LISTS									//
//////////////////////////////////////////////////////////////////////
global.mercenary_shop_stock = ds_list_create(); //hold a stock of mercs that the player can buy, can be updated

// stock cards on create
scr_stock_mercenary_shop(irandom_range(3,9)); //stocks the card shop from 3-9 cards

_interacted = false;