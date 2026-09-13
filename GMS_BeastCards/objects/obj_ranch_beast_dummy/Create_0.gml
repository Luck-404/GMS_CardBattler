//===============================================================================//
//
// CREATE: OBJ_RANCH_BEAST_DUMMY
// FUNCTION: Initializes a Ranch Beast dummy.
//           Stores Beast presentation data, wandering behavior, emoji effects,
//           movement state, and shake-animation state.
//
//===============================================================================//

//================//
//DRAW SETTINGS//
//================//
depth = 1;

//================//
//IDENTIFIERS//
//================//
_uid_dummy = undefined;

_spr_shadow = spr_player_shadow;

_snd_cry = undefined;
_snd_death = undefined;

//================//
//DUMMY STATES//
//================//
enum ENUM_RANCH_BEAST_DUMMY_STATE{
	FIND_LOCATION,
	IDLE,
	MOVE,
	SHAKE,
	REST
}

_state_dummy = choose(
	ENUM_RANCH_BEAST_DUMMY_STATE.FIND_LOCATION,
	ENUM_RANCH_BEAST_DUMMY_STATE.IDLE,
	ENUM_RANCH_BEAST_DUMMY_STATE.MOVE
);

//================//
//EMOJI STATE//
//================//
_spr_emoji = choose(
	spr_ranch_beast_happy,
	spr_ranch_beast_love,
	spr_ranch_beast_excited
);

_ct_emoji_timer = 0;

//================//
//MOVEMENT STATE//
//================//
_ct_idle_time = irandom_range(60,300);

_val_target_x = (room_width * 0.5) + irandom_range(-250,250);
_val_target_y = (room_height * 0.5) + irandom_range(-250,250);

_val_move_speed = random_range(0.5,1.5);

//----------------------//
//STEP PARTICLE TIMING//
//----------------------//
_ct_step_particle_timer = 15;

//================//
//SHAKE STATE//
//================//
_ct_bounce_counter = 0;
_val_bounce_frame = 0;

_ct_shake_timer = 0;
_ct_shake_duration = 60;

_val_shake_intensity = 4;
_val_hop_height = 5;

_val_draw_y_offset = 0;
_val_draw_rotation = 0;