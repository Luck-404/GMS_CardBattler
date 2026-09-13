//===============================================================================//
//
// GAME END: OBJ_PLAYER
// FUNCTION: Logs the final player-session state and destroys all persistent
//           data structures owned by OBJ_PLAYER.
//           Cleans Beast, Card, Minion, Inventory, Treasure, Logbook, Market,
//           and Camera runtime resources before application shutdown.
//
//===============================================================================//

//================//
//SESSION SUMMARY//
//================//
var _ct_party = 0;
var _ct_ranch = 0;

var _ct_deck = 0;
var _ct_library = 0;

var _ct_inventory = 0;
var _ct_opened_chests = 0;

var _ct_logbook_beasts = 0;
var _ct_logbook_cards = 0;

var _ct_markets = 0;

//----------------//
//BEAST COUNTS//
//----------------//
if (ds_exists(global.list_player_party,ds_type_list)){
	_ct_party = ds_list_size(global.list_player_party);
}

if (ds_exists(global.list_player_ranch,ds_type_list)){
	_ct_ranch = ds_list_size(global.list_player_ranch);
}

//----------------//
//CARD COUNTS//
//----------------//
if (ds_exists(global.list_player_deck,ds_type_list)){
	_ct_deck = ds_list_size(global.list_player_deck);
}

if (ds_exists(global.list_player_library,ds_type_list)){
	_ct_library = ds_list_size(global.list_player_library);
}

//----------------//
//INVENTORY COUNT//
//----------------//
if (ds_exists(global.list_player_inventory,ds_type_list)){
	_ct_inventory = ds_list_size(global.list_player_inventory);
}

//----------------//
//TREASURE COUNT//
//----------------//
if (ds_exists(global.map_player_chests_opened,ds_type_map)){
	_ct_opened_chests = ds_map_size(global.map_player_chests_opened);
}

//----------------//
//LOGBOOK COUNTS//
//----------------//
if (ds_exists(global.list_logbook_beasts,ds_type_list)){
	_ct_logbook_beasts = ds_list_size(global.list_logbook_beasts);
}

if (ds_exists(global.list_logbook_cards,ds_type_list)){
	_ct_logbook_cards = ds_list_size(global.list_logbook_cards);
}

//----------------//
//MARKET COUNT//
//----------------//
if (ds_exists(global.map_market_stock,ds_type_map)){
	_ct_markets = ds_map_size(global.map_market_stock);
}

//================//
//DEBUG SESSION END//
//================//
scr_debug_log(
	"PLAYER",
	"SHUTDOWN",
	self,
	"PLAYER SESSION ENDING" +
	" | ROOM: " + room_get_name(room) +
	" | POSITION: (" +
	string(round(x)) + "," +
	string(round(y)) + ")" +
	" | GOLD: " +
	string(global.val_player_gold) +
	" | PARTY: " +
	string(_ct_party) +
	" | RANCH: " +
	string(_ct_ranch) +
	" | DECK: " +
	string(_ct_deck) +
	" | LIBRARY: " +
	string(_ct_library) +
	" | INVENTORY ENTRIES: " +
	string(_ct_inventory) +
	" | OPENED CHESTS: " +
	string(_ct_opened_chests) +
	" | LOGBOOK BEASTS: " +
	string(_ct_logbook_beasts) +
	" | LOGBOOK CARDS: " +
	string(_ct_logbook_cards) +
	" | MARKETS: " +
	string(_ct_markets),
	"INFO",
	"OBJ_PLAYER:GAME_END"
);

//================//
//CLEANUP TRACKING//
//================//
var _ct_ds_destroyed = 0;
var _flag_camera_destroyed = false;

//================//
//BEAST GLOBALS//
//================//
if (ds_exists(global.list_player_party,ds_type_list)){

	ds_list_destroy(global.list_player_party);
	_ct_ds_destroyed++;
}

if (ds_exists(global.list_player_ranch,ds_type_list)){

	ds_list_destroy(global.list_player_ranch);
	_ct_ds_destroyed++;
}

//================//
//CARD GLOBALS//
//================//
if (ds_exists(global.list_player_deck,ds_type_list)){

	ds_list_destroy(global.list_player_deck);
	_ct_ds_destroyed++;
}

