//===============================================================================//
//
// DRAW: OBJ_RANCH_BEAST_DUMMY
// FUNCTION: Draws the Ranch Beast, staged Beast sprite animation, shadow,
//           resting/dead state, shake effects, legacy bounce animation, and emojis.
//           Valid staged sprites use their WALK frames plus a minor half-strength
//           external movement bounce; legacy one-frame sprites retain full bounce.
//           SHAKE and INTERACT are mutually exclusive one-shot presentations;
//           each fully resets rotation/Y-offset before returning to locomotion.
//           REST uses DEATH frame 9 for animation-valid species while preserving
//           spr_ranch_beast_resting; legacy species retain the dark fallback.
//           Ranch staged sprites preserve the same 512-canvas ground anchor used
//           by normal overworld Beasts despite the Ranch's larger 0.15 draw scale.
//           Executes the Ranch Beast state machine while the game is unpaused.
//
//===============================================================================//

//======================//
//BEAST SPRITE ANIMATION//
//======================//
var _flag_beast_animation_valid = scr_beast_animation_ensure(self);

//====================//
//RANCH DRAW BASELINE//
//====================//
/*
	Normal overworld Beasts use a 512 x 512 centered sprite at 0.10 scale and
	draw their shadow at y + 24. Ranch Beasts intentionally render larger at
	0.15 scale. If both sprites are centered on raw y, the Ranch Beast's canvas
	extends 12.8 px farther downward and visually overruns the same shadow anchor.

	Lift only the Ranch Beast by that added lower-half distance so its 512-canvas
	bottom matches the normal overworld Beast while the shared ground/shadow point
	remains y + 24. This uses sprite-canvas geometry, never bbox/mask dimensions.
*/
var _val_overworld_beast_scale = 0.10;
var _val_ranch_beast_scale = 0.15;
var _val_sprite_half_height = 512 * 0.5;

var _val_ranch_vertical_lift =
	_val_sprite_half_height *
	(_val_ranch_beast_scale - _val_overworld_beast_scale);

var _val_ranch_beast_draw_y =
	y -
	_val_ranch_vertical_lift;

var _val_shadow_draw_y = y + 24;

//================//
//DRAW SHADOW//
//================//
draw_sprite_ext(
	_spr_shadow,
	0,
	x,
	_val_shadow_draw_y,
	1,
	1,
	0,
	c_white,
	1
);

//====================//
//CURRENT BEAST FRAME//
//====================//
var _flag_ranch_beast_dead =
	_state_dummy == ENUM_RANCH_BEAST_DUMMY_STATE.REST;

var _val_beast_subimage =
	scr_beast_animation_get_frame(self);

// Dead staged species use their final DEATH pose. REST is the Ranch dummy's
// persistent dead state, so it should not fall back to the living frame 0.
if (_flag_ranch_beast_dead){

	if (
		_flag_beast_animation_valid &&
		sprite_exists(sprite_index)
	){
		_val_beast_subimage =
			min(
				9,
				max(
					0,
					sprite_get_number(sprite_index) - 1
				)
			);
	}
	else{
		_val_beast_subimage = 0;
	}
}

// WALK frames own the main locomotion. Staged sprites also receive a small
// half-strength 0-2 px Ranch bounce; legacy one-frame sprites keep 0-4 px.
var _val_beast_bounce_y =
	(_state_dummy == ENUM_RANCH_BEAST_DUMMY_STATE.MOVE)
	? (
		_flag_beast_animation_valid
		? (_val_bounce_frame * 0.5)
		: _val_bounce_frame
	)
	: 0;

