//===============================================================================//
//
// SCRIPT: SCR_GUI_SPAWN_POPUP_TRIGGER_BANNER
// FUNCTION: Creates a stacked GUI trigger banner.
//           Displays the owning Beast in the banner's top-right corner.
//           Optionally appends the Beast that activated the effect.
//           Supports Items, Abilities, Traps, and other Beast-owned triggers.
//
// ARGUMENTS:
//     _str_text      - Main trigger text.
//     _ref_owner     - Optional Beast that owns/caused the effect.
//     _ref_triggerer - Optional Beast whose action/event activated the effect.
//
// RETURNS: Created trigger-banner instance.
//
//===============================================================================//

function scr_gui_spawn_popup_trigger_banner(
	_str_text,
	_ref_owner=undefined,
	_ref_triggerer=undefined
){

	//================//
	//STACK SERIAL//
	//================//
	static _val_next_stack_order = 0;

	//================//
	//CREATE BANNER//
	//================//
	var _ref_banner =
		instance_create_layer(
			0,
			0,
			"ily_fx",
			obj_gui_popup_trigger_banner
		);

	//================//
	//ASSIGN TEXT//
	//================//
	_ref_banner._str_text =
		string(_str_text);

	//================//
	//ASSIGN STACK ORDER//
	//================//
	_ref_banner._val_stack_order =
		_val_next_stack_order;

	_val_next_stack_order++;

	//================//
	//DEFAULT OWNER//
	//================//
	_ref_banner._str_owner = "";

	//================================//
	//FALLBACK TO ACTIVE CARD CASTER//
	//================================//
	if (
		!instance_exists(_ref_owner) &&
		variable_global_exists("ref_caster_beast") &&
		instance_exists(global.ref_caster_beast)
	){
		_ref_owner =
			global.ref_caster_beast;
	}

	#region OWNER

	//================//
	//RESOLVE OWNER//
	//================//
	if (instance_exists(_ref_owner)){

		var _str_owner_team = "";
		var _str_owner_name = "";

		//----------//
		//GET TEAM//
		//----------//
		if (
			variable_instance_exists(
				_ref_owner,
				"_str_team"
			)
		){

			_str_owner_team =
				string_upper(
					string(
						_ref_owner._str_team
					)
				);
		}

		//===============//
		//GET BEAST NAME//
		//===============//
		if (
			variable_instance_exists(
				_ref_owner,
				"_ref_unit"
			) &&
			is_struct(
				_ref_owner._ref_unit
			) &&
			variable_struct_exists(
				_ref_owner._ref_unit,
				"_str_beast_name"
			)
		){

			_str_owner_name =
				string_upper(
					string(
						_ref_owner
							._ref_unit
							._str_beast_name
					)
				);
		}

		//----------------//
		//DIRECT FALLBACK//
		//----------------//
		else if (
			variable_instance_exists(
				_ref_owner,
				"_str_beast_name"
			)
		){

			_str_owner_name =
				string_upper(
					string(
						_ref_owner._str_beast_name
					)
				);
		}

		//================//
		//BUILD OWNER TEXT//
		//================//
		if (
			_str_owner_team != "" &&
			_str_owner_name != ""
		){

			_ref_banner._str_owner =
				_str_owner_team +
				"-" +
				_str_owner_name;
		}
		else if (_str_owner_name != ""){

			_ref_banner._str_owner =
				_str_owner_name;
		}
		else if (_str_owner_team != ""){

			_ref_banner._str_owner =
				_str_owner_team;
		}
	}

	#endregion

	#region TRIGGERER

	//==================//
	//RESOLVE TRIGGERER//
	//==================//
	if (
		instance_exists(_ref_triggerer) &&
		_ref_triggerer != _ref_owner
	){

		var _str_trigger_team = "";
		var _str_trigger_name = "";

		//----------//
		//GET TEAM//
		//----------//
		if (
			variable_instance_exists(
				_ref_triggerer,
				"_str_team"
			)
		){

			_str_trigger_team =
				string_upper(
					string(
						_ref_triggerer._str_team
					)
				);
		}

		//===============//
		//GET BEAST NAME//
		//===============//
		if (
			variable_instance_exists(
				_ref_triggerer,
				"_ref_unit"
			) &&
			is_struct(
				_ref_triggerer._ref_unit
			) &&
			variable_struct_exists(
				_ref_triggerer._ref_unit,
				"_str_beast_name"
			)
		){

			_str_trigger_name =
				string_upper(
					string(
						_ref_triggerer
							._ref_unit
							._str_beast_name
					)
				);
		}

		//----------------//
		//DIRECT FALLBACK//
		//----------------//
		else if (
			variable_instance_exists(
				_ref_triggerer,
				"_str_beast_name"
			)
		){

			_str_trigger_name =
				string_upper(
					string(
						_ref_triggerer._str_beast_name
					)
				);
		}

		//====================//
		//BUILD TRIGGERER TEXT//
		//====================//
		var _str_triggerer = "";

		if (
			_str_trigger_team != "" &&
			_str_trigger_name != ""
		){

			_str_triggerer =
				_str_trigger_team +
				"-" +
				_str_trigger_name;
		}
		else if (_str_trigger_name != ""){

			_str_triggerer =
				_str_trigger_name;
		}
		else if (_str_trigger_team != ""){

			_str_triggerer =
				_str_trigger_team;
		}

		//====================//
		//APPEND TO MAIN TEXT//
		//====================//
		if (_str_triggerer != ""){

			_ref_banner._str_text +=
				"\nTRIGGERED BY: " +
				_str_triggerer;
		}
	}

	#endregion

	return _ref_banner;
}