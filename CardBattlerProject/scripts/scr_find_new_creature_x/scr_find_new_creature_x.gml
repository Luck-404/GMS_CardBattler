function scr_find_new_creature_x(_team,_pos){
	switch (_team){
		#region PLAYER
		case "Player":
			var _total = ds_list_size(global.player_party_in_play) + ds_list_size(global.player_party_dead);
			switch(_total){
				case 1:
					return 433;
				break;
				
				case 2:
					if (_pos == 1){
						return 353;
					} else {
						return 512;	
					}
				break;		
				case 3:
					if (_pos == 1){
						return 273;	
					} else if (_pos == 2){
						return 433;	
					} else {
						return 593;	
					}
				break;	
				case 4:
					if (_pos == 1){
						return 193;	
					} else if (_pos == 2){
						return 353;	
					} else if (_pos == 3){
						return 513;	
					} else {
						return 673;	
					}
				break;	 
				case 5:
					if (_pos == 1){
						return 113;	
					} else if (_pos == 2){
						return 273;	
					} else if (_pos == 3){
						return 433;	
					} else if (_pos == 4){
						return 593;	
					} else {
						return 753;	
					}
				break;				
			}
		break;
		#endregion
		
		#region ENEMY
		case "Enemy":
			_total = ds_list_size(global.enemy_party_in_play) + ds_list_size(global.enemy_party_dead);			
			switch(_total){
				case 1:
					return 1487;
				break;
				
				case 2:
					if (_pos == 1){
						return 1407;
					} else {
						return 1567;	
					}
				break;		
				case 3:
					if (_pos == 1){
						return 1327;	
					} else if (_pos == 2){
						return 1487;	
					} else {
						return 1647;	
					}
				break;	
				case 4:
					if (_pos == 1){
						return 1247;	
					} else if (_pos == 2){
						return 1407;	
					} else if (_pos == 3){
						return 1567;	
					} else {
						return 1727;	
					}
				break;	 
				case 5:
					if (_pos == 1){
						return 1167;	
					} else if (_pos == 2){
						return 1327;	
					} else if (_pos == 3){
						return 1487;	
					} else if (_pos == 4){
						return 1647;	
					} else {
						return 1807;	
					}
				break;				
			}
		break;
		#endregion
	}
}