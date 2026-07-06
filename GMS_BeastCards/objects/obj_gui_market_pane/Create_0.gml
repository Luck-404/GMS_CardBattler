//===============================================================================//
//
// CREATE: OBJ_GUI_MARKET_PANE
// FUNCTION: Initializes the generic market pane.
//           Supports beast egg market stock, purchasing, and display layout.
//           Uses persistent market UID stock through global.map_market_stock.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = -100;

_str_type = "MARKET";
_str_market_type = "EGG";
_str_market_uid = "DEFAULT_MARKET";
_ref_market_owner = undefined;
_ct_cols = 3;
_val_panel_row_gap = 20;
_str_header_text = "BEAST EGG MARKET";

_arr_stock = [];

_val_pane_w = 800;
_val_pane_h = 500;

_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_ct_offers = 3;

_val_panel_w = 220;
_val_panel_h = 350;

_val_panel_gap = 30;

_val_total_offer_w = (_ct_offers * _val_panel_w) + ((_ct_offers - 1) * _val_panel_gap);
_val_panel_start_x = x - (_val_total_offer_w * 0.5);
_val_panel_y = _val_pane_top + 95;

_flag_clicked = false;
_ct_cooldown = 0;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_market_init
// FUNCTION: Initializes market stock after external values are assigned.
//           Supports egg markets and prism vendors.
//           Updates panel layout for the selected market type.
//—------------------------------------------------------------------------------//
function hscr_market_init(){

	switch(_str_market_type){

		case "EGG":
			_arr_stock = scr_market_get_egg_stock(_str_market_uid);

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
			_arr_stock = scr_market_get_prism_stock(_str_market_uid);

			_str_header_text = "PRISM VENDOR";

			_ct_offers = array_length(_arr_stock);
			_ct_cols = 3;

			_val_panel_w = 170;
			_val_panel_h = 165;
			_val_panel_gap = 25;
			_val_panel_row_gap = 20;
			_val_panel_y = _val_pane_top + 95;
		break;
	}
}

