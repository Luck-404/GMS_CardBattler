//////////////////////////////////////////////////////////////////////
//					OBJ_CARD_EFFECT DRAW							//
//																	//
// > DECREMENT LIFE EVERY STEP										//
//////////////////////////////////////////////////////////////////////
if (_sprite != undefined){
	if (_move == true){
		switch(_motion_type){
			#region SPARKLING PROJECTILE
			case "Sparkling Projectile":
				part_particles_burst(_psys, x, y,ps_verdant_projectile);
				
				draw_sprite_ext(sprite_index,-1,x,y,_xscale,_yscale,0,_color,1);
				// Move the projectile
				var _dx = _x2 - x;
				var _dy = _y2 - y;
				var _dist = point_distance(x, y, _x2, _y2);

				if (_dist > _proj_speed) {
				    var _dir = point_direction(x, y, _x2, _y2);
				    x += lengthdir_x(_proj_speed, _dir);
				    y += lengthdir_y(_proj_speed, _dir);
				} else {
				    x = _x2;
				    y = _y2;
				    _move = false;
					audio_play_sound(snd_effect_hit,0,false);	
					instance_destroy();

				    // Trigger secondary effect
				    if (_secondary_script != undefined) {
				        _secondary_script();
				    }
				}
			break;
			#endregion
			
			#region PROJECTILE
			case "Projectile":
				draw_sprite_ext(sprite_index,-1,x,y,_xscale,_yscale,0,_color,1);
		        // Calculate distance to target
	            _dx = _x2 - x;
	            _dy = _y2 - y;
	            _dist = point_distance(x, y, _x2, _y2);

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
					instance_destroy();
					//spawn secondary effect
					if (_secondary_script != undefined){
						_secondary_script();
					}
	            }
			break;
			#endregion
				
			#region STATIONARY
			case "Stationary":
				draw_sprite_ext(sprite_index,-1,x,y,_xscale,_yscale,0,_color,1);
				if (_secondary_script != undefined){
					_secondary_script();
				}
			break
			#endregion
			
			#region BEAM
			case "Beam":
				//create a beam effect from source to target, doesnt move
				part_particles_burst(_psys2, x, y, ps_deadseed_beam);
			break;
			#endregion
		}
	}
}