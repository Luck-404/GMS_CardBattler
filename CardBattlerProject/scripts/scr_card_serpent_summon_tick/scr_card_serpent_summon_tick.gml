//////////////////////////////////////////////////////////////////////
//					SCR_CARD_SERPENT_SUMMON_TICK					//
//																	//
// > REMOVE 10DMG BUFF												//	
//////////////////////////////////////////////////////////////////////
function scr_card_serpent_summon_tick(_target,_repeat){
	if (_repeat == false){
		_target._creature_attack_linear = _target._creature_attack_linear-10;
	} else {
		
	}
}