//================//
//DRAW BEAST//
//================//
if (_state_dummy == ENUM_RANCH_BEAST_DUMMY_STATE.REST){

	draw_sprite_ext(
		sprite_index,
		_val_beast_subimage,
		x,
		_val_ranch_beast_draw_y + _val_beast_bounce_y,
		image_xscale * _val_ranch_beast_scale,
		_val_ranch_beast_scale,
		_val_draw_rotation,
		_flag_beast_animation_valid
			? c_white
			: global.c_dk_gray,
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
else if (_state_dummy == ENUM_RANCH_BEAST_DUMMY_STATE.SHAKE){

	draw_sprite_ext(
		sprite_index,
		_val_beast_subimage,
		x,
		_val_ranch_beast_draw_y + _val_draw_y_offset,
		image_xscale * _val_ranch_beast_scale,
		_val_ranch_beast_scale,
		_val_draw_rotation,
		c_white,
		1
	);
}
else{

	draw_sprite_ext(
		sprite_index,
		_val_beast_subimage,
		x,
		_val_ranch_beast_draw_y + _val_beast_bounce_y,
		image_xscale * _val_ranch_beast_scale,
		_val_ranch_beast_scale,
		_val_draw_rotation,
		c_white,
		1
	);
}

//================//
//DRAW EMOJI//
//================//
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

//================//
//STATE MACHINE//
//================//
if (!global.flag_pause){

	switch (_state_dummy){

		//================//
		//FIND LOCATION//
		//================//
		case ENUM_RANCH_BEAST_DUMMY_STATE.FIND_LOCATION:

			_val_target_x = (room_width * 0.5) + irandom_range(-250,250);
			_val_target_y = (room_height * 0.5) + irandom_range(-250,250);

			_val_move_speed = random_range(0.5,2.5);

			_state_dummy = choose(
				ENUM_RANCH_BEAST_DUMMY_STATE.IDLE,
				ENUM_RANCH_BEAST_DUMMY_STATE.MOVE
			);

		break;

		//================//
		//IDLE//
		//================//
		case ENUM_RANCH_BEAST_DUMMY_STATE.IDLE:

			if (_ct_idle_time > 0){
				_ct_idle_time--;
			}
			else{

				//----------------//
				//ROLL EMOJI//
				//----------------//
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
					ENUM_RANCH_BEAST_DUMMY_STATE.MOVE,
					ENUM_RANCH_BEAST_DUMMY_STATE.SHAKE
				);
			}

		break;

		//================//
		//MOVE//
		//================//
		case ENUM_RANCH_BEAST_DUMMY_STATE.MOVE:

			//----------------//
			//UPDATE BOUNCE//
			//----------------//
			_ct_bounce_counter++;

			if (_ct_bounce_counter >= 6){

				_ct_bounce_counter = 0;
				_val_bounce_frame++;

				if (_val_bounce_frame > 4){
					_val_bounce_frame = 0;
				}
			}

			//----------------//
			//MOVE TO TARGET//
			//----------------//
			var _val_dx = _val_target_x - x;
			var _val_dy = _val_target_y - y;
			var _val_distance = point_distance(x,y,_val_target_x,_val_target_y);

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
					ENUM_RANCH_BEAST_DUMMY_STATE.FIND_LOCATION,
					ENUM_RANCH_BEAST_DUMMY_STATE.SHAKE
				);
			}

			//----------------------//
			//CREATE STEP PARTICLES//
			//----------------------//
			if (_ct_step_particle_timer <= 0){

				_ct_step_particle_timer = 15;

				var _ct_particles = irandom_range(1,3);

				for (var _it_particle = 0;_it_particle < _ct_particles;_it_particle++){

					var _ref_particle = instance_create_layer(
						x,
						y + 24,
						"ily_fx",
						obj_overworld_vfx_step_particle
					);

					if (instance_exists(_ref_particle)){
						_ref_particle.depth = depth - 1;
					}
				}

				//----------------------//
				//RANDOM BRUSH SCENE VFX//
				//----------------------//
				if (irandom_range(1,8) == 1){
					scr_overworld_spawn_vfx_plant_litter(
						x,
						y + 24,
						true
					);
				}

				//----------------//
				//NEARBY FOOTSTEP//
				//----------------//
				if (
					instance_exists(obj_player) &&
					point_distance(
						x,
						y,
						obj_player.x,
						obj_player.y
					) <= 64
				){
					audio_play_sound(
						snd_overworld_beast_step,
						0,
						false
					);
				}
			}
			else{
				_ct_step_particle_timer--;
			}

		break;

		//================//
		//SHAKE//
		//================//
		case ENUM_RANCH_BEAST_DUMMY_STATE.SHAKE:

			if (_ct_shake_timer <= 0){

				// A newly started SHAKE owns the Ranch presentation exclusively.
				// Clear any stale transform before beginning its one-shot motion.
				_val_draw_rotation = 0;
				_val_draw_y_offset = 0;

				// Animated species freeze on IDLE frame 0 while the legacy physical
				// SHAKE owns presentation. Do not run a second sprite cycle beneath it.
				if (_flag_beast_animation_valid){
					scr_beast_animation_play(self,"IDLE",true);
				}

				_ct_shake_timer = _ct_shake_duration;

				_val_shake_intensity = random_range(4,10);
				_val_hop_height = random_range(3,10);
			}

			_ct_shake_timer--;

			var _val_progress = 1 - (_ct_shake_timer / _ct_shake_duration);

			_val_draw_rotation = sin(_val_progress * 720) * _val_shake_intensity;
			_val_draw_y_offset = -abs(sin(_val_progress * 1440)) * _val_hop_height;

			if (_ct_shake_timer <= 0){

				_val_draw_rotation = 0;
				_val_draw_y_offset = 0;

				_state_dummy = choose(
					ENUM_RANCH_BEAST_DUMMY_STATE.IDLE,
					ENUM_RANCH_BEAST_DUMMY_STATE.FIND_LOCATION
				);
			}

		break;

		//================//
		//INTERACT//
		//================//
		case ENUM_RANCH_BEAST_DUMMY_STATE.INTERACT:

			if (
				!scr_beast_animation_ensure(self) ||
				_flag_beast_animation_finished
			){
				// Release all one-shot presentation state together. This guarantees
				// the Beast cannot carry a partial SHAKE tilt/hop into locomotion.
				_val_draw_rotation = 0;
				_val_draw_y_offset = 0;
				_ct_shake_timer = 0;

				if (_flag_beast_animation_valid){
					scr_beast_animation_play(self,"IDLE",true);
				}

				_state_dummy = choose(
					ENUM_RANCH_BEAST_DUMMY_STATE.IDLE,
					ENUM_RANCH_BEAST_DUMMY_STATE.FIND_LOCATION
				);
			}

		break;

		//================//
		//REST//
		//================//
		case ENUM_RANCH_BEAST_DUMMY_STATE.REST:
		break;
	}
}

//======================//
//BEAST SPRITE ANIMATION//
//======================//
/*
	Synchronize after the Ranch state machine has resolved this frame so WALK/IDLE
	uses the actual resulting MOVE state. INTERACT is allowed to finish untouched;
	the INTERACT case above explicitly releases it back to IDLE.
*/
if (_flag_beast_animation_valid && !global.flag_pause){

	if (_state_dummy == ENUM_RANCH_BEAST_DUMMY_STATE.MOVE){
		scr_beast_animation_sync_locomotion(self,true);
		scr_beast_animation_update(self);
	}
	else if (_state_dummy == ENUM_RANCH_BEAST_DUMMY_STATE.INTERACT){
		// INTERACT exclusively owns the staged sprite until its one-shot completes.
		scr_beast_animation_update(self);
	}
	else if (_state_dummy == ENUM_RANCH_BEAST_DUMMY_STATE.SHAKE){
		// SHAKE exclusively owns the physical transform. The staged sprite is
		// intentionally frozen on the frame installed when SHAKE began.
	}
	else if (_state_dummy != ENUM_RANCH_BEAST_DUMMY_STATE.REST){
		scr_beast_animation_sync_locomotion(self,false);
		scr_beast_animation_update(self);
	}
}