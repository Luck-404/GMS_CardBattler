//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_BLOOMING_SPRITE
// FUNCTION: Handles the Blooming Sprite buff.
//           Grants the host linear damage equal to the source minion's magnitude.
//           Remains active only while that exact Blooming Sprite exists.
//
//===============================================================================//

function scr_status_buff_blooming_sprite(_str_tag,_ref_status,_ref_source_minion){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			if (!instance_exists(_ref_source_minion)){
				return undefined;
			}

			var _ref_target =
				_ref_source_minion._ref_host;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//--------------------------------//
			//CHECK THIS EXACT SOURCE MINION//
			//--------------------------------//
			for (
				var _it_status = 0;
				_it_status < ds_list_size(_ref_target._list_statuses);
				_it_status++
			){

				var _ref_existing_status =
					ds_list_find_value(
						_ref_target._list_statuses,
						_it_status
					);

				if (!instance_exists(_ref_existing_status)){
					continue;
				}

				if (
					_ref_existing_status._str_status_name ==
					"BLOOMING SPRITE" &&
					_ref_existing_status._ref_source_minion ==
					_ref_source_minion
				){

					return _ref_existing_status;
				}
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

			_ref_new_status._val_status_lifetime = -1;

			_ref_new_status._scr_status =
				scr_status_buff_blooming_sprite;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._ref_source_minion =
				_ref_source_minion;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"BLOOMING SPRITE";

			_ref_new_status._val_status_magnitude =
				_ref_source_minion._val_magnitude;

			_ref_new_status._str_status_desc =
				"+" +
				string(
					_ref_new_status._val_status_magnitude
				) +
				" LINEAR DAMAGE WHILE BLOOMING SPRITE LIVES";

			_ref_new_status._spr_status =
				spr_status_buff_blooming_sprite;

			_ref_new_status._ct_status_stacks = 1;

			// SOURCE-LINKED; DOES NOT TICK
			_ref_new_status._str_trigger_region =
				undefined;

			//--------------------//
			//GRANT DAMAGE BONUS//
			//--------------------//
			_ref_target._val_dmg_linear_bonus +=
				_ref_new_status._val_status_magnitude;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				_ref_target
			);

			return _ref_new_status;

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			//--------------------//
			//REMOVE DAMAGE BONUS//
			//--------------------//
			if (instance_exists(_ref_host)){

				_ref_host._val_dmg_linear_bonus -=
					_ref_status._val_status_magnitude;

				_ref_host._val_dmg_linear_bonus =
					max(
						0,
						_ref_host._val_dmg_linear_bonus
					);
			}

			//----------------//
			//REMOVE STATUS//
			//----------------//
			if (instance_exists(_ref_host)){

				var _it_status =
					ds_list_find_index(
						_ref_host._list_statuses,
						_ref_status
					);

				if (_it_status != -1){

					ds_list_delete(
						_ref_host._list_statuses,
						_it_status
					);
				}

				instance_destroy(
					_ref_status
				);

				scr_reposition_statuses(
					_ref_host
				);
			}
			else{

				instance_destroy(
					_ref_status
				);
			}

		break;
	}

	return undefined;
}