if (ds_exists(global.list_player_library,ds_type_list)){

	ds_list_destroy(global.list_player_library);
	_ct_ds_destroyed++;
}

if (ds_exists(global.list_pool_cards_rarity_I,ds_type_list)){

	ds_list_destroy(global.list_pool_cards_rarity_I);
	_ct_ds_destroyed++;
}

if (ds_exists(global.list_pool_cards_rarity_II,ds_type_list)){

	ds_list_destroy(global.list_pool_cards_rarity_II);
	_ct_ds_destroyed++;
}

if (ds_exists(global.list_pool_cards_rarity_III,ds_type_list)){

	ds_list_destroy(global.list_pool_cards_rarity_III);
	_ct_ds_destroyed++;
}

if (ds_exists(global.list_pool_cards_rarity_IV,ds_type_list)){

	ds_list_destroy(global.list_pool_cards_rarity_IV);
	_ct_ds_destroyed++;
}

//================//
//MINION GLOBALS//
//================//
if (ds_exists(global.list_pool_viridian_minions,ds_type_list)){

	ds_list_destroy(global.list_pool_viridian_minions);
	_ct_ds_destroyed++;
}

if (ds_exists(global.list_pool_cerulean_minions,ds_type_list)){

	ds_list_destroy(global.list_pool_cerulean_minions);
	_ct_ds_destroyed++;
}

if (ds_exists(global.list_pool_vermilion_minions,ds_type_list)){

	ds_list_destroy(global.list_pool_vermilion_minions);
	_ct_ds_destroyed++;
}

//================//
//ITEM GLOBALS//
//================//
if (ds_exists(global.list_player_inventory,ds_type_list)){

	ds_list_destroy(global.list_player_inventory);
	_ct_ds_destroyed++;
}

if (ds_exists(global.list_pool_items,ds_type_list)){

	ds_list_destroy(global.list_pool_items);
	_ct_ds_destroyed++;
}

//================//
//PLAYER TRACKING//
//================//
if (ds_exists(global.map_player_chests_opened,ds_type_map)){

	ds_map_destroy(global.map_player_chests_opened);
	_ct_ds_destroyed++;
}

//================//
//LOGBOOK GLOBALS//
//================//
if (ds_exists(global.list_logbook_beasts,ds_type_list)){

	ds_list_destroy(global.list_logbook_beasts);
	_ct_ds_destroyed++;
}

if (ds_exists(global.map_logbook_beasts,ds_type_map)){

	ds_map_destroy(global.map_logbook_beasts);
	_ct_ds_destroyed++;
}

if (ds_exists(global.list_logbook_cards,ds_type_list)){

	ds_list_destroy(global.list_logbook_cards);
	_ct_ds_destroyed++;
}

if (ds_exists(global.map_logbook_cards,ds_type_map)){

	ds_map_destroy(global.map_logbook_cards);
	_ct_ds_destroyed++;
}

//================//
//MARKET GLOBALS//
//================//
if (ds_exists(global.map_market_stock,ds_type_map)){

	ds_map_destroy(global.map_market_stock);
	_ct_ds_destroyed++;
}

//================//
//CAMERA//
//================//
if (global.ref_camera != undefined){

	camera_destroy(global.ref_camera);

	global.ref_camera = undefined;

	_flag_camera_destroyed = true;
}

//================//
//CLEAR REFERENCES//
//================//
global.ref_interacting_npc = undefined;
global.stct_forced_enemy_unit = undefined;

global.arr_last_enemy_pool = [];
global.arr_market_egg_beast_pool = [];

global.flag_companion_summoned = false;

//================//
//DEBUG COMPLETE//
//================//
scr_debug_log(
	"PLAYER",
	"SHUTDOWN",
	self,
	"PLAYER SESSION CLEANUP COMPLETE" +
	" | DS RESOURCES DESTROYED: " +
	string(_ct_ds_destroyed) +
	" | CAMERA DESTROYED: " +
	(_flag_camera_destroyed ? "YES" : "NO"),
	"INFO",
	"OBJ_PLAYER:GAME_END"
);