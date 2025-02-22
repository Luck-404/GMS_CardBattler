depth = -100;
_exit_hover = false;
_hover = false;

image_index	= 0;
image_speed = 0;

_mx = device_mouse_x_to_gui(0);
_my = device_mouse_y_to_gui(0);

//CREATE BUTTONS
instance_create_layer(x+150,y-270,"GUI",obj_gui_load_close_button);//close
scr_get_saves();

if (instance_exists(obj_passer)){
	with(obj_passer){
		instance_destroy(obj_passer);	
	}
}

_ref_passer = instance_create_layer(0,0,"GUI",obj_passer);
