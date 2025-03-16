//////////////////////////////////////////////////////////////////////
//					SCR_CREATE_CARD									//
//																	//
// > CREATES A CARD WITH MAPPED VALUES								//
//////////////////////////////////////////////////////////////////////
function scr_create_card(_name, _description, _mana_cost, _script, _sprite,_color,_type,_damage,_archespec,_classspec,_rarity,_exhaust,_range,_targets,_animation_time) {
    var _ref_new_card = ds_map_create();
    ds_map_add(_ref_new_card, "name", _name);
    ds_map_add(_ref_new_card, "description", _description);
    ds_map_add(_ref_new_card, "cost", _mana_cost);
    ds_map_add(_ref_new_card, "script", _script);
    ds_map_add(_ref_new_card, "sprite", _sprite);
    ds_map_add(_ref_new_card, "color", _color);
    ds_map_add(_ref_new_card, "type", _type);
    ds_map_add(_ref_new_card, "damage", _damage);	
    ds_map_add(_ref_new_card, "spec", _archespec);
    ds_map_add(_ref_new_card, "class", _classspec);	
    ds_map_add(_ref_new_card, "rarity", _rarity);
    ds_map_add(_ref_new_card, "exhausts", _exhaust);	
	ds_map_add(_ref_new_card, "range", _range);	
	ds_map_add(_ref_new_card, "targets", _targets);		
	ds_map_add(_ref_new_card, "time", _animation_time);		
    return _ref_new_card;
}