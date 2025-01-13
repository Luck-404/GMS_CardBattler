///////////////////
// DISPLAY STEPS //
///////////////////
if (room == rm_overworld){
	
	draw_set_color(c_white);
	draw_set_font(fnt_fanwood);
	draw_text(32,96,"Steps: " + string(global.steps));
	draw_text(32,128, "Can Encounter: " + string(global.can_encounter));

}