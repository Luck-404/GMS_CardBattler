//===============================================================================//
//
// DRAW GUI END: OBJ_BATTLE_CARD
// FUNCTION: Draws the enlarged battle Card preview above other GUI elements.
//           Ensures hovered Card inspection remains visually on top.
//
// USES:     _spr_preview_card and _val_preview_scale set during Draw GUI.
//
//===============================================================================//

#region CARD PREVIEW

//------------//
//CARD PREVIEW//
//------------//
if (_spr_preview_card != undefined){

	draw_sprite_ext(
		_spr_preview_card,
		0,
		room_width * 0.5,
		room_height * 0.5,
		_val_preview_scale,
		_val_preview_scale,
		0,
		c_white,
		1
	);
}

#endregion