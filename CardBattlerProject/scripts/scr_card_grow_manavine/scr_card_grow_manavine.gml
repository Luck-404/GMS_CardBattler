function scr_card_grow_manavine(){
	var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
	_ref_counter.x = 960;
	_ref_counter.y = 50;
	_ref_counter._draw_color = c_aqua;
	_ref_counter._turn_lifespan = 3;
	_ref_counter._reference_script = scr_card_grow_manavine_repeat;
	_ref_counter._target = "None";
	global.max_mana++;
	var _ref_effect = instance_create_layer(room_width/2,room_height/2,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_grow_manavine;
	audio_play_sound(snd_effect_grow_manavine,0,false);
}