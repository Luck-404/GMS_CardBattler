//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_CINDERGUARD
// FUNCTION: Handles Cinderguard.
//           Stackable Infinite Buff.
//           Each stack represents one reactive charge.
//           The next enemy that directly damages the host gains 1 Burn and
//           consumes one Cinderguard stack.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined, _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_cinderguard(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


			//----------------//
			//VALIDATE TARGET//
			//----------------//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_magnitude == undefined){
				_val_magnitude = 1;
			}

			var _ct_charges = max(1,floor(_val_magnitude));

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check("CINDERGUARD",_ref_target);

			//================//
			//ADD CHARGES//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks += _ct_charges;

				scr_status_reposition(_ref_target);
				
				//-----------------------//
				//ENSURE PERSISTENT VFX//
				//-----------------------//
				if (!instance_exists(_ref_existing_status._ref_persistent_vfx)){

					_ref_existing_status._ref_persistent_vfx = scr_battle_vfx_persistent(
						_ref_target,
						spr_battle_vfx_thorns,
						0,
						-65,
						1
					);
				}
				
				return _ref_existing_status;
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//=====================//
			//INFINITE LIFETIME//
			//=====================//
			scr_status_init_lifetime(_ref_new_status,-1,true,true);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_cinderguard;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "CINDERGUARD";
			
_ref_new_status._str_status_desc =
	"WHEN AN ENEMY ATTACK DAMAGES THIS BEAST, CONSUME 1 CHARGE TO APPLY 1 BURN TO THE ATTACKER";

			_ref_new_status._spr_status = spr_status_buff_thorns;

			_ref_new_status._ct_status_stacks = _ct_charges;

			_ref_new_status._str_trigger_region = undefined;

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_status_reposition(_ref_target);
			
			//----------------//
			//PERSISTENT VFX//
			//----------------//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent(
				_ref_target,
				spr_battle_vfx_thorns,
				0,
				-65,
				1
			);
			
			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			if (instance_exists(_ref_status._ref_host)){
				scr_status_reposition(_ref_status._ref_host);
			}

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
