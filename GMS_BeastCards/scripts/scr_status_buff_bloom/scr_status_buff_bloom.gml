//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_BLOOM
// FUNCTION: Handles the Bloom buff.
//           Grants 5 temporary Overhealth per stack for 2 turns.
//           Reapplications add a stack and refresh duration.
//           Regenerates up to 5 missing Bloom Overhealth each round.
//           Removes remaining Bloom-granted Overhealth when expired.
//
//===============================================================================//

function scr_status_buff_bloom(_str_tag,_ref_status,_val_magnitude,_val_lifetime){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (_val_magnitude == undefined){
				_val_magnitude = 5;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 2;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_check_for_status("BLOOM",_ref_target);

			//-------------//
			//STACK BLOOM//
			//-------------//
			if (_ref_existing_status != -1){

				_ref_target._val_overhealth += _val_magnitude;

				_ref_existing_status._val_status_remaining += _val_magnitude;

				_ref_existing_status._ct_status_stacks++;

				_ref_existing_status._val_status_lifetime = _val_lifetime;

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

			_ref_new_status._val_status_lifetime =
				_val_lifetime;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._val_status_remaining =
				_val_magnitude;

			_ref_new_status._scr_status =
				scr_status_buff_bloom;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"BLOOM";

			_ref_new_status._str_status_desc =
				"+5 OVERHEALTH PER STACK. REGENERATES 5 BLOOM OVERHEALTH EACH ROUND.";

			_ref_new_status._spr_status =
				spr_status_buff_bloom;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._str_trigger_region =
				"END";

			//----------------//
			//GRANT OVERHEALTH//
			//----------------//
			_ref_target._val_overhealth +=
				_val_magnitude;

			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				_ref_target
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_destroy_status(
					_ref_status
				);

				return undefined;
			}

			//----------------------------//
			//TRACK REMAINING OVERHEALTH//
			//----------------------------//
			_ref_status._val_status_remaining =
				min(
					_ref_status._val_status_remaining,
					_ref_host._val_overhealth
				);

			//-----------------------//
			//GET BLOOM OH CAPACITY//
			//-----------------------//
			var _val_bloom_max =
				_ref_status._val_status_magnitude *
				_ref_status._ct_status_stacks;

			//----------------------------//
			//REGENERATE BLOOM OVERHEALTH//
			//----------------------------//
			var _val_missing_bloom =
				max(
					0,
					_val_bloom_max -
					_ref_status._val_status_remaining
				);

			var _val_regenerated =
				min(
					_ref_status._val_status_magnitude,
					_val_missing_bloom
				);

			if (_val_regenerated > 0){

				_ref_host._val_overhealth +=
					_val_regenerated;

				_ref_status._val_status_remaining +=
					_val_regenerated;

				scr_spawn_popup_scrolling(
					"TEXT",
					"+" + string(_val_regenerated) + " BLOOM",
					undefined,
					c_green,
					_ref_host.x,
					_ref_host.y - 48
				);
			}

			//----------------//
			//REDUCE LIFETIME//
			//----------------//
			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){

				_ref_status._str_status_command =
					"DEATH";
			}
			else{

				_ref_status._str_status_command =
					"WAIT";
			}

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

			if (instance_exists(_ref_host)){

				_ref_host._val_overhealth =
					max(
						0,
						_ref_host._val_overhealth -
						_ref_status._val_status_remaining
					);
			}

			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}