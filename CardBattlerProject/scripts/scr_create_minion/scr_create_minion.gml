//////////////////////////////////////////////////////////////////////
//							SCR_CREATE_MINION						//
//																	//
// > ESTABLISH THE MINION OBJECT									//
//////////////////////////////////////////////////////////////////////
function scr_create_minion(_hp,_def,_color,_name,_team,_cast_types,_sprite,_hurt_sound,_death_sound,_default_sound,_unit,_effect_script,_stacks,_class){
	var _ref_minion = instance_create_layer(x,y,"Creatures",obj_minion);
	_ref_minion._minion_hp_cur = _hp;
	_ref_minion._minion_hp_max = _hp;
	_ref_minion._minion_def = _def;
	_ref_minion._minion_color = _color;
	_ref_minion._minion_name = _name;
	_ref_minion._minion_team = _team;
	_ref_minion._minion_cast_types = _cast_types; //Minion step, Host DMG Taken, Host DMG Dealt
	_ref_minion.sprite_index = _sprite;	
	_ref_minion._minion_sprite = _sprite;
	_ref_minion._minion_hurtsound = _hurt_sound;
	_ref_minion._minion_deathsound = _death_sound;
	_ref_minion._minion_defaultsound = snd_creature_wraith_default;
	_ref_minion._minion_unit_attached = _unit;
	_ref_minion._minion_effect_script = _effect_script;
	_ref_minion._minion_stacks = _stacks;	
	_ref_minion._minion_class = _class;	
	
	return _ref_minion
}