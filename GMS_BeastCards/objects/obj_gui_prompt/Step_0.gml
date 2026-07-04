//===============================================================================//
//
// STEP: OBJ_GUI_PROMPT
// FUNCTION: Handles yes/no prompt button input.
//           Executes assigned callbacks.
//           Destroys the prompt after a button is selected.
//
//===============================================================================//

//--------//
//COOLDOWN//
//--------//
if (_flag_clicked){
	if (_ct_cooldown > 0){
		_ct_cooldown--;
	}
	else{
		_ct_cooldown = 0;
		_flag_clicked = false;
	}
}

//-----//
//INPUT//
//-----//
var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

var _val_box_x1 = x - (_val_box_w * 0.5);
var _val_box_y1 = y - (_val_box_h * 0.5);

var _val_yes_x1 = x - _val_button_w - 20;
var _val_yes_y1 = y + 35;
var _val_yes_x2 = _val_yes_x1 + _val_button_w;
var _val_yes_y2 = _val_yes_y1 + _val_button_h;

var _val_no_x1 = x + 20;
var _val_no_y1 = y + 35;
var _val_no_x2 = _val_no_x1 + _val_button_w;
var _val_no_y2 = _val_no_y1 + _val_button_h;

var _flag_yes_hover = _val_mouse_x > _val_yes_x1 && _val_mouse_x < _val_yes_x2 && _val_mouse_y > _val_yes_y1 && _val_mouse_y < _val_yes_y2;
var _flag_no_hover = _val_mouse_x > _val_no_x1 && _val_mouse_x < _val_no_x2 && _val_mouse_y > _val_no_y1 && _val_mouse_y < _val_no_y2;

if (mouse_check_button_pressed(mb_left) && !_flag_clicked){

	if (_flag_yes_hover){
		_flag_clicked = true;
		_ct_cooldown = 8;

		if (_scr_yes != undefined){
			_scr_yes(_stct_item,_ref_parent_gui);
			_ref_parent_gui._ct_cooldown = 15;
		}

		instance_destroy();
		exit;
	}

	if (_flag_no_hover){
		_flag_clicked = true;
		_ct_cooldown = 8;

		if (_scr_no != undefined){
			_scr_no(_ref_parent_gui);
			_ref_parent_gui._ct_cooldown = 15;
		}

		instance_destroy();
		exit;
	}
}