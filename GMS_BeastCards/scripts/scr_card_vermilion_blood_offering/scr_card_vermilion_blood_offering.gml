//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOOD_OFFERING
// FUNCTION: Sacrifices 10 caster HP, queues 1 Mana, then summons one random
//           Vermilion Minion if the caster survives and the pool is available.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_vermilion_blood_offering(_stct_card,_ref_caster,_ref_target){

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//================//
	//SACRIFICE 10 HP//
	//================//
	scr_battle_sacrifice("HOST_HEALTH",_ref_caster,10);

	//================//
	//GENERATE 1 MANA//
	//================//
	scr_battle_queue_mana_gain(1);

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}
	
	//=======================//
	//VALIDATE MINION POOL//
	//=======================//
	if (
		!variable_global_exists("arr_pool_vermilion_minions") ||
		!is_array(global.arr_pool_vermilion_minions)
	){
		return;
	}

	var _ct_pool_size =
		array_length(
			global.arr_pool_vermilion_minions
		);

	if (_ct_pool_size <= 0){
		return;
	}

	//=====================//
	//SELECT RANDOM MINION//
	//=====================//
	var _it_minion =
		irandom(
			_ct_pool_size - 1
		);

	var _str_minion_id =
		global.arr_pool_vermilion_minions[
			_it_minion
		];

	//================//
	//SUMMON MINION//
	//================//
	scr_minion_init(
		_str_minion_id,
		_stct_card,
		_ref_caster,
		_ref_caster
	);
}
