//////////////////////////////////////////////////////////////////////
//							OBJ_CARD_SHOP CREATE					//
//																	//
// > ESTABLISH VARIABLES AND LISTS									//
//////////////////////////////////////////////////////////////////////
global.card_shop_stock = ds_list_create(); //hold a stock of cards that the player can buy, can be updated

// stock cards on create
scr_stock_card_shop(irandom_range(3,9)); //stocks the card shop from 3-9 cards, less cards means higher quality

_interacted = false;