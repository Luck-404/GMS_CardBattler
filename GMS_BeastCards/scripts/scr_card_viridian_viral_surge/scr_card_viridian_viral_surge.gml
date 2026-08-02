//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VIRAL_SURGE
// FUNCTION: Resolves the Viral Surge card effect.
//           Doubles the stack count of every active DoT on the target.
//           Uses each DoT's existing APPLY logic so stack-based side effects
//           are also applied correctly.
//
//===============================================================================//

function scr_card_viridian_viral_surge(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_target)){
		return;
	}

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target = global.ref_target_beast;

	global.ref_target_beast = _ref_target;

	//------------------//
	//DOUBLE ALL DOTS//
	//------------------//
	for (
		var _it_status = 0;
		_it_status < ds_list_size(_ref_target._list_statuses);
		_it_status++
	){

		var _ref_status = ds_list_find_value(
			_ref_target._list_statuses,
			_it_status
		);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "DOT"){
			continue;
		}

		if (_ref_status._scr_status == undefined){
			continue;
		}

		//-----------------------//
		//SNAPSHOT CURRENT STATE//
		//-----------------------//
		var _ct_stacks_original =
			_ref_status._ct_status_stacks;

		var _val_lifetime_original =
			_ref_status._val_status_lifetime;

		//-----------------//
		//ADD SAME # STACKS//
		//-----------------//
		repeat (_ct_stacks_original){

			script_execute(
				_ref_status._scr_status,
				"APPLY",
				undefined
			);
		}

		//------------------//
		//PRESERVE LIFETIME//
		//------------------//
		if (instance_exists(_ref_status)){
			_ref_status._val_status_lifetime =
				_val_lifetime_original;
		}
	}

	//-----------------------//
	//RESTORE ORIGINAL TARGET//
	//-----------------------//
	if (instance_exists(_ref_original_target)){
		global.ref_target_beast = _ref_original_target;
	}
	else{
		global.ref_target_beast = _ref_target;
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}