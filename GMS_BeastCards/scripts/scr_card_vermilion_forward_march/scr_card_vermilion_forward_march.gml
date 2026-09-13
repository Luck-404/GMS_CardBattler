//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FORWARD_MARCH
// FUNCTION: Resolves Forward March.
//           Deals linear Physical damage to the selected target.
//           If the caster is the front allied Beast, gains 1 Rage.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_forward_march(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_target);

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//================//
	//GET ALLIED TEAM//
	//================//
	var _list_allies = undefined;

	if (_ref_caster._str_team == "PLAYER"){
		_list_allies = obj_battle_player_controller._list_beasts_alive;
	}
	else if (_ref_caster._str_team == "ENEMY"){
		_list_allies = obj_battle_enemy_controller._list_beasts_alive;
	}

	if (!ds_exists(_list_allies,ds_type_list)){
		return;
	}

	if (ds_list_size(_list_allies) <= 0){
		return;
	}

	//================//
	//CHECK FRONT//
	//================//
	var _ref_front_beast = ds_list_find_value(_list_allies,0);

	if (_ref_front_beast != _ref_caster){
		return;
	}

	//================//
	//GAIN RAGE//
	//================//
	scr_status_gain_rage(_ref_caster,1);
}