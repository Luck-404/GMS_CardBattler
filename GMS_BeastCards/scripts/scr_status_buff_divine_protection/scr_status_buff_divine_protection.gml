//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_DIVINE_PROTECTION
// FUNCTION: Handles Divine Protection.
//           Stackable Infinite Buff.
//           Each stack blocks one incoming Attack damage instance.
//           Remains active until all stacks are consumed.
//
//===============================================================================//

function scr_status_buff_divine_protection(_str_tag,_ref_status,_ct_stacks_added=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//----------//
			//DEFAULTS//
			//----------//
			if (_ct_stacks_added == undefined){
				_ct_stacks_added = 1;
			}

			_ct_stacks_added = max(1,_ct_stacks_added);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("DIVINE_PROTECTION",_ref_target);

			//----------------//
			//STACK EXISTING//
			//----------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks += _ct_stacks_added;

				//--------------------//
				//APPLICATION EFFECT//
				//--------------------//
				scr_battle_vfx(
					_ref_target,
					spr_battle_vfx_protection,
					undefined,
					undefined,
					0,
					0,
					1,
					0,
					snd_battle_protection
				);

				//-----------------------//
				//ENSURE PERSISTENT VFX//
				//-----------------------//
				if (!instance_exists(_ref_existing_status._ref_persistent_vfx)){

					_ref_existing_status._ref_persistent_vfx = scr_battle_vfx_persistent(
						_ref_target,
						spr_battle_vfx_protected,
						0,
						-40,
						1
					);
				}

				scr_status_reposition(_ref_target);

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//-------------------//
			//INFINITE LIFETIME//
			//-------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_divine_protection;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "DIVINE_PROTECTION";
			_ref_new_status._str_status_desc = "EACH STACK BLOCKS 1 ATTACK DAMAGE INSTANCE";

			_ref_new_status._spr_status = spr_status_buff_divine_protection;

			_ref_new_status._ct_status_stacks = _ct_stacks_added;
			_ref_new_status._flag_status_stackable = true;

			_ref_new_status._str_trigger_region = undefined;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			//--------------------//
			//APPLICATION EFFECT//
			//--------------------//
			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_protection,
				undefined,
				undefined,
				0,
				0,
				1,
				0,
				snd_battle_protection
			);

			//----------------//
			//PERSISTENT VFX//
			//----------------//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent(
				_ref_target,
				spr_battle_vfx_protected,
				0,
				-40,
				1
			);

			return _ref_new_status;

		break;

		//=========//
		//CONSUME//
		//=========//
		case "CONSUME":

			if (!instance_exists(_ref_status)){
				return false;
			}

			if (_ref_status._ct_status_stacks <= 0){
				return false;
			}

			_ref_status._ct_status_stacks--;

			//------------------//
			//REMOVE LAST STACK//
			//------------------//
			if (_ref_status._ct_status_stacks <= 0){

				scr_status_buff_divine_protection(
					"DEATH",
					_ref_status
				);

				return true;
			}

			//----------------------//
			//REFRESH STATUS ICONS//
			//----------------------//
			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){
				scr_status_reposition(_ref_host);
			}

			return true;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}