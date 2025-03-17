//////////////////////////////////////////////////////////////////////
//				SCR_TRIGGER_GLOBAL_REACTIONS						//
//																	//
// > MINIONS WITH THE 'HOST DMG TAKEN' AND 'HOST ATTACKED' RESET    //
//   ALLOWING THEM TO TRIGGER										//
//////////////////////////////////////////////////////////////////////
function scr_trigger_global_reactions(_card,_target,_channel,_damage){
	with(obj_card_status_counter){
		_latest_card = _card;
		_latest_target = _target;
		_latest_channel = _channel;
		_latest_damage = _damage;
	}
	
	with(obj_minion){
		_latest_card = _card;
		_latest_target = _target;
		_latest_channel = _channel;
		_latest_damage_done = _damage;
	}
}