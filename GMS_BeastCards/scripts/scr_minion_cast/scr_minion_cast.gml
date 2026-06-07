//
//
//
//
//
function scr_minion_cast(_minion){
	var _min_name = _minion._name;
	var _min_team = _minion._team;
	var _enemy_list;
	var _friendly_list;
	if (_min_team == "PLAYER"){
		_friendly_list = obj_battle_player_controller._beasts_alive;
		_enemy_list = obj_battle_enemy_controller._beasts_alive;
	}else{
		_enemy_list = obj_battle_player_controller._beasts_alive;
		_friendly_list = obj_battle_enemy_controller._beasts_alive;
	}
	
	switch(_min_name){
		case "LIFE SPIRIT":
			//HEAL HOST
			scr_heal_target(2,_minion._host);
			
			//PLAY ANIMATION
	
			//PLAY SOUND
	
		break;
	}
}