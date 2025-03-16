//////////////////////////////////////////////////////////////////////
//					OBJ_CARD_EFFECT DRAW							//
//																	//
// > DECREMENT LIFE EVERY STEP										//
//////////////////////////////////////////////////////////////////////
if (_sprite != undefined){
	if (_move == true){
		switch(_motion_type){
			case "Line":
			draw_sprite_ext(sprite_index,-1,x,y,_xscale,_yscale,0,_color,1);
	        // Calculate distance to target
	            var _dx = _x2 - x;
	            var _dy = _y2 - y;
	            var _dist = point_distance(x, y, _x2, _y2);

	            // If not at the destination, move
	            if (_dist > _proj_speed) {
	                var _dir = point_direction(x, y, _x2, _y2);
	                x += lengthdir_x(_proj_speed, _dir);
	                y += lengthdir_y(_proj_speed, _dir);
	            } else {
	                // Snap to target and stop movement
	                x = _x2;
	                y = _y2;
	                _move = false;
					//spawn secondary effect
					if (_secondary_script != undefined){
						_secondary_script();
					}
	            }
			break;
				
			case "Stationary":
				draw_sprite_ext(sprite_index,-1,x,y,_xscale,_yscale,0,_color,1);
				if (_secondary_script != undefined){
					_secondary_script();
				}
			break
		}
	}
}