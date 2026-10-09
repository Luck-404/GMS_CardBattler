//===============================================================================//
//
// SCRIPT: SCR_BEAST_SOUND_CONTROL
// FUNCTION: Shared staged per-Beast sound resolver/player.
//           Accepts a persistent Beast struct or a live Beast/Ranch instance,
//           resolves its Beast name and requested sound, applies the independent
//           SCR_BEAST_SOUND_IS_VALID rollout gate, and plays only completed sounds.
//
//           SOUND TYPES:
//           CRY      - species vocalization / announcement.
//           DEATH    - finalized battle death vocalization.
//           INTERACT - short selection/interaction feedback.
//
//===============================================================================//

function scr_beast_sound_get_name(_var_source){

	if (_var_source == undefined){
		return "";
	}

	if (is_struct(_var_source)){

		if (variable_struct_exists(_var_source,"_str_beast_name")){
			return string_upper(string(_var_source._str_beast_name));
		}

		return "";
	}

	if (!instance_exists(_var_source)){
		return "";
	}

	if (
		variable_instance_exists(_var_source,"_ref_unit") &&
		is_struct(_var_source._ref_unit) &&
		variable_struct_exists(_var_source._ref_unit,"_str_beast_name")
	){
		return string_upper(string(_var_source._ref_unit._str_beast_name));
	}

	if (
		variable_instance_exists(_var_source,"_stct_unit") &&
		is_struct(_var_source._stct_unit) &&
		variable_struct_exists(_var_source._stct_unit,"_str_beast_name")
	){
		return string_upper(string(_var_source._stct_unit._str_beast_name));
	}

	if (variable_instance_exists(_var_source,"_str_beast_name")){
		return string_upper(string(_var_source._str_beast_name));
	}

	return "";
}

//-------------------------------------------------------------------------------//
// SCR_BEAST_SOUND_GET
// RETURNS: Requested valid sound asset, or undefined when unavailable/invalid.
//-------------------------------------------------------------------------------//
function scr_beast_sound_get(_var_source,_str_sound_type){

	var _str_beast_name = scr_beast_sound_get_name(_var_source);

	if (
		_str_beast_name == "" ||
		!scr_beast_sound_is_valid(_str_beast_name)
	){
		return undefined;
	}

	_str_sound_type = string_upper(string(_str_sound_type));

	// CRY and INTERACT belong to living Beasts. DEATH is the only staged Beast
	// sound allowed after HP reaches 0. This prevents dead Party/Ranch-pane entries
	// from vocalizing merely because the player clicked them.
	if (_str_sound_type != "DEATH"){

		if (
			is_struct(_var_source) &&
			variable_struct_exists(_var_source,"_val_beast_hp_cur") &&
			_var_source._val_beast_hp_cur <= 0
		){
			return undefined;
		}

		if (
			!is_struct(_var_source) &&
			instance_exists(_var_source) &&
			variable_instance_exists(_var_source,"_val_cur_hp") &&
			_var_source._val_cur_hp <= 0
		){
			return undefined;
		}
	}

	var _stct_unit = undefined;
	var _ref_instance = noone;

	if (is_struct(_var_source)){
		_stct_unit = _var_source;
	}
	else if (instance_exists(_var_source)){

		_ref_instance = _var_source;

		if (
			variable_instance_exists(_ref_instance,"_ref_unit") &&
			is_struct(_ref_instance._ref_unit)
		){
			_stct_unit = _ref_instance._ref_unit;
		}
		else if (
			variable_instance_exists(_ref_instance,"_stct_unit") &&
			is_struct(_ref_instance._stct_unit)
		){
			_stct_unit = _ref_instance._stct_unit;
		}
	}

	//========================//
	//PERSISTENT BEAST STRUCT//
	//========================//
	if (is_struct(_stct_unit)){

		switch (_str_sound_type){

			case "CRY":
				if (
					variable_struct_exists(_stct_unit,"_snd_beast_cry") &&
					_stct_unit._snd_beast_cry != undefined
				){
					return _stct_unit._snd_beast_cry;
				}
			break;

			case "DEATH":
				if (
					variable_struct_exists(_stct_unit,"_snd_beast_death") &&
					_stct_unit._snd_beast_death != undefined
				){
					return _stct_unit._snd_beast_death;
				}
			break;

			case "INTERACT":
				if (
					variable_struct_exists(_stct_unit,"_snd_beast_interact") &&
					_stct_unit._snd_beast_interact != undefined
				){
					return _stct_unit._snd_beast_interact;
				}
			break;
		}
	}

	//===========================//
	//INSTANCE-CACHED COMPATIBILITY//
	//===========================//
	// Ranch dummies do not retain the full persistent Beast struct, so CRY/DEATH
	// may still resolve through their existing cached fields.
	if (instance_exists(_ref_instance)){

		switch (_str_sound_type){

			case "CRY":
				if (
					variable_instance_exists(_ref_instance,"_snd_cry") &&
					_ref_instance._snd_cry != undefined
				){
					return _ref_instance._snd_cry;
				}
			break;

			case "DEATH":
				if (
					variable_instance_exists(_ref_instance,"_snd_death") &&
					_ref_instance._snd_death != undefined
				){
					return _ref_instance._snd_death;
				}
			break;

			case "INTERACT":
				if (
					variable_instance_exists(_ref_instance,"_snd_interact") &&
					_ref_instance._snd_interact != undefined
				){
					return _ref_instance._snd_interact;
				}
			break;
		}
	}

	return undefined;
}

//-------------------------------------------------------------------------------//
// SCR_BEAST_SOUND_PLAY
// RETURNS: True when a valid Beast-specific sound was played.
//-------------------------------------------------------------------------------//
function scr_beast_sound_play(_var_source,_str_sound_type,_val_priority=0){

	var _snd_beast = scr_beast_sound_get(_var_source,_str_sound_type);

	if (_snd_beast == undefined){
		return false;
	}

	audio_play_sound(
		_snd_beast,
		_val_priority,
		false
	);

	return true;
}
