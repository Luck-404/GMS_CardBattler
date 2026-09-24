//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FEED_THE_FURNACE
// FUNCTION: Sacrifices the caster's oldest Minion to queue 2 Mana. If none
//           exists, sacrifices 8 caster HP and queues 1 Mana.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_vermilion_feed_the_furnace(_stct_card,_ref_caster,_ref_target){

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//==================//
	//SACRIFICE MINION//
	//==================//
	var _stct_sacrifice = scr_battle_sacrifice("MINION",_ref_caster,"OLDEST");

	if (_stct_sacrifice._flag_success){
		scr_battle_queue_mana_gain(2);
		return;
	}

	//================//
	//NO MINION — HP//
	//================//
	scr_battle_sacrifice("HOST_HEALTH",_ref_caster,8);

	//================//
	//GENERATE 1 MANA//
	//================//
	scr_battle_queue_mana_gain(
		1
	);
}