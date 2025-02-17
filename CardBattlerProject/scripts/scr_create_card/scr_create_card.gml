//////////////////////////////////////////////////////////////////////
//					SCR_CREATE_CARD									//
//																	//
// > CREATES A CARD WITH MAPPED VALUES								//
//////////////////////////////////////////////////////////////////////
function scr_create_card(_name, _description, _cost, _script, _sprite,_target,_color,_type,_archespec,_classspec,_goldcost,_exhaust) {
    var _ref_new_card = ds_map_create();
    ds_map_add(_ref_new_card, "name", _name);
    ds_map_add(_ref_new_card, "description", _description);
    ds_map_add(_ref_new_card, "cost", _cost);
    ds_map_add(_ref_new_card, "script", _script);
    ds_map_add(_ref_new_card, "sprite", _sprite);
    ds_map_add(_ref_new_card, "target", _target);
    ds_map_add(_ref_new_card, "color", _color);
    ds_map_add(_ref_new_card, "type", _type);
    ds_map_add(_ref_new_card, "archespec", _archespec);
    ds_map_add(_ref_new_card, "classspec", _classspec);	
    ds_map_add(_ref_new_card, "goldcost", _goldcost);
    ds_map_add(_ref_new_card, "exhausts", _exhaust);	
	show_debug_message("!!=== SCR_CREATE_CARD: CREATED CARD " + string(_name) +" ===!!");	
    return _ref_new_card;
}