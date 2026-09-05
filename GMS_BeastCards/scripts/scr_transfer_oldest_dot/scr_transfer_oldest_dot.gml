//===============================================================================//
//
// SCRIPT: SCR_TRANSFER_OLDEST_DOT
// FUNCTION: Transfers the oldest DoT from one Beast to another.
//           Preserves all stacks and remaining lifetime.
//           Transfers host-bound Frostbite and Venom penalties.
//           Merges with an existing matching DoT on the target.
//           Does not perform CON resistance or normal application effects.
//
//===============================================================================//

function scr_transfer_oldest_dot(_ref_source,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_source)){
		return false;
	}

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_ref_source == _ref_target){
		return false;
	}

	if (
		_ref_source._str_list != "ALIVE" ||
		_ref_source._val_cur_hp <= 0
	){
		return false;
	}

	if (
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		return false;
	}

	//=================//
	//GET OLDEST DOT//
	//=================//
	var _ref_dot = undefined;

	for (
		var _it_status = 0;
		_it_status < ds_list_size(_ref_source._list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_ref_source._list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "DOT"){
			continue;
		}

		_ref_dot =
			_ref_status;

		break;
	}

	//--------------//
	//NO DOT FOUND//
	//--------------//
	if (!instance_exists(_ref_dot)){

		scr_spawn_popup_scrolling(
			"TEXT",
			"NO DOT",
			undefined,
			c_aqua,
			_ref_source.x,
			_ref_source.y - 48
		);

		return false;
	}

	var _str_dot_name =
		_ref_dot._str_status_name;

	var _ct_stacks =
		max(
			1,
			_ref_dot._ct_status_stacks
		);

	//================================//
	//REMOVE SOURCE HOST MODIFIERS//
	//================================//
	switch(_str_dot_name){

		//-----------//
		//FROSTBITE//
		//-----------//
		case "FROSTBITE":

			var _val_hp_restore =
				max(
					0,
					_ref_dot._val_frostbite_max_hp_reduction
				);

			_ref_source._val_max_hp +=
				_val_hp_restore;

			_ref_source._val_max_hp =
				max(
					1,
					_ref_source._val_max_hp
				);

			_ref_source._val_cur_hp =
				min(
					_ref_source._val_cur_hp,
					_ref_source._val_max_hp
				);

			_ref_dot._val_frostbite_max_hp_reduction =
				0;

		break;


		//-------//
		//VENOM//
		//-------//
		case "VENOM":

			if (is_struct(_ref_source._ref_unit)){

				_ref_source._ref_unit._val_beast_ppow_stat +=
					_ref_dot._val_venom_ppow_reduction;

				_ref_source._ref_unit._val_beast_mpow_stat +=
					_ref_dot._val_venom_mpow_reduction;

				_ref_source._ref_unit._val_beast_pdef_stat +=
					_ref_dot._val_venom_pdef_reduction;

				_ref_source._ref_unit._val_beast_mdef_stat +=
					_ref_dot._val_venom_mdef_reduction;
			}

			_ref_dot._val_venom_ppow_reduction =
				0;

			_ref_dot._val_venom_mpow_reduction =
				0;

			_ref_dot._val_venom_pdef_reduction =
				0;

			_ref_dot._val_venom_mdef_reduction =
				0;

		break;
	}

	//========================//
	//REMOVE FROM SOURCE LIST//
	//========================//
	var _it_source_status =
		ds_list_find_index(
			_ref_source._list_statuses,
			_ref_dot
		);

	if (_it_source_status == -1){
		return false;
	}

	ds_list_delete(
		_ref_source._list_statuses,
		_it_source_status
	);

	//========================//
	//CHECK MATCHING TARGET DOT//
	//========================//
	var _ref_target_dot =
		scr_check_for_status(
			_str_dot_name,
			_ref_target
		);

	//================================//
	//TARGET ALREADY HAS SAME DOT//
	//================================//
	if (_ref_target_dot != -1){

		//------------//
		//MERGE STACKS//
		//------------//
		_ref_target_dot._ct_status_stacks +=
			_ct_stacks;

		//----------------//
		//MERGE LIFETIME//
		//----------------//
		if (
			!_ref_target_dot._flag_status_infinite &&
			!_ref_dot._flag_status_infinite
		){

			_ref_target_dot._val_status_lifetime =
				max(
					_ref_target_dot._val_status_lifetime,
					_ref_dot._val_status_lifetime
				);

			_ref_target_dot._val_status_lifetime_max =
				max(
					_ref_target_dot._val_status_lifetime_max,
					_ref_dot._val_status_lifetime_max
				);
		}

		//================================//
		//APPLY TRANSFERRED HOST EFFECTS//
		//================================//
		switch(_str_dot_name){

			//-----------//
			//FROSTBITE//
			//-----------//
			case "FROSTBITE":

				var _val_hp_reduction =
					min(
						_ct_stacks,
						max(
							0,
							_ref_target._val_max_hp - 1
						)
					);

				if (_val_hp_reduction > 0){

					_ref_target._val_max_hp -=
						_val_hp_reduction;

					_ref_target_dot
						._val_frostbite_max_hp_reduction +=
						_val_hp_reduction;

					_ref_target._val_cur_hp =
						min(
							_ref_target._val_cur_hp,
							_ref_target._val_max_hp
						);
				}

			break;


			//-------//
			//VENOM//
			//-------//
			case "VENOM":

				if (is_struct(_ref_target._ref_unit)){

					var _val_stat_reduction =
						_ct_stacks *
						2;

					var _val_old_ppow =
						_ref_target._ref_unit._val_beast_ppow_stat;

					var _val_old_mpow =
						_ref_target._ref_unit._val_beast_mpow_stat;

					var _val_old_pdef =
						_ref_target._ref_unit._val_beast_pdef_stat;

					var _val_old_mdef =
						_ref_target._ref_unit._val_beast_mdef_stat;

					_ref_target._ref_unit._val_beast_ppow_stat =
						max(
							0,
							_val_old_ppow -
							_val_stat_reduction
						);

					_ref_target._ref_unit._val_beast_mpow_stat =
						max(
							0,
							_val_old_mpow -
							_val_stat_reduction
						);

					_ref_target._ref_unit._val_beast_pdef_stat =
						max(
							0,
							_val_old_pdef -
							_val_stat_reduction
						);

					_ref_target._ref_unit._val_beast_mdef_stat =
						max(
							0,
							_val_old_mdef -
							_val_stat_reduction
						);

					_ref_target_dot._val_venom_ppow_reduction +=
						_val_old_ppow -
						_ref_target._ref_unit._val_beast_ppow_stat;

					_ref_target_dot._val_venom_mpow_reduction +=
						_val_old_mpow -
						_ref_target._ref_unit._val_beast_mpow_stat;

					_ref_target_dot._val_venom_pdef_reduction +=
						_val_old_pdef -
						_ref_target._ref_unit._val_beast_pdef_stat;

					_ref_target_dot._val_venom_mdef_reduction +=
						_val_old_mdef -
						_ref_target._ref_unit._val_beast_mdef_stat;
				}

			break;


			//-----------//
			//FROSTBURN//
			//-----------//
			case "FROSTBURN":

				_ref_target_dot._str_status_desc =
					"DEALS " +
					string(
						_ref_target_dot._ct_status_stacks *
						2
					) +
					" NEU DMG EACH ROUND; REMOVES 1 BUFF";

			break;
		}

		//----------------------//
		//DESTROY MOVED INSTANCE//
		//----------------------//
		instance_destroy(
			_ref_dot
		);
	}

	//============================//
	//TARGET DOES NOT HAVE DOT//
	//============================//
	else{

		//---------------//
		//CHANGE HOST//
		//---------------//
		_ref_dot._ref_host =
			_ref_target;

		_ref_dot._ref_status_target =
			_ref_target;

		_ref_dot._str_status_command =
			"WAIT";

		//================================//
		//APPLY TRANSFERRED HOST EFFECTS//
		//================================//
		switch(_str_dot_name){

			//-----------//
			//FROSTBITE//
			//-----------//
			case "FROSTBITE":

				var _val_hp_reduction =
					min(
						_ct_stacks,
						max(
							0,
							_ref_target._val_max_hp - 1
						)
					);

				_ref_target._val_max_hp -=
					_val_hp_reduction;

				_ref_target._val_max_hp =
					max(
						1,
						_ref_target._val_max_hp
					);

				_ref_target._val_cur_hp =
					min(
						_ref_target._val_cur_hp,
						_ref_target._val_max_hp
					);

				_ref_dot._val_frostbite_max_hp_reduction =
					_val_hp_reduction;

			break;


			//-------//
			//VENOM//
			//-------//
			case "VENOM":

				if (is_struct(_ref_target._ref_unit)){

					var _val_stat_reduction =
						_ct_stacks *
						2;

					var _val_old_ppow =
						_ref_target._ref_unit._val_beast_ppow_stat;

					var _val_old_mpow =
						_ref_target._ref_unit._val_beast_mpow_stat;

					var _val_old_pdef =
						_ref_target._ref_unit._val_beast_pdef_stat;

					var _val_old_mdef =
						_ref_target._ref_unit._val_beast_mdef_stat;

					_ref_target._ref_unit._val_beast_ppow_stat =
						max(
							0,
							_val_old_ppow -
							_val_stat_reduction
						);

					_ref_target._ref_unit._val_beast_mpow_stat =
						max(
							0,
							_val_old_mpow -
							_val_stat_reduction
						);

					_ref_target._ref_unit._val_beast_pdef_stat =
						max(
							0,
							_val_old_pdef -
							_val_stat_reduction
						);

					_ref_target._ref_unit._val_beast_mdef_stat =
						max(
							0,
							_val_old_mdef -
							_val_stat_reduction
						);

					_ref_dot._val_venom_ppow_reduction =
						_val_old_ppow -
						_ref_target._ref_unit._val_beast_ppow_stat;

					_ref_dot._val_venom_mpow_reduction =
						_val_old_mpow -
						_ref_target._ref_unit._val_beast_mpow_stat;

					_ref_dot._val_venom_pdef_reduction =
						_val_old_pdef -
						_ref_target._ref_unit._val_beast_pdef_stat;

					_ref_dot._val_venom_mdef_reduction =
						_val_old_mdef -
						_ref_target._ref_unit._val_beast_mdef_stat;
				}

			break;
		}

		//----------------------//
		//REGISTER WITH TARGET//
		//----------------------//
		ds_list_add(
			_ref_target._list_statuses,
			_ref_dot
		);
	}

	//-------------------//
	//REFRESH STATUS ICONS//
	//-------------------//
	scr_reposition_statuses(_ref_source);
	scr_reposition_statuses(_ref_target);

	//----------//
	//FEEDBACK//
	//----------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"TRANSFERRED " +
			string(_ct_stacks) +
			" " +
			_str_dot_name,
		undefined,
		c_aqua,
		_ref_target.x,
		_ref_target.y - 48
	);

	return true;
}