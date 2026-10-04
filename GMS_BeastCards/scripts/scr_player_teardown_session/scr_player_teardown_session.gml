//===============================================================================//
//
// SCRIPT: SCR_PLAYER_TEARDOWN_SESSION
// FUNCTION: Destroys persistent runtime resources owned by OBJ_PLAYER.
//           Releases player/session DS lists and maps, destroys the dynamic
//           overworld camera, and clears persistent runtime references.
//
//           This function is safe to reuse for Game End and future explicit
//           session-reset paths such as Exit to Title or New Game.
//
// RETURNS: Struct containing the number of DS resources destroyed and whether
//          the player-owned camera was destroyed.
//
//===============================================================================//

function scr_player_teardown_session(){

	#region VARIABLES

	//================//
	//CLEANUP TRACKING//
	//================//
	var _ct_ds_destroyed = 0;
	var _flag_camera_destroyed = false;

	#endregion

	#region BEAST GLOBALS

	//================//
	//PLAYER PARTY//
	//================//
	if (
		variable_global_exists("list_player_party") &&
		global.list_player_party != undefined &&
		ds_exists(global.list_player_party,ds_type_list)
	){
		ds_list_destroy(global.list_player_party);
		global.list_player_party = undefined;

		_ct_ds_destroyed++;
	}

	//================//
	//PLAYER RANCH//
	//================//
	if (
		variable_global_exists("list_player_ranch") &&
		global.list_player_ranch != undefined &&
		ds_exists(global.list_player_ranch,ds_type_list)
	){
		ds_list_destroy(global.list_player_ranch);
		global.list_player_ranch = undefined;

		_ct_ds_destroyed++;
	}

	#endregion

	#region CARD GLOBALS

	//================//
	//PLAYER DECK//
	//================//
	if (
		variable_global_exists("list_player_deck") &&
		global.list_player_deck != undefined &&
		ds_exists(global.list_player_deck,ds_type_list)
	){
		ds_list_destroy(global.list_player_deck);
		global.list_player_deck = undefined;

		_ct_ds_destroyed++;
	}

	//================//
	//PLAYER LIBRARY//
	//================//
	if (
		variable_global_exists("list_player_library") &&
		global.list_player_library != undefined &&
		ds_exists(global.list_player_library,ds_type_list)
	){
		ds_list_destroy(global.list_player_library);
		global.list_player_library = undefined;

		_ct_ds_destroyed++;
	}

	#region STATIC POOLS

	//================//
	//CARD POOLS//
	//================//
	if (variable_global_exists("arr_pool_cards_rarity_I")){
		global.arr_pool_cards_rarity_I = [];
	}

	if (variable_global_exists("arr_pool_cards_rarity_II")){
		global.arr_pool_cards_rarity_II = [];
	}

	if (variable_global_exists("arr_pool_cards_rarity_III")){
		global.arr_pool_cards_rarity_III = [];
	}

	if (variable_global_exists("arr_pool_cards_rarity_IV")){
		global.arr_pool_cards_rarity_IV = [];
	}

	//================//
	//MINION POOLS//
	//================//
	if (variable_global_exists("arr_pool_viridian_minions")){
		global.arr_pool_viridian_minions = [];
	}

	if (variable_global_exists("arr_pool_cerulean_minions")){
		global.arr_pool_cerulean_minions = [];
	}

	if (variable_global_exists("arr_pool_vermilion_minions")){
		global.arr_pool_vermilion_minions = [];
	}

	//================//
	//ITEM POOL//
	//================//
	if (variable_global_exists("arr_pool_items")){
		global.arr_pool_items = [];
	}

	#endregion

	#region ITEM GLOBALS

	//================//
	//PLAYER INVENTORY//
	//================//
	if (
		variable_global_exists("list_player_inventory") &&
		global.list_player_inventory != undefined &&
		ds_exists(global.list_player_inventory,ds_type_list)
	){
		ds_list_destroy(global.list_player_inventory);
		global.list_player_inventory = undefined;

		_ct_ds_destroyed++;
	}

	#endregion

	#region PLAYER TRACKING

	//================//
	//OPENED CHESTS//
	//================//
	if (
		variable_global_exists("map_player_chests_opened") &&
		global.map_player_chests_opened != undefined &&
		ds_exists(global.map_player_chests_opened,ds_type_map)
	){
		ds_map_destroy(global.map_player_chests_opened);
		global.map_player_chests_opened = undefined;

		_ct_ds_destroyed++;
	}

	#endregion

	#region LOGBOOK GLOBALS

	//================//
	//BEAST LIST//
	//================//
	if (
		variable_global_exists("list_logbook_beasts") &&
		global.list_logbook_beasts != undefined &&
		ds_exists(global.list_logbook_beasts,ds_type_list)
	){
		ds_list_destroy(global.list_logbook_beasts);
		global.list_logbook_beasts = undefined;

		_ct_ds_destroyed++;
	}

	//================//
	//BEAST MAP//
	//================//
	if (
		variable_global_exists("map_logbook_beasts") &&
		global.map_logbook_beasts != undefined &&
		ds_exists(global.map_logbook_beasts,ds_type_map)
	){
		ds_map_destroy(global.map_logbook_beasts);
		global.map_logbook_beasts = undefined;

		_ct_ds_destroyed++;
	}

	//================//
	//CARD LIST//
	//================//
	if (
		variable_global_exists("list_logbook_cards") &&
		global.list_logbook_cards != undefined &&
		ds_exists(global.list_logbook_cards,ds_type_list)
	){
		ds_list_destroy(global.list_logbook_cards);
		global.list_logbook_cards = undefined;

		_ct_ds_destroyed++;
	}

	//================//
	//CARD MAP//
	//================//
	if (
		variable_global_exists("map_logbook_cards") &&
		global.map_logbook_cards != undefined &&
		ds_exists(global.map_logbook_cards,ds_type_map)
	){
		ds_map_destroy(global.map_logbook_cards);
		global.map_logbook_cards = undefined;

		_ct_ds_destroyed++;
	}

	#endregion

	#region MARKET GLOBALS

	//================//
	//MARKET STOCK//
	//================//
	if (
		variable_global_exists("map_market_stock") &&
		global.map_market_stock != undefined &&
		ds_exists(global.map_market_stock,ds_type_map)
	){
		ds_map_destroy(global.map_market_stock);
		global.map_market_stock = undefined;

		_ct_ds_destroyed++;
	}

	#endregion

	#region CAMERA

	//================//
	//PLAYER CAMERA//
	//================//
	if (
		variable_global_exists("ref_camera") &&
		global.ref_camera != undefined
	){
		camera_destroy(global.ref_camera);

		global.ref_camera = undefined;

		_flag_camera_destroyed = true;
	}

	#endregion

	#region REFERENCES

	//================//
	//RUNTIME REFERENCES//
	//================//
	if (variable_global_exists("ref_interacting_npc")){
		global.ref_interacting_npc = undefined;
	}

	if (variable_global_exists("stct_forced_enemy_unit")){
		global.stct_forced_enemy_unit = undefined;
	}

	if (variable_global_exists("arr_last_enemy_pool")){
		global.arr_last_enemy_pool = [];
	}

	if (variable_global_exists("arr_market_egg_beast_pool")){
		global.arr_market_egg_beast_pool = [];
	}

	if (variable_global_exists("flag_companion_summoned")){
		global.flag_companion_summoned = false;
	}

	#endregion

	#region RESULT

	//================//
	//RETURN CLEANUP//
	//================//
	return {
		_ct_ds_destroyed : _ct_ds_destroyed,
		_flag_camera_destroyed : _flag_camera_destroyed
	};

	#endregion
}