if (_turn_lifespan == 0){
	_reference_script(_target,false);
	instance_destroy();
}

if (_reference_script != undefined && _trigger_my_effect == true){
	_reference_script(_target,true);
	_trigger_my_effect = false;
}

draw_set_color(_draw_color);
draw_text(x,y,string(_turn_lifespan));
draw_set_color(c_white);