//—------------------------------------------------------------------------------//
// hscr_update_click_cooldown
// FUNCTION: Prevents repeated purchasing from one mouse press.
//—------------------------------------------------------------------------------//
function hscr_update_click_cooldown(){

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

//—------------------------------------------------------------------------------//
// hscr_is_mouse_in_box
// FUNCTION: Returns whether the GUI mouse position is inside a rectangle.
//—------------------------------------------------------------------------------//
function hscr_is_mouse_in_box(_val_mouse_x,_val_mouse_y,_val_x1,_val_y1,_val_x2,_val_y2){

	return (
		_val_mouse_x >= _val_x1 &&
		_val_mouse_x <= _val_x2 &&
		_val_mouse_y >= _val_y1 &&
		_val_mouse_y <= _val_y2
	);
}

//—------------------------------------------------------------------------------//
// hscr_attempt_purchase
// FUNCTION: Attempts to buy a market offer.
//           Egg offers are sold once purchased.
//           Prism offers are infinite and increase in cost after each purchase.
//—------------------------------------------------------------------------------//
function hscr_attempt_purchase(_it_offer){

	if (_it_offer < 0 || _it_offer >= array_length(_arr_stock)){
		return;
	}

	var _stct_offer = _arr_stock[_it_offer];

	if (_stct_offer == undefined){
		return;
	}

	if (_stct_offer._str_offer_type == "EGG" && _stct_offer._flag_sold){
		scr_spawn_popup_error("SOLD OUT",60);
		return;
	}

	if (global.val_player_gold < _stct_offer._val_gold_cost){
		scr_spawn_popup_error("NOT ENOUGH GOLD",60);
		return;
	}

	global.val_player_gold -= _stct_offer._val_gold_cost;

	scr_add_item_to_inventory(_stct_offer._str_item_id,1);

	switch(_stct_offer._str_offer_type){

		case "EGG":
			_stct_offer._flag_sold = true;
		break;

		case "PRISM":
			_stct_offer._ct_bought++;
			_stct_offer._val_gold_cost = scr_market_get_prism_cost(_stct_offer);
		break;
	}

	_arr_stock[_it_offer] = _stct_offer;

	scr_market_set_stock(_str_market_uid,_arr_stock);

	scr_spawn_popup(
		"TEXT",
		"+" + string(_stct_offer._stct_item._str_item_name),
		undefined,
		c_yellow,
		obj_player.x,
		obj_player.y - 48
	);
}

//—------------------------------------------------------------------------------//
// hscr_draw_offer_panel
// FUNCTION: Draws one market offer panel.
//           Supports egg offers and prism offers.
//           Handles hover and left-click purchase.
//
//—------------------------------------------------------------------------------//
function hscr_draw_offer_panel(_it_offer,_val_panel_x,_val_panel_y,_val_mouse_x,_val_mouse_y){

	var _val_x1 = _val_panel_x;
	var _val_y1 = _val_panel_y;
	var _val_x2 = _val_panel_x + _val_panel_w;
	var _val_y2 = _val_panel_y + _val_panel_h;

	var _flag_hover = hscr_is_mouse_in_box(_val_mouse_x,_val_mouse_y,_val_x1,_val_y1,_val_x2,_val_y2);

	draw_set_colour(c_black);
	draw_rectangle(_val_x1,_val_y1,_val_x2,_val_y2,false);

	draw_set_colour(_flag_hover ? c_ltgray : c_gray);
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

	//------//
	//ICON//
	//------//
	var _val_icon_scale = 3;

	if (_stct_offer._str_offer_type == "PRISM"){
		_val_icon_scale = 2;
	}

	draw_sprite_ext(_stct_item._spr_item,0,_val_center_x,_val_y1 + 75,_val_icon_scale,_val_icon_scale,0,c_white,1);

	//------//
	//TEXT//
	//------//
	draw_set_font(fnt_small_gui);
	draw_set_colour(c_black);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	switch(_stct_offer._str_offer_type){

		//-----//
		//EGG//
		//-----//
		case "EGG":

			var _stct_beast = undefined;

			if (variable_struct_exists(_stct_offer,"_stct_beast_preview")){
				_stct_beast = _stct_offer._stct_beast_preview;
			}

			draw_text(_val_center_x,_val_y1 + 160,_stct_item._str_item_name);

			draw_set_colour(c_dkgray);
			draw_text_ext(_val_x1 + 100,_val_y1 + 190,_stct_item._str_item_desc,14,_val_panel_w - 36);

			draw_set_colour(c_black);

			if (variable_struct_exists(_stct_offer,"_str_beast_name")){
				draw_text(_val_center_x,_val_y2 - 82,"BEAST: " + string(_stct_offer._str_beast_name));
			}

			draw_text(_val_center_x,_val_y2 - 60,"COST: " + string(_stct_offer._val_gold_cost) + " gp");

			if (_stct_beast != undefined){
				draw_text(_val_center_x,_val_y2 - 38,string(_stct_beast._str_beast_archetype) + " | " + string(_stct_beast._str_beast_class));
			}

		break;

		//-------//
		//PRISM//
		//-------//
		case "PRISM":

			draw_text(_val_center_x,_val_y1 + 118,_stct_item._str_item_name);

			draw_set_colour(c_black);

			if (variable_struct_exists(_stct_offer,"_val_tame_bonus")){
				draw_text(_val_center_x,_val_y1 + 140,"BONUS: +" + string(_stct_offer._val_tame_bonus) + "%");
			}

			draw_text(_val_center_x,_val_y1 + 158,"COST: " + string(_stct_offer._val_gold_cost) + " gp");

			if (variable_struct_exists(_stct_offer,"_ct_bought")){
				draw_text(_val_center_x,_val_y1 + 176,"BOUGHT: " + string(_stct_offer._ct_bought));
			}

		break;
	}

	//-----------//
	//SOLD STATE//
	//-----------//
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

		if (mouse_check_button_pressed(mb_left)){
			hscr_attempt_purchase(_it_offer);
		}
	}

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
#endregion