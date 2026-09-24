//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_FLAMING_LASHES
// FUNCTION: Grants an unstackable 3-round Buff.
//           After an Attack, deals 20% of final direct damage to one enemy
//           adjacent to the original target.
//
//           Both neighbors: 50/50.
//           One neighbor: always that neighbor.
//           No neighbors: no effect.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined, _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_flaming_lashes(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


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
				_val_magnitude = 20;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_magnitude = max(0,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"FLAMING_LASHES",
				_ref_target
			);

			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//------------------//
				//UPDATE MAGNITUDE//
				//------------------//
				_ref_existing_status._val_status_magnitude = _val_magnitude;

				_ref_existing_status._str_status_desc =
					"ATTACKS DEAL " +
					string(_val_magnitude) +
					"% DAMAGE TO AN ADJACENT ENEMY";

				//------------------//
				//REFRESH DURATION//
				//------------------//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

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

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_flaming_lashes;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "FLAMING_LASHES";

			_ref_new_status._str_status_desc =
				"ATTACKS DEAL " +
				string(_val_magnitude) +
				"% DAMAGE TO AN ADJACENT ENEMY";

			_ref_new_status._spr_status = spr_status_buff_flaming_lashes;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._str_trigger_region = "END";

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

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//-----------------//
			//VALIDATE STATUS//
			//-----------------//
			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			if (_ref_status._val_status_lifetime <= 0){
				return false;
			}

			//---------------//
			//VALIDATE CARD//
			//---------------//
			var _ref_card = global.ref_cast_card;

			if (!instance_exists(_ref_card)){
				return false;
			}

			if (!is_struct(_ref_card._ref_card)){
				return false;
			}

			var _stct_card = _ref_card._ref_card;

			if (_stct_card._str_card_type != "ATTACK"){
				return false;
			}

			//======================//
			//GET LEFT/RIGHT TARGETS//
			//======================//
			var _ref_left = _ref_card._ref_flaming_lashes_left;
			var _ref_right = _ref_card._ref_flaming_lashes_right;

			var _flag_left_valid = false;
			var _flag_right_valid = false;

			//------------//
			//CHECK LEFT//
			//------------//
			if (instance_exists(_ref_left)){

				_flag_left_valid = (
					_ref_left._str_list == "ALIVE" &&
					_ref_left._val_cur_hp > 0 &&
					_ref_left._str_team != _ref_host._str_team
				);
			}

			//-------------//
			//CHECK RIGHT//
			//-------------//
			if (instance_exists(_ref_right)){

				_flag_right_valid = (
					_ref_right._str_list == "ALIVE" &&
					_ref_right._val_cur_hp > 0 &&
					_ref_right._str_team != _ref_host._str_team
				);
			}

			//======================//
			//NO ADJACENT ENEMIES//
			//======================//
			if (!_flag_left_valid && !_flag_right_valid){
				return false;
			}

			//=========================//
			//GET ATTACK DAMAGE LEDGER//
			//=========================//
			if (
				!variable_instance_exists(
					_ref_card,
					"_arr_damage_results"
				)
			){
				return false;
			}

			if (!is_array(_ref_card._arr_damage_results)){
				return false;
			}

			//=========================//
			//TOTAL FINAL DIRECT DAMAGE//
			//=========================//
			var _val_total_damage = 0;

			for (
				var _it_result = 0;
				_it_result < array_length(_ref_card._arr_damage_results);
				_it_result++
			){

				var _stct_result = _ref_card._arr_damage_results[_it_result];

				if (!is_struct(_stct_result)){
					continue;
				}

				//------------------------//
				//HOST'S ATTACK DAMAGE//
				//------------------------//
				if (_stct_result._ref_caster != _ref_host){
					continue;
				}

				var _ref_damage_target = _stct_result._ref_target;

				if (!instance_exists(_ref_damage_target)){
					continue;
				}

				if (_ref_damage_target._str_team == _ref_host._str_team){
					continue;
				}

				// IMPORTANT:
				// Final damage is measured BEFORE Armor/Minion absorption.
				// Even a fully armored hit contributes to Flaming Lashes.
				_val_total_damage += max(
					0,
					_stct_result._val_final_damage
				);
			}

			if (_val_total_damage <= 0){
				return false;
			}

			//===========================//
			//CALCULATE SECONDARY DAMAGE//
			//===========================//
			var _val_secondary_damage = max(
				1,
				ceil(
					_val_total_damage *
					(_ref_status._val_status_magnitude / 100)
				)
			);

			//========================//
			//CHOOSE ADJACENT TARGET//
			//========================//
			var _ref_secondary_target = undefined;

			//--------------//
			//BOTH: 50/50//
			//--------------//
			if (_flag_left_valid && _flag_right_valid){

				if (irandom(1) == 0){
					_ref_secondary_target = _ref_left;
				}
				else{
					_ref_secondary_target = _ref_right;
				}
			}

			//-----------//
			//LEFT ONLY//
			//-----------//
			else if (_flag_left_valid){
				_ref_secondary_target = _ref_left;
			}

			//------------//
			//RIGHT ONLY//
			//------------//
			else{
				_ref_secondary_target = _ref_right;
			}

			//=======================//
			//SAVE DAMAGE CONTEXT//
			//=======================//
			var _str_original_stat = _stct_card._str_card_stat;

			var _ct_original_results = array_length(
				_ref_card._arr_damage_results
			);

			var _stct_original_last_result = _ref_card._stct_last_damage_result;

			//================//
			//TRIGGER FEEDBACK//
			//================//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"FLAMING LASHES",
				undefined,
				c_red,
				_ref_host.x,
				_ref_host.y - 48
			);

			//=====================//
			//DEAL SECONDARY DAMAGE//
			//=====================//
			_stct_card._str_card_stat = "NEU";

			scr_battle_damage_target(
				"LINEAR",
				_ref_host,
				_ref_secondary_target,
				_val_secondary_damage,
				{card: _stct_card, card_instance: _ref_card}
			);

			//========================//
			//RESTORE DAMAGE CONTEXT//
			//========================//
			_stct_card._str_card_stat = _str_original_stat;

			//---------------------------//
			//EXCLUDE SPLASH FROM LEDGER//
			//---------------------------//
			if (instance_exists(_ref_card)){

				if (is_array(_ref_card._arr_damage_results)){

					array_resize(
						_ref_card._arr_damage_results,
						_ct_original_results
					);
				}

				_ref_card._stct_last_damage_result = _stct_original_last_result;
			}

			return true;

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