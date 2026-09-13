//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_BLOOM
// FUNCTION: Handles Bloom.
//           Stackable Timed Buff.
//           Each stack grants one stored Magnitude of temporary Overhealth.
//           Reapplication adds one stack and refreshes duration.
//           Regenerates up to one stack worth of Bloom Overhealth each round.
//           Removes remaining Status-owned Overhealth on expiration.
//
//===============================================================================//

function scr_status_buff_bloom(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined){

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
			if (_val_magnitude == undefined){
				_val_magnitude = 5;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 2;
			}

			_val_magnitude = max(0,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("BLOOM",_ref_target);

			//-------------//
			//STACK BLOOM//
			//-------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				/*
					Bloom owns one common per-stack Magnitude.
					New stacks use the existing Status's stored
					Magnitude rather than replacing it.
				*/
				var _val_stack_amount = _ref_existing_status._val_status_magnitude;

				_ref_target._val_overhealth += _val_stack_amount;
				_ref_existing_status._val_status_remaining += _val_stack_amount;
				_ref_existing_status._ct_status_stacks++;

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				_ref_existing_status._str_status_desc =
					"+" +
					string(_val_stack_amount) +
					" OVERHEALTH PER STACK | REGENERATES " +
					string(_val_stack_amount) +
					" BLOOM EACH ROUND";

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

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				true,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_bloom;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "BLOOM";

			_ref_new_status._str_status_desc =
				"+" +
					string(_val_magnitude) +
					" OVERHEALTH PER STACK | REGENERATES " +
					string(_val_magnitude) +
					" BLOOM EACH ROUND";

			_ref_new_status._spr_status = spr_status_buff_bloom;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = true;

			_ref_new_status._val_status_magnitude = _val_magnitude;
			_ref_new_status._val_status_remaining = _val_magnitude;

			_ref_new_status._str_trigger_region = "END";

			//----------------//
			//GRANT OVERHEALTH//
			//----------------//
			_ref_target._val_overhealth += _val_magnitude;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

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

			//----------------------------//
			//TRACK REMAINING OVERHEALTH//
			//----------------------------//
			/*
				Damage reduces the Beast's shared Overhealth pool.

				Clamp Bloom's tracked contribution to the Beast's
				current Overhealth before regeneration.
			*/
			_ref_status._val_status_remaining = min(
				_ref_status._val_status_remaining,
				_ref_host._val_overhealth
			);

			//----------------------//
			//GET BLOOM CAPACITY//
			//----------------------//
			var _val_bloom_max = _ref_status._val_status_magnitude * _ref_status._ct_status_stacks;

			//----------------------------//
			//CALCULATE MISSING BLOOM//
			//----------------------------//
			var _val_missing_bloom = max(0,_val_bloom_max - _ref_status._val_status_remaining);

			//--------------------------//
			//REGENERATE ONE STACK//
			//--------------------------//
			var _val_regenerated = min(_ref_status._val_status_magnitude,_val_missing_bloom);

			if (_val_regenerated > 0){

				_ref_host._val_overhealth += _val_regenerated;
				_ref_status._val_status_remaining += _val_regenerated;

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"+" + string(_val_regenerated) + " BLOOM",
					undefined,
					c_green,
					_ref_host.x,
					_ref_host.y - 48
				);
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

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){

				//---------------------------//
				//REMOVE OWNED OVERHEALTH//
				//---------------------------//
				_ref_status._val_status_remaining = min(
					_ref_status._val_status_remaining,
					_ref_host._val_overhealth
				);

				_ref_host._val_overhealth =
					max(
						0,
						_ref_host._val_overhealth -
							_ref_status._val_status_remaining
					);
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}