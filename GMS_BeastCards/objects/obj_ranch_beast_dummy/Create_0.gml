//===============================================================================//
//
// CREATE: OBJ_RANCH_BEAST_DUMMY
// FUNCTION: Initializes a ranch beast dummy.
//           Handles wandering behavior, animations, emoji effects,
//           and movement state variables.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = 1;

// IDENTIFIERS
_uid = undefined;
_shadow = spr_player_shadow;

//---------//
//STATES//
//---------//
enum BEAST_STATE{
	FIND_LOCATION,
	IDLE,
	MOVE,
	SHAKE,
	REST
}

_beast_state = choose(
	BEAST_STATE.FIND_LOCATION,
	BEAST_STATE.IDLE,
	BEAST_STATE.MOVE
);

//---------//
//EMOJIS//
//---------//
_spr_emoji = choose(
	spr_ranch_beast_happy,
	spr_ranch_beast_love,
	spr_ranch_beast_excited
);

_ct_emoji_timer = 0;

//---------//
//MOVEMENT//
//---------//
_ct_idle_time = irandom_range(60,300);

_val_target_x = room_width * 0.5 + irandom_range(-250,250);
_val_target_y = room_height * 0.5 + irandom_range(-250,250);

_val_move_speed = random_range(0.5,1.5);

// STEP PARTICLES
_ct_step_particle_timer = 15;

//---------//
//SHAKING//
//---------//
_ct_bounce_counter = 0;
_val_bounce_frame = 0;

_ct_shake_timer = 0;
_ct_shake_duration = 60;

_val_shake_intensity = 4;
_val_hop_height = 5;

_val_draw_y_offset = 0;
_val_draw_rotation = 0;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//