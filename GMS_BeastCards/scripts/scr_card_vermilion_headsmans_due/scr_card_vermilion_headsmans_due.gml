//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_HEADSMANS_DUE
// FUNCTION: Resolves Headsman's Due.
//           Deals linear Physical damage.
//           Adds 12 damage if the target begins below 25% HP.
//           EXECUTE queues 2 Mana to be generated after the Card cost is paid.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_headsmans_due(_stct_card,_ref_caster,_ref_target){

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
	//CHECK 25% HP//
	//================//
	var _flag_low_hp =
		_ref_target._val_cur_hp <
		(_ref_target._val_max_hp * 0.25);

	//====================//
	//STORE EXECUTE STATE//
	//====================//
	var _flag_target_alive = _ref_target._val_cur_hp > 0;

	//================//
	//GET DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;

	if (_flag_low_hp){
		_val_damage += 12;
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_val_damage,
		_ref_target
	);

	//================//
	//EXECUTE//
	//================//
	if (
		!scr_battle_trigger_execute(
			_ref_caster,
			_ref_target,
			_flag_target_alive
		)
	){
		return;
	}

	//================//
	//GENERATE 2 MANA//
	//================//
	scr_battle_queue_mana_gain(2);
}