//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ANCHOR_STONE
// FUNCTION: Handles one Anchor Stone's Immovable contribution.
//           Each status belongs to one exact source Minion.
//           Multiple Anchor Stones and other reposition locks coexist.
//
//===============================================================================//

function scr_status_buff_anchor_stone(
	_str_tag,
	_ref_status,
	_ref_source_minion=undefined,
	_ref_target=undefined
){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			if (!instance_exists(_ref_source_minion)){
				return undefined;
			}

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
					_ref_existing_status._str_status_name !=
					"ANCHOR_STONE"
				){
					continue;
				}

				if (
					_ref_existing_status._ref_source_minion !=
					_ref_source_minion
				){
					continue;
				}

				return _ref_existing_status;
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

			//---------------------//
			//INFINITE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status =
				scr_status_buff_anchor_stone;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._ref_source_minion =
				_ref_source_minion;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"ANCHOR_STONE";

			_ref_new_status._str_status_desc =
				"IMMOVABLE WHILE SOURCE ANCHOR STONE LIVES";

			/*
				Use the same sprite as your existing
				generic Immovable Buff here.
			*/
			_ref_new_status._spr_status =
				spr_status_buff_anchor_stone;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._flag_status_uncleansable =
				true;

			_ref_new_status._flag_status_prevent_reposition =
				true;

			_ref_new_status._flag_status_requires_live_source_minion =
				true;

			_ref_new_status._str_trigger_region =
				undefined;

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

			if (instance_exists(_ref_status)){
				scr_destroy_status(_ref_status);
			}

		break;
	}

	return undefined;
}