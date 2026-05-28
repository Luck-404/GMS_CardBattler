//
//
// DRAW: OBJ_RANCH_BEAST_DUMMY | DRAW SELF AND SHADOW AND MOVE AROUND RANDOMLY
//
//

#region CHANGE DEPTH WITH Y VALUE
if (global.active_gui == undefined){
 depth = -y;
} else {
 depth = 0;	
}
#endregion

#region DRAW SHADOW AND SPRITE
draw_sprite_ext(_shadow,0,x,y+30,1,1,0,c_white,1);

if (_beast_state == BEAST_STATE.SHAKE){
	draw_sprite_ext(sprite_index,0,x,y+_draw_y_offset,image_xscale * 0.15,0.15,_draw_rot,c_white,1);
} else {
	draw_sprite_ext(sprite_index,0,x,y+_bounce_frame,image_xscale * 0.15,0.15,_draw_rot,c_white,1);	
}
#endregion

#region EMOJI TIMER
if (_emoji_timer > 0){
	_emoji_timer--;
	draw_sprite_ext(_emoji,0,x+30,y-30,0.25,0.25,0,c_white,1);
}
#endregion

//
// STATE MACHINE
//
#region STATE MACHINE
if (global.pause == false){
	switch(_beast_state){
		
		//
		// FINDS A NEW LOCATION TO MOVE TOWARD
		//
		#region FIND_LOCATION
		case BEAST_STATE.FIND_LOCATION:
			//GET NEW X,Y
			_tar_x = room_width/2+irandom_range(-250,250);
			_tar_y = room_height/2+irandom_range(-250,250);
			
			//RANDOMIZE SPEED
			_move_speed = random_range(0.5, 2.5);
			
			//MOVE TO NEW ACTION
			_beast_state = choose(BEAST_STATE.IDLE,BEAST_STATE.MOVE);
		break;
		#endregion
	
		//
		// WAIT FOR A LITTLE WHILE
		//
		#region IDLE
		case BEAST_STATE.IDLE:
			//WAITING COUNTDOWN
			if (_idle_time > 0){
				_idle_time--;	
			} 
			//ONCE WAITING IS OVER, ROLL FOR AN EMOJI PLAY
			else {
				//EMOJI ROLL
				var _roll = irandom_range(0,100);
				if (_roll < 40){
					_emoji = choose(spr_ranch_beast_happy,spr_ranch_beast_love,spr_ranch_beast_excited);
					_emoji_timer = irandom_range(60,120);	
				}
				
				//ROLL NEW IDLE TIME
				_idle_time = irandom_range(60,300);
				
				//MOVE TO NEW ACTION
				_beast_state = choose(BEAST_STATE.MOVE,BEAST_STATE.SHAKE);

			}
		break;
		#endregion
	
		//
		// MOVE TOWARD DESTINATION, BOUNCING AND PLAYING
		//
		#region MOVE
		case BEAST_STATE.MOVE:

			#region BOUNCE WHILE MOVING
			_bounce_counter++;
	
			if (_bounce_counter >= 6){
				_bounce_counter = 0;
				_bounce_frame++;
				//bounce a max of 4 px high
				if (_bounce_frame > 4){
					_bounce_frame = 0;
				}
			}	
			#endregion

			#region MOVEMENT
		    var _dx = _tar_x - x;
		    var _dy = _tar_y - y;

		    var _dist = point_distance(x, y, _tar_x, _tar_y);

		    // FACE DIRECTION MOVING
		    if (_dx > 0){
		        image_xscale = 1;
		    }
		    else if (_dx < 0){
		        image_xscale = -1;
		    }

			//MOVE TOWARD TARGET
		    if (_dist > _move_speed){
		        x += (_dx / _dist) * _move_speed;
		        y += (_dy / _dist) * _move_speed;
		    }
			//ONCE TARGET IS REACHED
		    else {
		        x = _tar_x;
		        y = _tar_y;

				//CHOOSE NEW ACTION
		        _beast_state = choose(BEAST_STATE.FIND_LOCATION,BEAST_STATE.SHAKE);
		    }
			#endregion
			
			#region STEP PARTICLES WHILE MOVING
			//TRIGGER A STEP PARTICLE EVERY SO OFTEN
			if (_step_particle_timer <= 0){
				_step_particle_timer = 15;	
				//TRIGGER A FEW PARTICLES
				randomize();
				var _random_particles = irandom_range(1,3);
				//SPAWN THE PARTICLES
				for (var _i = 0; _i < _random_particles; _i++){
					var _particle = instance_create_layer(x,y+30,"ily_fx",obj_scene_fx_step_particle);	
					_particle.depth = depth-1;
				}
			} else {
				_step_particle_timer--;
			}
			#endregion
		break;
		#endregion
		
		//
		// SHAKE THE UNIT RANDOMLY
		//
		#region SHAKE
		case BEAST_STATE.SHAKE:

			//ROLL NEW INFO FOR NEXT SHAKE EVENT
		    if (_shake_timer <= 0)
		    {
		        _shake_timer = _shake_duration;
		        _shake_intensity = random_range(4, 10);
		        _hop_height = random_range(3, 10);
		    }

			//DECREMENT TIMER
		    _shake_timer--;

			//SHAKE TRACKER
		    var _progress = 1 - (_shake_timer / _shake_duration);

		    // ROCKING
		    _draw_rot = sin(_progress * 720) * _shake_intensity;

		    // HOPPING
		    _draw_y_offset = -abs(sin(_progress * 1440)) * _hop_height;

			//END OF TIMER
		    if (_shake_timer <= 0)
		    {
		        _draw_rot = 0;
		        _draw_y_offset = 0;

				//CHOOSE NEW ACTION
		        _beast_state = choose(BEAST_STATE.IDLE,BEAST_STATE.FIND_LOCATION);
		    }
		break;
		#endregion
	}
}
#endregion