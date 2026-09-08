//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_OCEANS_BLESSING
// FUNCTION: Resolves Ocean's Blessing.
//           Heals every living allied Beast.
//
//===============================================================================//

function scr_card_cerulean_oceans_blessing(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//GET ALLIED TEAM//
	//----------------//
	var _list_allies =
		undefined;

	if (_ref_caster._str_team == "PLAYER"){

		_list_allies =
			obj_battle_player_controller._list_beasts_alive;
	}
	else if (_ref_caster._str_team == "ENEMY"){

		_list_allies =
			obj_battle_enemy_controller._list_beasts_alive;
	}

	if (_list_allies == undefined){
		return;
	}

	//----------------//
	//HEAL ALL ALLIES//
	//----------------//
	for (
		var _it_beast = 0;
		_it_beast < ds_list_size(_list_allies);
		_it_beast++
	){

		var _ref_beast =
			ds_list_find_value(
				_list_allies,
				_it_beast
			);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}

		scr_battle_heal_target(
			_stct_card._val_card_magnitude,
			_ref_beast
		);
	}

}