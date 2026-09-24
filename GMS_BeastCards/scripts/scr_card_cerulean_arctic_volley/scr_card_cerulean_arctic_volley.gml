//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ARCTIC_VOLLEY
// FUNCTION: Resolves Arctic Volley.
//           Deals linear physical damage to the selected target 3 times.
//           Stops early if the target dies.
//
// ARGUMENTS: _stct_card is the Arctic Volley card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_arctic_volley(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL THREE HITS//
	//================//
	for (var _it_hit = 0;_it_hit < 3;_it_hit++){

		if (!instance_exists(_ref_target)){
			break;
		}

		if (_ref_target._val_cur_hp <= 0){
			break;
		}

		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}
}