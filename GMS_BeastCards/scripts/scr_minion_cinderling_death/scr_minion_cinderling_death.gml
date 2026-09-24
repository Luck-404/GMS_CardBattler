//===============================================================================//
//
// SCRIPT: SCR_MINION_CINDERLING_DEATH
// FUNCTION: Resolves Cinderling's combat-death retaliation.
//
//           If another Minion killed the Cinderling, applies 1 Burn
//           to that Minion's host.
//
//           Otherwise, applies 1 Burn to a random living opposing Beast.
//
//           Only called for actual combat deaths, not sacrifices,
//           replacements, or generic removal.
//
// ARGUMENTS: _ref_minion is the dying Cinderling.
//            _ref_killer_minion is the Minion that dealt the killing blow,
//            when applicable.
// RETURNS: True when its Burn effect is present after the death reaction; false if the reaction cannot run.
//
//===============================================================================//

function scr_minion_cinderling_death(_ref_minion,_ref_killer_minion=undefined){

	//-----------------//
	//VALIDATE MINION//
	//-----------------//
	if (!instance_exists(_ref_minion)){
		return false;
	}

	if (_ref_minion._str_name != "CINDERLING"){
		return false;
	}

	//================//
	//SELECT TARGET//
	//================//
	var _ref_target = undefined;

	//================================//
	//MINION KILL — TARGET KILLER HOST//
	//================================//
	if (instance_exists(_ref_killer_minion)){

		var _ref_killer_host = _ref_killer_minion._ref_host;

		if (
			instance_exists(_ref_killer_host) &&
			_ref_killer_minion._str_team != _ref_minion._str_team &&
			_ref_killer_host._str_team != _ref_minion._str_team &&
			_ref_killer_host._str_list == "ALIVE" &&
			_ref_killer_host._val_cur_hp > 0
		){

			_ref_target = _ref_killer_host;
		}
	}

	//==================================//
	//OTHER KILL — RANDOM OPPOSING BEAST//
	//==================================//
	if (!instance_exists(_ref_target)){

		var _list_enemy = undefined;

		switch (_ref_minion._str_team){

			case "PLAYER":

				if (instance_exists(obj_battle_enemy_controller)){

					_list_enemy =
						obj_battle_enemy_controller._list_beasts_alive;
				}

			break;

			case "ENEMY":

				if (instance_exists(obj_battle_player_controller)){

					_list_enemy =
						obj_battle_player_controller._list_beasts_alive;
				}

			break;
		}

		//----------------//
		//VALIDATE LIST//
		//----------------//
		if (
			_list_enemy == undefined ||
			!ds_exists(_list_enemy,ds_type_list)
		){
			return false;
		}

		//----------------//
		//GET RANDOM ENEMY//
		//----------------//
		_ref_target = scr_minion_get_target(
			_list_enemy
		);
	}

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		return false;
	}


	//================//
	//APPLY 1 BURN//
	//================//

	var _ref_burn = scr_status_apply_dot("BURN", _ref_target);


	return instance_exists(_ref_burn);
}