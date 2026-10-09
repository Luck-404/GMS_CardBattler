//===============================================================================//
//
// STEP: OBJ_BATTLE_BEAST
// FUNCTION: Resolves pending Beast death state, staged Beast sprite animation,
//           resurrection animation recovery, and temporary visual motion used for
//           normal casting, Minion-row casting, dodging, repositioning, and resist.
//           Visual motion does not alter the Beast's battlefield slot.
//
//===============================================================================//

#region CHEAT STAT SNAPSHOT

//==================================//
//CAPTURE PRE-CHEAT PERSISTENT STATS//
//==================================//
// _ref_unit is assigned immediately after the battle Beast instance is created.
// Capture on the first Step, before normal battle actions/statuses can mutate it.
if (
	_stct_cheat_stat_original == undefined &&
	is_struct(_ref_unit)
){
	_stct_cheat_stat_original = {
		_val_beast_hp_stat : _ref_unit._val_beast_hp_stat,
		_val_beast_con_stat : _ref_unit._val_beast_con_stat,
		_val_beast_ppow_stat : _ref_unit._val_beast_ppow_stat,
		_val_beast_mpow_stat : _ref_unit._val_beast_mpow_stat,
		_val_beast_pdef_stat : _ref_unit._val_beast_pdef_stat,
		_val_beast_mdef_stat : _ref_unit._val_beast_mdef_stat,
		_val_beast_speed_stat : _ref_unit._val_beast_speed_stat,
		_val_beast_crit_stat : _ref_unit._val_beast_crit_stat,
		_val_beast_crit_dmg_stat : _ref_unit._val_beast_crit_dmg_stat,
		_val_beast_dod_stat : _ref_unit._val_beast_dod_stat,
		_val_beast_min_stat : _ref_unit._val_beast_min_stat
	};
}

#endregion

#region DEATH

//-------------//
//HANDLE DEATH//
//-------------//
if (_val_cur_hp <= 0 && !_flag_death_handled){
	hscr_battle_handle_death();
}

#endregion

#region BEAST SPRITE ANIMATION

//=======================//
//RESURRECTION RECOVERY//
//=======================//
// A resurrected animated Beast must immediately leave its permanent DEATH hold.
// This lifecycle check keeps Cheats and future resurrection paths from needing
// separate animation-specific reset code.
if (
	_val_cur_hp > 0 &&
	scr_beast_animation_ensure(self) &&
	_str_beast_animation_state == "DEATH"
){
	scr_beast_animation_play(self,"IDLE",true);
}

//========================//
//UPDATE MULTI-FRAME STATE//
//========================//
scr_beast_animation_update(self);

#endregion

#region DRAW MOTION

//--------------------//
//RESET DRAW MODIFIERS//
//--------------------//
_val_vfx_offset_x = 0;
_val_vfx_offset_y = 0;
_val_vfx_angle = 0;

//----------------//
//NO ACTIVE MOTION//
//----------------//
if (_str_vfx_motion == "NONE" || _ct_vfx_motion <= 0){

	_str_vfx_motion = "NONE";
	_ct_vfx_motion = 0;

	exit;
}

//----------------//
//DEAD BEAST GUARD//
//----------------//
if (_val_cur_hp <= 0){

	_str_vfx_motion = "NONE";
	_ct_vfx_motion = 0;

	exit;
}

//------------------//
//ANIMATION PROGRESS//
//------------------//
var _val_motion_progress = 1 - (_ct_vfx_motion / max(1,_ct_vfx_motion_duration));

//-------------//
//UPDATE MOTION//
//-------------//
switch(_str_vfx_motion){

	//-----------//
	//NORMAL CAST//
	//-----------//
	case "CAST":

		//----------------//
		//CAST DIRECTION//
		//----------------//
		var _val_direction = (_str_team == "PLAYER") ? 1 : -1;

		_val_vfx_offset_x =
			sin(_val_motion_progress * pi) *
			_val_vfx_motion_intensity *
			_val_direction;

	break;

	//----------------//
	//MINION-ROW CAST//
	//----------------//
	case "CAST_MINION":

		_val_vfx_offset_y =
			sin(_val_motion_progress * pi) *
			_val_vfx_motion_intensity;

	break;

	//-------//
	//DODGE//
	//-------//
	case "DODGE":

		//--------------//
		//DODGE MOTION//
		//--------------//
		_val_vfx_offset_x =
			sin(_val_motion_progress * pi * 4) *
			_val_vfx_motion_intensity;

	break;

	//----------//
	//REPOSITION//
	//----------//
	case "REPOSITION":

		//--------------------//
		//REPOSITION PROGRESS//
		//--------------------//
		var _val_reposition_progress =
			1 -
			(
				(_ct_vfx_motion - 1) /
				max(1,_ct_vfx_motion_duration - 1)
			);

		//---------------//
		//SMOOTH EASING//
		//---------------//
		var _val_reposition_ease =
			_val_reposition_progress *
			_val_reposition_progress *
			(3 - (2 * _val_reposition_progress));

		//----------------//
		//LERP TO NEW SLOT//
		//----------------//
		_val_vfx_offset_x = lerp(_val_vfx_motion_start_x,0,_val_reposition_ease);

	break;

	//------//
	//RESIST//
	//------//
	case "RESIST":

		//---------------//
		//RESIST MOTION//
		//---------------//
		_val_vfx_angle =
			sin(_val_motion_progress * pi * 4) *
			_val_vfx_motion_intensity;

	break;
}

//---------//
//COUNTDOWN//
//---------//
_ct_vfx_motion--;

#endregion
