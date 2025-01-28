if (place_meeting(x,y,obj_player) && !instance_exists(obj_zone_banner) && _flag_triggered == false){
	//reset all other triggers
	with (obj_banner_trigger){
		_flag_triggered = false;	
	}
	//trigger this one
	_flag_triggered = true;
	show_debug_message("Triggering, will create a banner with " + string(self._color) + " " + self._text);
	audio_play_sound(snd_effect_echoing,0,false);
    // Calculate the direction the player is coming from
    var _player_dir = get_direction_from_player(obj_player.x, obj_player.y, x, y);

    // Optional: Check if it matches the required direction
    if ((_req_dir == "Any") || (_player_dir == _req_dir)) { // Example: Only trigger from below
         //Spawn the banner
        var _ref_banner = instance_create_layer(room_width/2, 200, "GUI", obj_zone_banner);
		_ref_banner._ban_color = self._color;
		_ref_banner._ban_text = self._text;
	}
}