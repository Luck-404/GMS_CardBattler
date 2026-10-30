//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_TREASURE_CHEST
// FUNCTION: Draws the treasure chest and ground shadow.
//           Shows interaction feedback while the player is nearby.
//           World Event overhead labels are drawn separately in Draw GUI.
//           Input, proximity audio, and loot resolution are handled in Step.
//
//===============================================================================//

//================//
//DRAW SCALE//
//================//
var _val_draw_scale = 1;

if (
	variable_instance_exists(
		self,
		"_val_world_event_chest_scale"
	)
){
	_val_draw_scale =
		max(
			0.01,
			_val_world_event_chest_scale
		);
}

//================//
//DRAW CHEST//
//================//
draw_sprite_ext(
	spr_overworld_decor_shadow,
	0,
	x,
	y,
	0.3 * _val_draw_scale,
	0.3 * _val_draw_scale,
	0,
	_c_chest,
	1
);

draw_sprite_ext(
	spr_overworld_treasure_chest,
	image_index,
	x,
	y,
	_val_draw_scale,
	_val_draw_scale,
	0,
	_c_chest,
	1
);

//================//
//OPENED STATE//
//================//
if (_flag_triggered){

	image_index = 1;

	return;
}

//================//
//INTERACTION HIGHLIGHT//
//================//
if (
	instance_exists(obj_player) &&
	distance_to_object(obj_player) < 48 &&
	!global.flag_pause
){

	draw_sprite_ext(
		spr_overworld_treasure_chest_highlight,
		0,
		x,
		y,
		_val_draw_scale,
		_val_draw_scale,
		0,
		c_white,
		1
	);
}
