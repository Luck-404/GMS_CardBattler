///////////////
// VARIABLES //
///////////////
global.mercenary_shop_stock = ds_list_create(); //hold a stock of mercs that the player can buy, can be updated

// stock cards on create
scr_stock_mercenary_shop(irandom_range(3,9)); //stocks the card shop from 3-9 cards, less cards means higher quality

global.merc_shop_gui_open = false; //track if the shop GUI is open, will set player speed to 0 and not allow for other menus to open up while it is.