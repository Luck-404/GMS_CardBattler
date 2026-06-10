//
//
// CREATE: OBJ_RANCH_BEAST_DUMMY
//
//

//
//VARIABLES
//

//IDENTIFIERS
_uid = undefined;
_shadow = spr_player_shadow;

//STATE LOGIC
enum BEAST_STATE{
	FIND_LOCATION,
	IDLE,
	MOVE,
	SHAKE,
	DEAD
}

_beast_state = choose(BEAST_STATE.FIND_LOCATION,BEAST_STATE.IDLE,BEAST_STATE.MOVE);

//RANDOM EMOJIS
_emoji = choose(spr_ranch_beast_happy,spr_ranch_beast_love,spr_ranch_beast_excited);
_emoji_timer = 0;

//MOVEMENT AND WAITING
_idle_time = irandom_range(60,300);
_tar_x = room_width/2+irandom_range(-250,250);
_tar_y = room_height/2+irandom_range(-250,250);
_move_speed = random_range(0.5, 1.5);

//STEP FX
_player_step_particle_timer = 15;

//SHAKING FX
_bounce_counter = 0;
_bounce_frame = 0;
_shake_timer = 0;
_shake_duration = 60;
_shake_intensity = 4;
_hop_height = 5;
_draw_y_offset = 0;
_draw_rot = 0;

//
//INIT
//

//
//METHODS
//