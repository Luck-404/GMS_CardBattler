//
//
// STEP - OBJ_PLAYER
//
//

//FULLSCREEN TOGGLE
if (keyboard_check_pressed(ord("F"))){
	window_set_fullscreen(!window_get_fullscreen());	
}


//ESC EXIT
if (keyboard_check_pressed(vk_escape)){
	show_debug_message("\n\n\n\n\n\nPLAYER PRESSED ESCAPE TO END GAME")
	game_end();	
}


// INPUT
var _move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// SPRITE DIRECTION / FACING

// NOT MOVING
if (_move_x == 0 && _move_y == 0)
{
	// face player/front
	image_index = 0;
	image_xscale = 1;
}
else
{
	// MOVING UP
	if (_move_y < 0)
	{
		image_index = 1;
		
		// LEFT / RIGHT FLIP
		if (_move_x < 0)
		{
			image_xscale = -1;
		}
		else
		{
			image_xscale = 1;
		}
	}
	
	// MOVING DOWN OR SIDEWAYS
	else
	{
		image_index = 0;
		
		// LEFT
		if (_move_x < 0)
		{
			image_xscale = -1;
		}
		
		// RIGHT
		else if (_move_x > 0)
		{
			image_xscale = 1;
		}
	}
}

// NORMALIZE DIAGONAL MOVEMENT
if (_move_x != 0 || _move_y != 0)
{
	_flag_moving = true;
    var _len = point_distance(0, 0, _move_x, _move_y);

    _move_x /= _len;
    _move_y /= _len;
} else {
	_flag_moving = false;	 
	_player_bounce_counter = 0;
	_player_bounce_frame = 0;
 }

// FINAL MOVEMENT
var _hsp = _move_x * _player_speed;
var _vsp = _move_y * _player_speed;



// HORIZONTAL COLLISION
if (place_meeting(x + _hsp, y, obj_wall))
{
    while (!place_meeting(x + sign(_hsp), y, obj_wall))
    {
        x += sign(_hsp);
    }

    _hsp = 0;
}

x += _hsp;



// VERTICAL COLLISION
if (place_meeting(x, y + _vsp, obj_wall))
{
    while (!place_meeting(x, y + sign(_vsp), obj_wall))
    {
        y += sign(_vsp);
    }

    _vsp = 0;
}

y += _vsp;

//STEP PARTICLE
	//TRIGGER A LEAF EVERY SO OFTEN
	if (_step_particle_timer <= 0 && obj_player._flag_moving == true){
		_step_particle_timer = 15;	
		//TRIGGER A FEW PARTICLES
		randomize();
		var _random_particles = irandom_range(1,3);
		//SPAWN THE PARTICLES
		for (var _i = 0; _i < _random_particles; _i++){
			var _particle = instance_create_layer(obj_player.x,obj_player.y,"ily_fx",obj_step_particle);	
		}
	} else {
		_step_particle_timer--;
	}