//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FEED_THE_FURNACE
// FUNCTION: Resolves Feed the Furnace.
//           Sacrifices the caster's oldest Minion and generates 2 Mana.
//           If the caster has no Minion, loses 8 HP and generates 1 Mana.
//
//           Generated Mana is queued so it resolves after the Card's Mana cost
//           is paid.
//
// ARGUMENTS: _stct_card is the Feed the Furnace Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_feed_the_furnace(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//==================//
	//GET OLDEST MINION//
	//==================//
	var _ref_minion = undefined;

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

	//==================//
	//SACRIFICE MINION//
	//==================//
	if (instance_exists(_ref_minion)){

		scr_minion_destroy(
			_ref_minion,
			"SACRIFICE"
		);

		//================//
		//GENERATE 2 MANA//
		//================//
		scr_battle_queue_mana_gain(
			2
		);

		return;
	}

	//================//
	//NO MINION — HP//
	//================//
	var _val_hp_loss = min(
		8,
		_ref_caster._val_cur_hp
	);

	_ref_caster._val_cur_hp = max(
		0,
		_ref_caster._val_cur_hp - _val_hp_loss
	);

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"-" + string(_val_hp_loss) + " HP",
		undefined,
		c_red,
		_ref_caster.x,
		_ref_caster.y - 48
	);

	//================//
	//GENERATE 1 MANA//
	//================//
	scr_battle_queue_mana_gain(
		1
	);
}