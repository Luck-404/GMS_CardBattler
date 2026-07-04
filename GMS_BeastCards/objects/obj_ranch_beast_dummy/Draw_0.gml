//===============================================================================//
//
// DRAW: OBJ_RANCH_BEAST_DUMMY
// FUNCTION: Draws the ranch beast, shadow, resting state,
//           shake effects, bounce animation, and emojis.
//           Executes the ranch beast state machine.
//
//===============================================================================//

//
// DRAW SHADOW AND BEAST
//
#region DRAW SHADOW AND BEAST
draw_sprite_ext(_spr_shadow,0,x,y + 30,1,1,0,c_white,1);

if (_state_dummy == ENUM_DUMMY_STATE.REST){

	draw_sprite_ext(
		sprite_index,
		0,
		x,
		y + _val_bounce_frame,
		image_xscale * 0.15,
		0.15,
		_val_draw_rotation,
		c_gray,
		1
	);

	draw_sprite_ext(
		spr_ranch_beast_resting,
		0,
		x,
		y,
		0.5,
		0.5,
		0,
		c_white,
		1
	);
}
else{

	if (_state_dummy == ENUM_DUMMY_STATE.SHAKE){

		draw_sprite_ext(
			sprite_index,
			0,
			x,
			y + _val_draw_y_offset,
			image_xscale * 0.15,
			0.15,
			_val_draw_rotation,
			c_white,
			1
		);
	}
	else{

		draw_sprite_ext(
			sprite_index,
			0,
			x,
			y + _val_bounce_frame,
			image_xscale * 0.15,
			0.15,
			_val_draw_rotation,
			c_white,
			1
		);
	}
}
#endregion

//
// DRAW EMOJI
//
#region EMOJI
if (_ct_emoji_timer > 0){

	_ct_emoji_timer--;

	draw_sprite_ext(
		_spr_emoji,
		0,
		x + 30,
		y - 30,
		0.25,
		0.25,
		0,
		c_white,
		1
	);
}
#endregion

//
// STATE MACHINE
//
#region STATE MACHINE
if (!global.flag_pause){

	switch(_state_dummy){

		//
		// FIND LOCATION
		//
		#region FIND LOCATION
		case ENUM_DUMMY_STATE.FIND_LOCATION:

			_val_target_x = room_width * 0.5 + irandom_range(-250,250);
			_val_target_y = room_height * 0.5 + irandom_range(-250,250);

			_val_move_speed = random_range(0.5,2.5);

			_state_dummy = choose(
				ENUM_DUMMY_STATE.IDLE,
				ENUM_DUMMY_STATE.MOVE
			);

		break;
		#endregion

		//
		// IDLE
		//
		#region IDLE
		case ENUM_DUMMY_STATE.IDLE:

			if (_ct_idle_time > 0){

				_ct_idle_time--;
			}
			else{

				if (irandom_range(0,100) < 40){

					_spr_emoji = choose(
						spr_ranch_beast_happy,
						spr_ranch_beast_love,
						spr_ranch_beast_excited
					);

					_ct_emoji_timer = irandom_range(60,120);
				}

				_ct_idle_time = irandom_range(60,300);

				_state_dummy = choose(
					ENUM_DUMMY_STATE.MOVE,
					ENUM_DUMMY_STATE.SHAKE
				);
			}

		break;
		#endregion

		//
		// MOVE
		//
		#region MOVE
		case ENUM_DUMMY_STATE.MOVE:

			// BOUNCE
			_ct_bounce_counter++;

			if (_ct_bounce_counter >= 6){

				_ct_bounce_counter = 0;

				_val_bounce_frame++;

				if (_val_bounce_frame > 4){
					_val_bounce_frame = 0;
				}
			}

			// MOVEMENT
			var _val_dx = _val_target_x - x;
			var _val_dy = _val_target_y - y;

			var _val_distance = point_distance(
				x,
				y,
				_val_target_x,
				_val_target_y
			);

			if (_val_dx > 0){
				image_xscale = 1;
			}
			else if (_val_dx < 0){
				image_xscale = -1;
			}

			if (_val_distance > _val_move_speed){

				x += (_val_dx / _val_distance) * _val_move_speed;
				y += (_val_dy / _val_distance) * _val_move_speed;
			}
			else{

				x = _val_target_x;
				y = _val_target_y;

				_state_dummy = choose(
					ENUM_DUMMY_STATE.FIND_LOCATION,
					ENUM_DUMMY_STATE.SHAKE
				);
			}

			// STEP PARTICLES
			if (_ct_step_particle_timer <= 0){

				_ct_step_particle_timer = 15;

				var _ct_particles = irandom_range(1,3);

				for (var _it_particle = 0; _it_particle < _ct_particles; _it_particle++){

					var _ref_particle = instance_create_layer(
						x,
						y + 30,
						"ily_fx",
						obj_scene_fx_step_particle
					);

					_ref_particle._owner = self;
					_ref_particle.depth = depth - 1;
				}
			}
			else{
				_ct_step_particle_timer--;
			}

		break;
		#endregion

		//
		// SHAKE
		//
		#region SHAKE
		case ENUM_DUMMY_STATE.SHAKE:

			if (_ct_shake_timer <= 0){

				_ct_shake_timer = _ct_shake_duration;

				_val_shake_intensity = random_range(4,10);
				_val_hop_height = random_range(3,10);
			}

			_ct_shake_timer--;

			var _val_progress = 1 - (_ct_shake_timer / _ct_shake_duration);

			_val_draw_rotation = sin(_val_progress * 720) * _val_shake_intensity;

			_val_draw_y_offset = -abs(
				sin(_val_progress * 1440)
			) * _val_hop_height;

			if (_ct_shake_timer <= 0){

				_val_draw_rotation = 0;
				_val_draw_y_offset = 0;

				_state_dummy = choose(
					ENUM_DUMMY_STATE.IDLE,
					ENUM_DUMMY_STATE.FIND_LOCATION
				);
			}

		break;
		#endregion

		//
		// REST
		//
		#region REST
		case ENUM_DUMMY_STATE.REST:
		break;
		#endregion
	}
}
#endregion