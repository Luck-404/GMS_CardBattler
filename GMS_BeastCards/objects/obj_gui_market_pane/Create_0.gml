//===============================================================================//
//
// CREATE: OBJ_GUI_MARKET_PANE
// FUNCTION: Initializes the generic market pane.
//           Supports egg, prism, and NPC vendor stock and purchasing.
//           Uses persistent market UID stock through global.map_market_stock.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
_str_type = "MARKET";

_str_market_type = "EGG";
_str_market_uid = "DEFAULT_MARKET";

_ref_market_owner = undefined;
_ref_npc = undefined;

_arr_external_stock = [];
_arr_stock = [];

_str_header_text = "BEAST EGG MARKET";

_flag_return_to_npc = false;
_flag_npc_interaction_released = false;

_ct_cols = 3;
_ct_offers = 3;

_val_pane_w = 800;
_val_pane_h = 500;

_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_val_panel_w = 220;
_val_panel_h = 350;
_val_panel_gap = 30;
_val_panel_row_gap = 20;

_val_total_offer_w = (_ct_offers * _val_panel_w) + ((_ct_offers - 1) * _val_panel_gap);
_val_panel_start_x = x - (_val_total_offer_w * 0.5);
_val_panel_y = _val_pane_top + 95;

_flag_clicked = false;
_ct_cooldown = 0;

