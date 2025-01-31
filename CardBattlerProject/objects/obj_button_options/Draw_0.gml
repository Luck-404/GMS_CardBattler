//highlight if selected
if (_selected){
	image_index = 1;
}
else {
	image_index = 0;
}
draw_self();

if (global.gui_open && _selected == true){
	draw_sprite(spr_mm_darken,0,0,0);
}