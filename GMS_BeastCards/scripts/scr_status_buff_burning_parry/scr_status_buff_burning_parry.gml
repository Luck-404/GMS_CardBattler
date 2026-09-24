
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_BURNING_PARRY
// FUNCTION: Handles Burning Parry.
//           Unstackable Timed Buff lasting 2 rounds by default.
//           Blocks the next enemy Melee Attack against the host.
//           When triggered, the host retaliates against the attacker with
//           linear Physical damage using the original Burning Parry Card.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined, _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_burning_parry(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

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
				_val_magnitude = 6;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 2;
			}

			_val_magnitude = max(0,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check("BURNING_PARRY",_ref_target);

			//==================//
			//REFRESH EXISTING//
			//==================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._val_status_magnitude = _val_magnitude;
				_ref_existing_status._ref_source_card = global.ref_cast_card;

				scr_status_refresh_lifetime(_ref_existing_status,_val_lifetime);

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
			//INITIALIZE LIFETIME//
			//=====================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_burning_parry;

			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._ref_source_card = global.ref_cast_card;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "BURNING_PARRY";
			_ref_new_status._str_status_desc = "BLOCK NEXT MELEE ATTACK; RETALIATE WITH LINEAR PHY DAMAGE";

			_ref_new_status._spr_status = spr_status_buff_burning_parry;

			_ref_new_status._ct_status_stacks = 1;

			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = "START";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_defender = _ref_status._ref_host;
			var _ref_attacker = global.ref_caster_beast;

			//------------------//
			//VALIDATE COMBATANTS//
			//------------------//
			if (!instance_exists(_ref_defender)){
				return false;
			}

			if (!instance_exists(_ref_attacker)){
				return false;
			}

			if (_ref_attacker._val_cur_hp <= 0){
				return false;
			}

			if (_ref_attacker._str_team == _ref_defender._str_team){
				return false;
			}

			//----------------//
			//VALIDATE ATTACK//
			//----------------//
			if (!instance_exists(global.ref_cast_card)){
				return false;
			}

			if (!is_struct(global.ref_cast_card._ref_card)){
				return false;
			}

			var _stct_incoming_card = global.ref_cast_card._ref_card;

			if (_stct_incoming_card._str_card_type != "ATTACK"){
				return false;
			}

			if (_stct_incoming_card._str_card_range != "MELEE"){
				return false;
			}

			//====================//
			//SNAPSHOT PARRY DATA//
			//====================//
			var _val_retaliation_damage = _ref_status._val_status_magnitude;
			var _ref_parry_card = _ref_status._ref_source_card;

			//================//
			//BLOCK FEEDBACK//
			//================//
			scr_battle_vfx_blocked(_ref_defender);

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"BURNING PARRY",
				undefined,
				c_red,
				_ref_defender.x,
				_ref_defender.y - 48
			);

			//================//
			//CONSUME PARRY//
			//================//
			scr_status_buff_burning_parry("DEATH",_ref_status);

			//---------------------//
			//VALIDATE SOURCE CARD//
			//---------------------//
			if (!instance_exists(_ref_parry_card)){
				return true;
			}

			if (!is_struct(_ref_parry_card._ref_card)){
				return true;
			}

			if (!instance_exists(_ref_attacker) || _ref_attacker._val_cur_hp <= 0){
				return true;
			}

			//=======================//
			//STORE DAMAGE CONTEXT//
			//=======================//
			var _ref_original_card = global.ref_cast_card;
			var _ref_original_caster = global.ref_caster_beast;

			//======================//
			//SET RETALIATION CONTEXT//
			//======================//
			global.ref_cast_card = _ref_parry_card;
			global.ref_caster_beast = _ref_defender;

			//=====================//
			//RETALIATE WITH PHY//
			//=====================//
			scr_battle_damage_target(
				"LINEAR",
				_ref_defender,
				_ref_attacker,
				_val_retaliation_damage,
				{card: _ref_parry_card._ref_card, card_instance: _ref_parry_card}
			);

			//========================//
			//RESTORE DAMAGE CONTEXT//
			//========================//
			global.ref_cast_card = _ref_original_card;
			global.ref_caster_beast = _ref_original_caster;

			//================//
			//DEBUG TRIGGER//
			//================//
			scr_debug_log_battle_trigger(
				"BURNING PARRY",
				_ref_defender,
				_ref_attacker,
				"BLOCKED MELEE ATTACK | BASE PHY RETALIATION: " +
				string(_val_retaliation_damage),
				"SCR_STATUS_BUFF_BURNING_PARRY"
			);

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