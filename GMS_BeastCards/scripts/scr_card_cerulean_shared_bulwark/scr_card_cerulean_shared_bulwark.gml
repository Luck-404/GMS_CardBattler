//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SHARED_BULWARK
// FUNCTION: Resolves Shared Bulwark.
//           Redistributes the caster's current Armor evenly among all living
//           allied Beasts while preserving the exact total Armor.
//
//===============================================================================//

function scr_card_cerulean_shared_bulwark(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET ALLIED TEAM LIST//
	//--------------------//
	var _list_allies =
		scr_get_target_team_list(
			_ref_caster
		);

	if (_list_allies == undefined){
		return;
	}

	//------------------//
	//GET TOTAL ARMOR//
	//------------------//
	var _val_total_armor =
		max(
			0,
			_ref_caster._val_armor
		);

	//------------------//
	//COUNT LIVING ALLIES//
	//------------------//
	var _arr_allies = [];

	for (
		var _it_ally = 0;
		_it_ally < ds_list_size(_list_allies);
		_it_ally++
	){

		var _ref_ally =
			ds_list_find_value(
				_list_allies,
				_it_ally
			);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (
			_ref_ally._str_list != "ALIVE" ||
			_ref_ally._val_cur_hp <= 0
		){
			continue;
		}

		array_push(
			_arr_allies,
			_ref_ally
		);
	}

	var _ct_allies =
		array_length(
			_arr_allies
		);

	if (_ct_allies <= 0){
		return;
	}

	//----------------------//
	//REMOVE CASTER'S ARMOR//
	//----------------------//
	_ref_caster._val_armor = 0;

	//---------------------//
	//CALCULATE EACH SHARE//
	//---------------------//
	var _val_base_share =
		floor(
			_val_total_armor /
			_ct_allies
		);

	var _val_remainder =
		_val_total_armor mod
		_ct_allies;

	//--------------------//
	//DISTRIBUTE THE ARMOR//
	//--------------------//
	for (
		var _it_share = 0;
		_it_share < _ct_allies;
		_it_share++
	){

		var _ref_ally =
			_arr_allies[_it_share];

		var _val_share =
			_val_base_share;

		//----------------//
		//ASSIGN REMAINDER//
		//----------------//
		if (_it_share < _val_remainder){
			_val_share++;
		}

		_ref_ally._val_armor +=
			_val_share;
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_battle_sfx_armor,
		0,
		false
	);
}