//===============================================================================//
//
// GAME END: OBJ_PLAYER
// FUNCTION: Logs the final player-session state and delegates destruction of all
//           persistent OBJ_PLAYER-owned runtime resources to
//           SCR_PLAYER_TEARDOWN_SESSION.
//
//===============================================================================//

#region SESSION SUMMARY

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
if (
	variable_global_exists("list_player_party") &&
	global.list_player_party != undefined &&
	ds_exists(global.list_player_party,ds_type_list)
){
	_ct_party = ds_list_size(global.list_player_party);
}

if (
	variable_global_exists("list_player_ranch") &&
	global.list_player_ranch != undefined &&
	ds_exists(global.list_player_ranch,ds_type_list)
){
	_ct_ranch = ds_list_size(global.list_player_ranch);
}

//----------------//
//CARD COUNTS//
//----------------//
if (
	variable_global_exists("list_player_deck") &&
	global.list_player_deck != undefined &&
	ds_exists(global.list_player_deck,ds_type_list)
){
	_ct_deck = ds_list_size(global.list_player_deck);
}

if (
	variable_global_exists("list_player_library") &&
	global.list_player_library != undefined &&
	ds_exists(global.list_player_library,ds_type_list)
){
	_ct_library = ds_list_size(global.list_player_library);
}

//----------------//
//INVENTORY COUNT//
//----------------//
if (
	variable_global_exists("list_player_inventory") &&
	global.list_player_inventory != undefined &&
	ds_exists(global.list_player_inventory,ds_type_list)
){
	_ct_inventory = ds_list_size(global.list_player_inventory);
}

//----------------//
//TREASURE COUNT//
//----------------//
if (
	variable_global_exists("map_player_chests_opened") &&
	global.map_player_chests_opened != undefined &&
	ds_exists(global.map_player_chests_opened,ds_type_map)
){
	_ct_opened_chests = ds_map_size(global.map_player_chests_opened);
}

//----------------//
//LOGBOOK COUNTS//
//----------------//
if (
	variable_global_exists("list_logbook_beasts") &&
	global.list_logbook_beasts != undefined &&
	ds_exists(global.list_logbook_beasts,ds_type_list)
){
	_ct_logbook_beasts = ds_list_size(global.list_logbook_beasts);
}

if (
	variable_global_exists("list_logbook_cards") &&
	global.list_logbook_cards != undefined &&
	ds_exists(global.list_logbook_cards,ds_type_list)
){
	_ct_logbook_cards = ds_list_size(global.list_logbook_cards);
}

//----------------//
//MARKET COUNT//
//----------------//
if (
	variable_global_exists("map_market_stock") &&
	global.map_market_stock != undefined &&
	ds_exists(global.map_market_stock,ds_type_map)
){
	_ct_markets = ds_map_size(global.map_market_stock);
}

#endregion

#region DEBUG SESSION END

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

#endregion

#region SESSION TEARDOWN

//================//
//SESSION TEARDOWN//
//================//
var _stct_cleanup =
	scr_player_teardown_session();

#endregion

#region DEBUG COMPLETE

//================//
//DEBUG COMPLETE//
//================//
scr_debug_log(
	"PLAYER",
	"SHUTDOWN",
	self,
	"PLAYER SESSION CLEANUP COMPLETE" +
	" | DS RESOURCES DESTROYED: " +
	string(
		_stct_cleanup
			._ct_ds_destroyed
	) +
	" | CAMERA DESTROYED: " +
	(
		_stct_cleanup
			._flag_camera_destroyed
		? "YES"
		: "NO"
	),
	"INFO",
	"OBJ_PLAYER:GAME_END"
);

#endregion