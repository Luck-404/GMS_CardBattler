// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_rearrange_minion(_minion,_count){
	var _host = _minion_unit_attached;
	var _x_pos = _host.x;
	var _y_pos = _host.y;

	
	if(_count == 3){
		if (_minion._minion_team = "Enemy"){
			switch(_minion._minion_position){
				case 0:
					x = _x_pos - 64;
					y = _y_pos + 100;		
				break;
			
				case 1:
					x = _x_pos;
					y = _y_pos + 100;			
				break;
			
				case 2:
					x = _x_pos + 64;
					y = _y_pos + 100;							
				break;
			}
		} else {
			switch(_minion._minion_position){
				case 0:
	
					x = _x_pos + 64;
					y = _y_pos + 100;						
				break;
			
				case 1:
					x = _x_pos;
					y = _y_pos + 100;			
				break;
			
				case 2:
					x = _x_pos - 64;
					y = _y_pos + 100;				
				break;	
			}
		}
	}
	
	else if(_count == 5){
		if (_minion._minion_team = "Enemy"){		
			switch(_minion._minion_position){
					case 0:
						x = _x_pos - 76;
						y = _y_pos + 100;							
					break;
			
					case 1:
						x = _x_pos-40;
						y = _y_pos+130;								
					break;
			
					case 2:
						x = _x_pos;
						y = _y_pos+100;						
					break;
			
					case 3:
						x = _x_pos+40;
						y = _y_pos+130;							
					break;

					case 4:
						x = _x_pos+76;
						y = _y_pos+100;							
					break;
				}
		} 
		else {
			switch(_minion._minion_position){
					case 0:
						x = _x_pos+64;
						y = _y_pos+100;		
					break;
			
					case 1:
						x = _x_pos+32;
						y = _y_pos+130;								
					break;
			
					case 2:
						x = _x_pos;
						y = _y_pos+100;						
					break;
			
					case 3:
						x = _x_pos-32;
						y = _y_pos+130;					
					break;

					case 4:
						x = _x_pos - 64;
						y = _y_pos + 100;				
					break;
				}
			}
	}
}