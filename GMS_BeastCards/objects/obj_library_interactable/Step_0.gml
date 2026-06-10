//
//
// STEP: OBJ_library_GUI_INTERACTABLE | WHEN CLOSE TO PLAYER HIGHLIGHT AND ALLOW CLICK TO SUMMON THE GUI PANE
//
//

#region PROXIMITY TO PLAYER
if (distance_to_object(obj_player) < 48 && global.pause == false){
    image_index = 1;

    if (!_flag_triggered && _cooldown == 0){
        if (keyboard_check(ord("E"))){
			//COOLDOWN
            _flag_triggered = true;
            _cooldown = 60;

			//SPAWN NEW GUI
            var _library_gui = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_gui_library_pane);

			//SETTING UP NEW GUI
            obj_gui_controller.scr_destroy_gui_open();
			global.pause = true;
			obj_gui_controller.scr_toggle_gui_pause();	
            global.active_gui = _library_gui;
        }
    }
}
else{
    image_index = 0;
}
#endregion

#region CLICK COOLDOWNS
if (_cooldown > 0){
    _cooldown--;

    if (_cooldown <= 0){
        _cooldown = 0;
        _flag_triggered = false;
    }
}
#endregion