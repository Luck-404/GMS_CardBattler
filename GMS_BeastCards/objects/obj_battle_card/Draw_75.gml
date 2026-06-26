//===============================================================================//
//
// CARD PREVIEW
// FUNCTION: Draws an enlarged preview of the hovered battle card
//           while the preview key is held.
//
//===============================================================================//
#region CARD PREVIEW
if (_spr_preview_card != undefined){
	draw_sprite_ext(
		_spr_card,
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