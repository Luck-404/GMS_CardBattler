//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_CLEARCAST
// FUNCTION: Resolves the Clearcast card effect.
//           Removes all active WEATHER statuses.
//           Runs each Weather status's normal death/cleanup behavior.
//           Plays the associated animation, sound, and popup effects.
//
//===============================================================================//
function scr_card_uncolored_clearcast(_stct_card,_ref_caster,_ref_target){

	//---------------------//
	//REMOVE ACTIVE WEATHER//
	//---------------------//
	for (
		var _it_status = ds_list_size(global.list_statuses) - 1;
		_it_status >= 0;
		_it_status--
	){

		var _ref_status = ds_list_find_value(
			global.list_statuses,
			_it_status
		);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "WEATHER"){
			continue;
		}

		//----------------------//
		//RUN WEATHER CLEANUP//
		//----------------------//
		if (_ref_status._scr_status != undefined){
			_ref_status._scr_status(
				"DEATH",
				_ref_status
			);
		}
		else{
			scr_destroy_status(_ref_status);
		}
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
	
	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"WEATHER CLEARED",
		undefined,
		c_black,
		room_width / 2 - 300,
		room_height / 2
	);
}