//================//
//INIT//
//================//
depth = -100;

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_GUI_MARKET_INIT
// FUNCTION: Initializes Market stock after external values are assigned.
//           Supports Egg, Prism, and NPC vendors.
//           Configures layout and logs the Market opening.
//
// ARGUMENTS: None.
// RETURNS: True when the Market initializes successfully.
//
//-------------------------------------------------------------------------------//
function hscr_gui_market_init(){

	//================//
	//MARKET TYPE//
	//================//
	switch (_str_market_type){

		case "EGG":

			_arr_stock = scr_market_get_egg_stock(
				_str_market_uid
			);

			_str_header_text = "BEAST EGG MARKET";

			_ct_offers = array_length(_arr_stock);
			_ct_cols = 3;

			_val_panel_w = 220;
			_val_panel_h = 350;
			_val_panel_gap = 30;
			_val_panel_row_gap = 20;
			_val_panel_y = _val_pane_top + 95;

		break;

		case "PRISM":

			_arr_stock = scr_market_get_prism_stock(
				_str_market_uid
			);

			_str_header_text = "PRISM VENDOR";

			_ct_offers = array_length(_arr_stock);
			_ct_cols = 3;

			_val_panel_w = 170;
			_val_panel_h = 165;
			_val_panel_gap = 25;
			_val_panel_row_gap = 20;
			_val_panel_y = _val_pane_top + 95;

		break;

		case "NPC":

			_arr_stock = scr_market_get_npc_stock(
				_str_market_uid,
				_arr_external_stock
			);

			if (
				instance_exists(_ref_npc) &&
				_ref_npc._stct_npc != undefined
			){

				_str_header_text =
					string(_ref_npc._stct_npc._str_npc_name) +
					" | TRADE";
			}
			else{
				_str_header_text = "VENDOR";
			}

			_ct_offers = array_length(_arr_stock);
			_ct_cols = 3;

			_val_panel_w = 170;
			_val_panel_h = 210;
			_val_panel_gap = 25;
			_val_panel_row_gap = 20;
			_val_panel_y = _val_pane_top + 95;

			_flag_return_to_npc = true;

		break;

		default:

			_arr_stock = [];
			_ct_offers = 0;

			scr_debug_log(
				"MARKET",
				"INIT",
				self,
				"MARKET INITIALIZATION FAILED" +
				" | TYPE: " +
				string_upper(_str_market_type) +
				" | UID: " +
				string_upper(_str_market_uid) +
				" | REASON: UNKNOWN MARKET TYPE",
				"ERROR",
				"OBJ_GUI_MARKET_PANE:HSCR_GUI_MARKET_INIT"
			);

			return false;
	}

	//================//
	//UPDATE LAYOUT//
	//================//
	var _ct_layout_cols = min(
		_ct_offers,
		_ct_cols
	);

	if (_ct_layout_cols > 0){

		_val_total_offer_w =
			(_ct_layout_cols * _val_panel_w) +
			((_ct_layout_cols - 1) * _val_panel_gap);

		_val_panel_start_x =
			x -
			(_val_total_offer_w * 0.5);
	}
	else{

		_val_total_offer_w = 0;
		_val_panel_start_x = x;
	}

	//================//
	//DEBUG OPEN//
	//================//
	scr_debug_log(
		"MARKET",
		"OPEN",
		self,
		"MARKET OPENED" +
		" | TYPE: " +
		string_upper(_str_market_type) +
		" | UID: " +
		string_upper(_str_market_uid) +
		" | OFFERS: " +
		string(_ct_offers) +
		" | PLAYER GOLD: " +
		string(global.val_player_gold) +
		" | RESTOCK: " +
		string(global.ct_market_restock_battles) +
		"/" +
		string(global.ct_market_restock_battles_max),
		"INFO",
		"OBJ_GUI_MARKET_PANE:HSCR_GUI_MARKET_INIT"
	);

	return true;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_MARKET_UPDATE_CLICK_COOLDOWN
// FUNCTION: Updates the shared purchase click cooldown.
//           Prevents repeated purchases from one interaction.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_market_update_click_cooldown(){

	if (_flag_clicked){

		if (_ct_cooldown > 0){
			_ct_cooldown--;
		}
		else{
			_ct_cooldown = 0;
			_flag_clicked = false;
		}
	}
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_MARKET_IS_MOUSE_IN_BOX
// FUNCTION: Checks whether the GUI mouse position is inside a rectangle.
//
// ARGUMENTS: Mouse x/y and rectangle x1/y1/x2/y2 coordinates.
// RETURNS: True when the mouse is inside the rectangle.
//
//-------------------------------------------------------------------------------//
function hscr_gui_market_is_mouse_in_box(_val_mouse_x,_val_mouse_y,_val_x1,_val_y1,_val_x2,_val_y2){

	return (
		_val_mouse_x >= _val_x1 &&
		_val_mouse_x <= _val_x2 &&
		_val_mouse_y >= _val_y1 &&
		_val_mouse_y <= _val_y2
	);
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_MARKET_ATTEMPT_PURCHASE
// FUNCTION: Attempts to purchase one Market offer.
//           Supports Egg, Prism, and NPC vendor stock behavior.
//           Logs blocked and successful purchases with Gold and stock changes.
//
// ARGUMENTS: _it_offer is the zero-based Market stock array index.
// RETURNS: True when the purchase succeeds, otherwise false.
//
//-------------------------------------------------------------------------------//
function hscr_gui_market_attempt_purchase(_it_offer){

	//================//
	//VALIDATE OFFER INDEX//
	//================//
	if (
		_it_offer < 0 ||
		_it_offer >= array_length(_arr_stock)
	){

		scr_debug_log(
			"MARKET",
			"PURCHASE",
			self,
			"PURCHASE FAILED" +
			" | MARKET: " +
			string_upper(_str_market_uid) +
			" | OFFER INDEX: " +
			string(_it_offer) +
			" | REASON: INVALID OFFER INDEX",
			"ERROR",
			"OBJ_GUI_MARKET_PANE:HSCR_GUI_MARKET_ATTEMPT_PURCHASE"
		);

		return false;
	}

	var _stct_offer = _arr_stock[_it_offer];

	if (!is_struct(_stct_offer)){

		scr_debug_log(
			"MARKET",
			"PURCHASE",
			self,
			"PURCHASE FAILED" +
			" | MARKET: " +
			string_upper(_str_market_uid) +
			" | OFFER INDEX: " +
			string(_it_offer) +
			" | REASON: INVALID OFFER DATA",
			"ERROR",
			"OBJ_GUI_MARKET_PANE:HSCR_GUI_MARKET_ATTEMPT_PURCHASE"
		);

		return false;
	}

	//================//
	//GET OFFER DATA//
	//================//
	var _str_item_id = _stct_offer._str_item_id;
	var _str_item_name = _str_item_id;

	if (
		variable_struct_exists(_stct_offer,"_stct_item") &&
		is_struct(_stct_offer._stct_item)
	){
		_str_item_name = _stct_offer._stct_item._str_item_name;
	}

	var _val_purchase_cost = _stct_offer._val_gold_cost;
	var _val_gold_before = global.val_player_gold;

	//================//
	//CHECK SOLD STATE//
	//================//
	if (
		variable_struct_exists(_stct_offer,"_flag_sold") &&
		_stct_offer._flag_sold
	){

		audio_play_sound(
			snd_gui_error,
			0,
			false
		);

		scr_gui_spawn_popup_error(
			"SOLD OUT",
			60
		);

		scr_debug_log(
			"MARKET",
			"PURCHASE",
			self,
			"PURCHASE BLOCKED" +
			" | MARKET TYPE: " +
			string_upper(_str_market_type) +
			" | ITEM: " +
			string_upper(_str_item_name) +
			" | REASON: SOLD OUT",
			"INFO",
			"OBJ_GUI_MARKET_PANE:HSCR_GUI_MARKET_ATTEMPT_PURCHASE"
		);

		return false;
	}

	//================//
	//CHECK GOLD//
	//================//
	if (global.val_player_gold < _val_purchase_cost){

		audio_play_sound(
			snd_gui_error,
			0,
			false
		);

		scr_gui_spawn_popup_error(
			"NOT ENOUGH GOLD",
			60
		);

		scr_debug_log(
			"MARKET",
			"PURCHASE",
			self,
			"PURCHASE BLOCKED" +
			" | MARKET TYPE: " +
			string_upper(_str_market_type) +
			" | ITEM: " +
			string_upper(_str_item_name) +
			" | COST: " +
			string(_val_purchase_cost) +
			" | PLAYER GOLD: " +
			string(global.val_player_gold) +
			" | REASON: NOT ENOUGH GOLD",
			"INFO",
			"OBJ_GUI_MARKET_PANE:HSCR_GUI_MARKET_ATTEMPT_PURCHASE"
		);

		return false;
	}

	//================//
	//PURCHASE ITEM//
	//================//
	global.val_player_gold -= _val_purchase_cost;

	scr_inventory_add_item(
		_str_item_id,
		1
	);

	//================//
	//UPDATE OFFER//
	//================//
	var _str_stock_result = "";

	switch (_stct_offer._str_offer_type){

		//======//
		//EGG//
		//======//
		case "EGG":

			_stct_offer._flag_sold = true;

			_str_stock_result = "SOLD OUT";

		break;

		//======//
		//PRISM//
		//======//
		case "PRISM":

			_stct_offer._ct_bought++;

			_stct_offer._val_gold_cost = scr_market_get_prism_cost(
				_stct_offer
			);

			_str_stock_result =
				"BOUGHT: " +
				string(_stct_offer._ct_bought) +
				" | NEXT COST: " +
				string(_stct_offer._val_gold_cost);

		break;

		//======//
		//NPC//
		//======//
		case "NPC":

			//----------------//
			//REDUCE STOCK//
			//----------------//
			if (_stct_offer._ct_stock > 0){

				_stct_offer._ct_stock--;

				if (_stct_offer._ct_stock <= 0){

					_stct_offer._ct_stock = 0;
					_stct_offer._flag_sold = true;
				}

				_str_stock_result =
					"STOCK: " +
					string(_stct_offer._ct_stock);
			}
			else{

				_str_stock_result =
					"STOCK: UNLIMITED";
			}

		break;
	}

	//================//
	//SAVE STOCK//
	//================//
	_arr_stock[_it_offer] = _stct_offer;

	scr_market_set_stock(
		_str_market_uid,
		_arr_stock
	);

	//================//
	//DEBUG PURCHASE//
	//================//
	scr_debug_log(
		"MARKET",
		"PURCHASE",
		self,
		"PURCHASE COMPLETE" +
		" | MARKET TYPE: " +
		string_upper(_str_market_type) +
		" | MARKET UID: " +
		string_upper(_str_market_uid) +
		" | ITEM: " +
		string_upper(_str_item_name) +
		" | ID: " +
		string_upper(_str_item_id) +
		" | COST: " +
		string(_val_purchase_cost) +
		" | GOLD: " +
		string(_val_gold_before) +
		" -> " +
		string(global.val_player_gold) +
		((_str_stock_result != "") ?
			" | " + _str_stock_result :
			""),
		"INFO",
		"OBJ_GUI_MARKET_PANE:HSCR_GUI_MARKET_ATTEMPT_PURCHASE"
	);

	//================//
	//FEEDBACK//
	//================//
	audio_play_sound(
		snd_market_purchase,
		0,
		false
	);

	scr_gui_spawn_popup(
		"TEXT",
		"+" + string(_str_item_name),
		undefined,
		c_yellow,
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5
	);

	return true;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_MARKET_DRAW_OFFER_PANEL
// FUNCTION: Draws one market offer panel.
//           Supports egg, prism, and NPC offers.
//           Handles hover state and left-click purchasing.
//
// ARGUMENTS: Offer index, panel x/y, and GUI mouse x/y.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_market_draw_offer_panel(_it_offer,_val_panel_x,_val_panel_y,_val_mouse_x,_val_mouse_y){

	//================//
	//VALIDATE OFFER//
	//================//
	if (_it_offer < 0 || _it_offer >= array_length(_arr_stock)){
		return;
	}

	var _val_x1 = _val_panel_x;
	var _val_y1 = _val_panel_y;
	var _val_x2 = _val_panel_x + _val_panel_w;
	var _val_y2 = _val_panel_y + _val_panel_h;

	var _flag_hover = hscr_gui_market_is_mouse_in_box(
		_val_mouse_x,
		_val_mouse_y,
		_val_x1,
		_val_y1,
		_val_x2,
		_val_y2
	);

	//================//
	//DRAW PANEL//
	//================//
	draw_set_colour(c_black);
	draw_rectangle(_val_x1,_val_y1,_val_x2,_val_y2,false);

	draw_set_colour(_flag_hover ? c_ltgray : global.c_dk_gray);
	draw_rectangle(_val_x1 + 4,_val_y1 + 4,_val_x2 - 4,_val_y2 - 4,false);

	var _stct_offer = _arr_stock[_it_offer];

	if (_stct_offer == undefined){
		return;
	}

	var _stct_item = _stct_offer._stct_item;

	if (_stct_item == undefined){
		return;
	}

	var _val_center_x = _val_x1 + (_val_panel_w * 0.5);

	//================//
	//DRAW ICON//
	//================//
	var _val_icon_scale = 3;

	if (_stct_offer._str_offer_type == "PRISM" || _stct_offer._str_offer_type == "NPC"){
		_val_icon_scale = 2;
	}

	draw_sprite_ext(
		_stct_item._spr_item,
		0,
		_val_center_x,
		_val_y1 + 75,
		_val_icon_scale,
		_val_icon_scale,
		0,
		c_white,
		1
	);

	//================//
	//DRAW OFFER INFO//
	//================//
	draw_set_font(fnt_gui_small);
	draw_set_colour(c_black);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	switch (_stct_offer._str_offer_type){

		case "NPC":

			draw_text(
				_val_center_x,
				_val_y1 + 118,
				_stct_item._str_item_name
			);

			draw_set_colour(global.c_dk_gray);

			draw_text_ext(
				_val_center_x,
				_val_y1 + 140,
				_stct_item._str_item_desc,
				14,
				_val_panel_w - 32
			);

			draw_set_colour(c_black);

			draw_text(
				_val_center_x,
				_val_y2 - 52,
				"COST: " + string(_stct_offer._val_gold_cost) + " gp"
			);

			if (_stct_offer._ct_stock < 0){

				draw_text(
					_val_center_x,
					_val_y2 - 34,
					"STOCK: UNLIMITED"
				);
			}
			else{

				draw_text(
					_val_center_x,
					_val_y2 - 34,
					"STOCK: " + string(_stct_offer._ct_stock)
				);
			}

		break;

		case "EGG":

			var _stct_beast = undefined;

			if (variable_struct_exists(_stct_offer,"_stct_beast_preview")){
				_stct_beast = _stct_offer._stct_beast_preview;
			}

			draw_text(
				_val_center_x,
				_val_y1 + 160,
				_stct_item._str_item_name
			);

			draw_set_colour(global.c_dk_gray);

			draw_text_ext(
				_val_center_x,
				_val_y1 + 190,
				_stct_item._str_item_desc,
				14,
				_val_panel_w - 36
			);

			draw_set_colour(c_black);

			if (variable_struct_exists(_stct_offer,"_str_beast_name")){

				draw_text(
					_val_center_x,
					_val_y2 - 82,
					"BEAST: " + string(_stct_offer._str_beast_name)
				);
			}

			draw_text(
				_val_center_x,
				_val_y2 - 60,
				"COST: " + string(_stct_offer._val_gold_cost) + " gp"
			);

			if (_stct_beast != undefined){

				draw_text(
					_val_center_x,
					_val_y2 - 38,
					string(_stct_beast._str_beast_archetype) +
					" | " +
					string(_stct_beast._str_beast_class)
				);
			}

		break;

		case "PRISM":

			draw_text(
				_val_center_x,
				_val_y1 + 118,
				_stct_item._str_item_name
			);

			draw_set_colour(c_black);

			if (variable_struct_exists(_stct_offer,"_val_tame_bonus")){

				draw_text(
					_val_center_x,
					_val_y1 + 140,
					"BONUS: +" + string(_stct_offer._val_tame_bonus) + "%"
				);
			}

			draw_text(
				_val_center_x,
				_val_y1 + 158,
				"COST: " + string(_stct_offer._val_gold_cost) + " gp"
			);

			if (variable_struct_exists(_stct_offer,"_ct_bought")){

				draw_text(
					_val_center_x,
					_val_y1 + 176,
					"BOUGHT: " + string(_stct_offer._ct_bought)
				);
			}

		break;
	}

	//================//
	//SOLD STATE//
	//================//
	var _flag_sold = false;

	if (variable_struct_exists(_stct_offer,"_flag_sold")){
		_flag_sold = _stct_offer._flag_sold;
	}

	if (_flag_sold){

		draw_set_alpha(0.65);
		draw_set_colour(c_black);
		draw_rectangle(_val_x1,_val_y1,_val_x2,_val_y2,false);

		draw_set_alpha(1);

		draw_set_colour(c_red);
		draw_line(_val_x1 + 15,_val_y1 + 15,_val_x2 - 15,_val_y2 - 15);
		draw_line(_val_x2 - 15,_val_y1 + 15,_val_x1 + 15,_val_y2 - 15);

		draw_set_colour(c_white);
		draw_text(_val_center_x,_val_y1 + 18,"SOLD");
	}
	else if (_flag_hover){

		draw_set_colour(c_white);
		draw_text(_val_center_x,_val_y2 - 26,"BUY");

		if (mouse_check_button_pressed(mb_left) && !_flag_clicked){

			_flag_clicked = true;
			_ct_cooldown = 10;

			hscr_gui_market_attempt_purchase(_it_offer);
		}
	}

	//================//
	//RESET DRAW STATE//
	//================//
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_MARKET_RELEASE_NPC_VENDOR
// FUNCTION: Fully releases an NPC vendor interaction.
//           Safe to call from explicit close logic or the Cleanup event.
//           Uses the canonical NPC interaction-close helper.
//
// ARGUMENTS: None.
// RETURNS: True when the NPC vendor interaction is released.
//
//-------------------------------------------------------------------------------//
function hscr_gui_market_release_npc_vendor(){

	//================//
	//VALIDATE RELEASE//
	//================//
	if (_flag_npc_interaction_released){
		return false;
	}

	if (_str_market_type != "NPC"){
		return false;
	}

	_flag_npc_interaction_released = true;

	//================//
	//GET NPC//
	//================//
	var _ref_closing_npc = _ref_npc;

	//================//
	//FALLBACK NPC//
	//================//
	if (
		_ref_closing_npc == undefined ||
		!instance_exists(_ref_closing_npc)
	){

		if (
			variable_global_exists("ref_interacting_npc") &&
			global.ref_interacting_npc != undefined &&
			instance_exists(global.ref_interacting_npc)
		){
			_ref_closing_npc = global.ref_interacting_npc;
		}
	}

	//================//
	//RELEASE NPC//
	//================//
	if (
		_ref_closing_npc != undefined &&
		instance_exists(_ref_closing_npc)
	){

		_ref_closing_npc.hscr_npc_close_interaction();

		return true;
	}

	//================//
	//LOST NPC FALLBACK//
	//================//
	scr_debug_log(
		"NPC",
		"TRADE",
		undefined,
		"NPC VENDOR RELEASE FAILED" +
		" | REASON: NPC REFERENCE LOST",
		"WARNING",
		"OBJ_GUI_MARKET_PANE:HSCR_GUI_MARKET_RELEASE_NPC_VENDOR"
	);

	global.ref_interacting_npc = undefined;
	global.flag_pause = false;

	if (instance_exists(obj_gui_controller)){

		obj_gui_controller.hscr_gui_set_pause(false);
	}
	else if (instance_exists(obj_player)){

		scr_player_set_movement_state("START");
	}

	return false;
}