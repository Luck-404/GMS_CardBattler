// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_create_card(_name, _description, _cost, _script, _sprite,_target,_color,_type,_spec) {
    var _ref_new_card = ds_map_create();
    ds_map_add(_ref_new_card, "name", _name);
    ds_map_add(_ref_new_card, "description", _description);
    ds_map_add(_ref_new_card, "cost", _cost);
    ds_map_add(_ref_new_card, "script", _script);
    ds_map_add(_ref_new_card, "sprite", _sprite);
    ds_map_add(_ref_new_card, "target", _target);
    ds_map_add(_ref_new_card, "color", _color);
    ds_map_add(_ref_new_card, "type", _type);
    ds_map_add(_ref_new_card, "spec", _spec);	
    ds_map_add(_ref_new_card, "goldcost", irandom_range(40,80));
	show_debug_message("!!=== SCR_CREATE_CARD: CREATED CARD " + string(_name) +" ===!!");	
    return _ref_new_card;
}