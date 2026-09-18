//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FEED_THE_FLAME
// FUNCTION: Resolves Feed the Flame.
//           Sacrifices the caster's oldest Minion and adds that Minion's
//           Maximum HP to the attack's base damage.
//           If no Minion is available, the caster loses 6 HP instead.
//           Applies 2 Burn to the surviving target.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_feed_the_flame(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//BASE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;
	var _ref_minion = undefined;

	//==================//
	//GET OLDEST MINION//
	//==================//
	if (ds_exists(_ref_caster._list_minions,ds_type_list)){

		while (ds_list_size(_ref_caster._list_minions) > 0){

			_ref_minion = ds_list_find_value(
				_ref_caster._list_minions,
				0
			);

			if (instance_exists(_ref_minion)){
				break;
			}

			ds_list_delete(
				_ref_caster._list_minions,
				0
			);

			_ref_minion = undefined;
		}
	}

	//================//
	//SACRIFICE MINION//
	//================//
	if (instance_exists(_ref_minion)){

		_val_damage += _ref_minion._val_max_hp;

		scr_minion_destroy(
			_ref_minion,
			"SACRIFICE"
		);
	}

	//================//
	//NO MINION//
	//================//
	else{

		var _val_hp_loss = min(
			6,
			_ref_caster._val_cur_hp
		);

		_ref_caster._val_cur_hp -= _val_hp_loss;

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_hp_loss),
			undefined,
			c_maroon,
			_ref_caster.x + irandom_range(-32,32),
			_ref_caster.y - 24 + irandom_range(-32,32)
		);
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_val_damage,
		_ref_target
	);

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//APPLY 2 BURN//
	//================//
	var _ref_original_target = global.ref_target_beast;

	global.ref_target_beast = _ref_target;

	repeat (2){
		scr_status_apply_dot("BURN");
	}

	global.ref_target_beast = _ref_original_target;
}