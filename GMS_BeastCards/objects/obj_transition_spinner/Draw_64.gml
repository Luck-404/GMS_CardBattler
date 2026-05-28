//
//
// DRAW GUI: OBJ_TRANSITION_SPINNER | VISUALLY SPINS AT THE RATE GIVEN
//
//

//SPIN
_rot += _spin_speed;

//DRAW
draw_sprite_ext(spr_transition_spinner,0,x,y,0.75,0.75,_rot,c_white,1);

//FUTURE: PROGRESS BAR BASED ON MILESTONES