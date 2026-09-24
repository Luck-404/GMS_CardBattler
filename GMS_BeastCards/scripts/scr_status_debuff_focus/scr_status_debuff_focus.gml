
//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_FOCUS
// FUNCTION: Handles the Focus Debuff.
//           Unstackable Timed Debuff.
//           Only one Beast per team may have Focus at a time.
//           Applying Focus to another teammate replaces the previous Focus.
//           Reapplication to the same host refreshes duration.
//           Opposing Minions prioritize the affected Beast.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Status reference or undefined.
//
//===============================================================================//

function scr_status_debuff_focus(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

	var _ref_focus = undefined;

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//================//
			//VALIDATE TARGET//
			//================//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime = max(1,_val_lifetime);

			//================//
			//GET TARGET TEAM//
			//================//
			var _list_team = scr_battle_get_target_team_list(
				_ref_target
			);

			if (
				_list_team == undefined ||
				!ds_exists(_list_team,ds_type_list)
			){
				return undefined;
			}

			//================//
			//CHECK OWN FOCUS//
			//================//
			var _ref_existing_status = scr_status_check(
				"FOCUS",
				_ref_target
			);

			//================//
			//REFRESH EXISTING//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//------------------//
				//REFRESH LIFETIME//
				//------------------//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//-----------------------//
				//ENSURE PERSISTENT VFX//
				//-----------------------//
				if (!instance_exists(_ref_existing_status._ref_persistent_vfx)){

					_ref_existing_status._ref_persistent_vfx = scr_battle_vfx_persistent(
						_ref_target,
						spr_battle_vfx_focus,
						0,
						0,
						1
					);
				}

				// Use this existing Status.
				_ref_focus = _ref_existing_status;
			}
			else{

				//===============//
				//CREATE STATUS//
				//===============//
				_ref_focus = instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

				if (!instance_exists(_ref_focus)){
					return undefined;
				}

				//---------------------//
				//INITIALIZE LIFETIME//
				//---------------------//
				scr_status_init_lifetime(
					_ref_focus,
					_val_lifetime,
					false,
					false
				);

				//-------------//
				//STATUS DATA//
				//-------------//
				_ref_focus._scr_status = scr_status_debuff_focus;

				_ref_focus._ref_host = _ref_target;

				_ref_focus._str_status_type = "DEBUFF";
				_ref_focus._str_status_name = "FOCUS";

				_ref_focus._str_status_desc =
					"OPPOSING MINIONS PRIORITIZE THIS BEAST";

				_ref_focus._spr_status = spr_status_debuff_focus;

				_ref_focus._ct_status_stacks = 1;
				_ref_focus._flag_status_stackable = false;

				_ref_focus._str_trigger_region = "END";

				//----------------//
				//REGISTER STATUS//
				//----------------//
				ds_list_add(
					_ref_target._list_statuses,
					_ref_focus
				);

				//----------------//
				//PERSISTENT VFX//
				//----------------//
				_ref_focus._ref_persistent_vfx = scr_battle_vfx_persistent(
					_ref_target,
					spr_battle_vfx_focus,
					0,
					0,
					1
				);
			}

			//========================//
			//REMOVE OTHER TEAM FOCUS//
			//========================//
			// The new or refreshed Focus is established first.
			// Remove Focus from every other Beast on this team.

			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_team);
				_it_beast++
			){

				var _ref_beast = ds_list_find_value(
					_list_team,
					_it_beast
				);

				if (
					!instance_exists(_ref_beast) ||
					_ref_beast == _ref_target
				){
					continue;
				}

				var _ref_old_focus = scr_status_check(
					"FOCUS",
					_ref_beast
				);

				if (
					_ref_old_focus != -1 &&
					instance_exists(_ref_old_focus)
				){

					scr_status_debuff_focus(
						"DEATH",
						_ref_old_focus
					);
				}
			}

			//------------------//
			//REPOSITION STATUS//
			//------------------//
			scr_status_reposition(_ref_target);

			return _ref_focus;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_status_destroy(_ref_status);

				return undefined;
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			scr_status_reposition(_ref_host);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_status_destroy(_ref_status);
			}

		break;
	}

	return undefined;
}