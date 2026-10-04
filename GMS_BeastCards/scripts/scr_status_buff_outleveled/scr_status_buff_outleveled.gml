//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_OUTLEVELED
// FUNCTION: Handles the permanent OUTLEVELED battle Buff.
//
//           One stack grants +10% of the host's snapshotted BASE primary stats:
//
//           HP STAT
//           PHYPOW
//           MAGPOW
//           PHYDEF
//           MAGDEF
//           CON
//           SPD
//
//           OUTLEVELED is:
//           - Stackable.
//           - Infinite for the battle.
//           - Uncleansable.
//           - Untransferable.
//           - Preserved when the host dies.
//           - Recalculated only by the Level-disparity system.
//
//           The Status owns only its own stat contribution. SET may therefore
//           safely change the stack count without disturbing other stat effects.
//
// COMMANDS:
//           APPLY   - Creates OUTLEVELED with the requested stack count.
//           SET     - Changes the exact stack count.
//           DEATH   - Intentionally does nothing; Status survives Beast death.
//           CLEANUP - Removes owned stat bonuses during battle teardown.
//
// ARGUMENTS:
//           _str_tag
//           _ref_status
//           _ct_stacks
//           _ref_target
//
//===============================================================================//

function scr_status_buff_outleveled(
    _str_tag,
    _ref_status,
    _ct_stacks=undefined,
    _ref_target=undefined
){

    switch (_str_tag){

//===============================================================================//
// APPLY
//===============================================================================//

        case "APPLY":

            #region APPLY

//================//
//VALIDATE TARGET//
//================//

            if (!instance_exists(_ref_target)){
                return undefined;
            }

            if (!is_struct(_ref_target._ref_unit)){
                return undefined;
            }

            if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
                return undefined;
            }

//================//
//VALIDATE STACKS//
//================//

            if (_ct_stacks == undefined){
                _ct_stacks = 1;
            }

            _ct_stacks =
                max(
                    0,
                    floor(_ct_stacks)
                );

            if (_ct_stacks <= 0){
                return undefined;
            }

//================//
//CHECK EXISTING//
//================//

            var _ref_existing_status =
                scr_status_check(
                    "OUTLEVELED",
                    _ref_target
                );

            if (
                _ref_existing_status != -1 &&
                instance_exists(_ref_existing_status)
            ){

                return scr_status_buff_outleveled(
                    "SET",
                    _ref_existing_status,
                    _ct_stacks
                );
            }

//================//
//CREATE STATUS//
//================//

            var _ref_new_status =
                instance_create_layer(
                    _ref_target.x,
                    _ref_target.y,
                    "ily_status",
                    obj_battle_status
                );

//===================//
//INFINITE LIFETIME//
//===================//

            scr_status_init_lifetime(
                _ref_new_status,
                -1,
                true,
                true
            );

//================//
//STATUS DATA//
//================//

            _ref_new_status._scr_status =
                scr_status_buff_outleveled;

            _ref_new_status._ref_host =
                _ref_target;

            _ref_new_status._str_status_type =
                "BUFF";

            _ref_new_status._str_status_name =
                "OUTLEVELED";

            _ref_new_status._spr_status =
                spr_status_buff_outleveled;

            _ref_new_status._ct_status_stacks = 0;

            _ref_new_status._flag_status_stackable = true;
            _ref_new_status._flag_status_uncleansable = true;

            // Read by Buff-transfer logic added below.
            _ref_new_status._flag_status_untransferable = true;

            _ref_new_status._flag_status_permanent = true;

            _ref_new_status._val_status_magnitude = 10;

            _ref_new_status._str_trigger_region =
                undefined;

//======================//
//CLEANUP SAFETY FLAG//
//======================//

            _ref_new_status._flag_outleveled_cleanup =
                false;

//=====================//
//GET SNAPSHOT BASES//
//=====================//

            /*
                SCR_BATTLE_REFRESH_OUTLEVELED stores these values on the battle
                Beast before OUTLEVELED is first applied.

                Keeping the base snapshot on the Beast means a cheat-driven
                remove/reapply does not accidentally treat another temporary
                Debuff as the Beast's new base stats.
            */

            var _stct_unit =
                _ref_target._ref_unit;

//----------------//
//HP STAT BASE//
//----------------//

            if (
                !variable_instance_exists(
                    _ref_target,
                    "_val_outleveled_base_hp_stat"
                )
            ){
                _ref_target._val_outleveled_base_hp_stat =
                    _stct_unit._val_beast_hp_stat;
            }

//------------//
//CON BASE//
//------------//

            if (
                !variable_instance_exists(
                    _ref_target,
                    "_val_outleveled_base_con"
                )
            ){
                _ref_target._val_outleveled_base_con =
                    _stct_unit._val_beast_con_stat;
            }

//--------------//
//PHYPOW BASE//
//--------------//

            if (
                !variable_instance_exists(
                    _ref_target,
                    "_val_outleveled_base_ppow"
                )
            ){
                _ref_target._val_outleveled_base_ppow =
                    _stct_unit._val_beast_ppow_stat;
            }

//--------------//
//MAGPOW BASE//
//--------------//

            if (
                !variable_instance_exists(
                    _ref_target,
                    "_val_outleveled_base_mpow"
                )
            ){
                _ref_target._val_outleveled_base_mpow =
                    _stct_unit._val_beast_mpow_stat;
            }

//--------------//
//PHYDEF BASE//
//--------------//

            if (
                !variable_instance_exists(
                    _ref_target,
                    "_val_outleveled_base_pdef"
                )
            ){
                _ref_target._val_outleveled_base_pdef =
                    _stct_unit._val_beast_pdef_stat;
            }

//--------------//
//MAGDEF BASE//
//--------------//

            if (
                !variable_instance_exists(
                    _ref_target,
                    "_val_outleveled_base_mdef"
                )
            ){
                _ref_target._val_outleveled_base_mdef =
                    _stct_unit._val_beast_mdef_stat;
            }

//-----------//
//SPD BASE//
//-----------//

            if (
                !variable_instance_exists(
                    _ref_target,
                    "_val_outleveled_base_speed"
                )
            ){
                _ref_target._val_outleveled_base_speed =
                    _stct_unit._val_beast_speed_stat;
            }

//=====================//
//STORE STATUS BASES//
//=====================//

            _ref_new_status._val_outleveled_base_hp_stat =
                _ref_target._val_outleveled_base_hp_stat;

            _ref_new_status._val_outleveled_base_con =
                _ref_target._val_outleveled_base_con;

            _ref_new_status._val_outleveled_base_ppow =
                _ref_target._val_outleveled_base_ppow;

            _ref_new_status._val_outleveled_base_mpow =
                _ref_target._val_outleveled_base_mpow;

            _ref_new_status._val_outleveled_base_pdef =
                _ref_target._val_outleveled_base_pdef;

            _ref_new_status._val_outleveled_base_mdef =
                _ref_target._val_outleveled_base_mdef;

            _ref_new_status._val_outleveled_base_speed =
                _ref_target._val_outleveled_base_speed;

//======================//
//OWNED STAT BONUSES//
//======================//

            _ref_new_status._val_outleveled_hp_stat_bonus = 0;
            _ref_new_status._val_outleveled_con_bonus = 0;
            _ref_new_status._val_outleveled_ppow_bonus = 0;
            _ref_new_status._val_outleveled_mpow_bonus = 0;
            _ref_new_status._val_outleveled_pdef_bonus = 0;
            _ref_new_status._val_outleveled_mdef_bonus = 0;
            _ref_new_status._val_outleveled_speed_bonus = 0;

            _ref_new_status._val_outleveled_max_hp_bonus = 0;

//================//
//REGISTER STATUS//
//================//

            ds_list_add(
                _ref_target._list_statuses,
                _ref_new_status
            );

//================//
//SET STACK COUNT//
//================//

            return scr_status_buff_outleveled(
                "SET",
                _ref_new_status,
                _ct_stacks
            );

            #endregion

        break;

//===============================================================================//
// SET
//===============================================================================//

		case "SET":

			#region SET

//=================//
//VALIDATE STATUS//
//=================//

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return undefined;
			}

			if (!is_struct(_ref_host._ref_unit)){
				return undefined;
			}

			var _stct_unit =
				_ref_host._ref_unit;

//================//
//VALIDATE STACKS//
//================//

			if (_ct_stacks == undefined){
				_ct_stacks =
					_ref_status._ct_status_stacks;
			}

			_ct_stacks =
				max(
					0,
					floor(_ct_stacks)
				);

//================//
//CALCULATE SCALE//
//================//

			/*
				OUTLEVELED is always calculated from the snapshotted
				base stats.

				1 stack = +10% base
				2 stacks = +20% base
				3 stacks = +30% base

				This never compounds from the already-boosted value.
			*/

			var _val_bonus_scale =
				0.10 *
				_ct_stacks;

//======================//
//DESIRED STAT BONUSES//
//======================//

			/*
				Only OUTLEVELED's owned contribution is rounded.

				This keeps the Buff's stat contribution integer-only
				without rounding away values owned by other effects.
			*/

			var _val_desired_hp_stat_bonus =
				round(
					_ref_status._val_outleveled_base_hp_stat *
					_val_bonus_scale
				);

			var _val_desired_con_bonus =
				round(
					_ref_status._val_outleveled_base_con *
					_val_bonus_scale
				);

			var _val_desired_ppow_bonus =
				round(
					_ref_status._val_outleveled_base_ppow *
					_val_bonus_scale
				);

			var _val_desired_mpow_bonus =
				round(
					_ref_status._val_outleveled_base_mpow *
					_val_bonus_scale
				);

			var _val_desired_pdef_bonus =
				round(
					_ref_status._val_outleveled_base_pdef *
					_val_bonus_scale
				);

			var _val_desired_mdef_bonus =
				round(
					_ref_status._val_outleveled_base_mdef *
					_val_bonus_scale
				);

			var _val_desired_speed_bonus =
				round(
					_ref_status._val_outleveled_base_speed *
					_val_bonus_scale
				);

//================//
//CALCULATE DELTA//
//================//

			var _val_hp_stat_delta =
				_val_desired_hp_stat_bonus -
				_ref_status._val_outleveled_hp_stat_bonus;

			var _val_con_delta =
				_val_desired_con_bonus -
				_ref_status._val_outleveled_con_bonus;

			var _val_ppow_delta =
				_val_desired_ppow_bonus -
				_ref_status._val_outleveled_ppow_bonus;

			var _val_mpow_delta =
				_val_desired_mpow_bonus -
				_ref_status._val_outleveled_mpow_bonus;

			var _val_pdef_delta =
				_val_desired_pdef_bonus -
				_ref_status._val_outleveled_pdef_bonus;

			var _val_mdef_delta =
				_val_desired_mdef_bonus -
				_ref_status._val_outleveled_mdef_bonus;

			var _val_speed_delta =
				_val_desired_speed_bonus -
				_ref_status._val_outleveled_speed_bonus;

//======================//
//UPDATE PRIMARY STATS//
//======================//

			_stct_unit._val_beast_hp_stat =
				max(
					0,
					_stct_unit._val_beast_hp_stat +
					_val_hp_stat_delta
				);

			_stct_unit._val_beast_con_stat =
				max(
					0,
					_stct_unit._val_beast_con_stat +
					_val_con_delta
				);

			_stct_unit._val_beast_ppow_stat =
				max(
					0,
					_stct_unit._val_beast_ppow_stat +
					_val_ppow_delta
				);

			_stct_unit._val_beast_mpow_stat =
				max(
					0,
					_stct_unit._val_beast_mpow_stat +
					_val_mpow_delta
				);

			_stct_unit._val_beast_pdef_stat =
				max(
					0,
					_stct_unit._val_beast_pdef_stat +
					_val_pdef_delta
				);

			_stct_unit._val_beast_mdef_stat =
				max(
					0,
					_stct_unit._val_beast_mdef_stat +
					_val_mdef_delta
				);

			_stct_unit._val_beast_speed_stat =
				max(
					0,
					_stct_unit._val_beast_speed_stat +
					_val_speed_delta
				);

//=======================//
//UPDATE RUNTIME SPEED//
//=======================//

			_ref_host._val_speed_base =
				max(
					0,
					_ref_host._val_speed_base +
					_val_speed_delta
				);

//=========================//
//CALCULATE OWNED MAX HP//
//=========================//

			var _val_level =
				max(
					1,
					floor(
						_stct_unit._val_beast_level
					)
				);

			var _val_base_derived_max_hp =
				scr_beast_get_max_hp(
					_ref_status._val_outleveled_base_hp_stat,
					_val_level
				);

			var _val_boosted_derived_max_hp =
				scr_beast_get_max_hp(
					_ref_status._val_outleveled_base_hp_stat +
					_val_desired_hp_stat_bonus,
					_val_level
				);

			var _val_desired_max_hp_bonus =
				max(
					0,
					_val_boosted_derived_max_hp -
					_val_base_derived_max_hp
				);

			var _val_max_hp_delta =
				_val_desired_max_hp_bonus -
				_ref_status._val_outleveled_max_hp_bonus;

//================//
//UPDATE MAX HP//
//================//

			_ref_host._val_max_hp =
				max(
					1,
					_ref_host._val_max_hp +
					_val_max_hp_delta
				);

			_stct_unit._val_beast_hp_max =
				max(
					1,
					_stct_unit._val_beast_hp_max +
					_val_max_hp_delta
				);

//==================//
//UPDATE CURRENT HP//
//==================//

			/*
				Increasing OUTLEVELED Max HP also grants the newly
				created HP, preserving the Beast's amount of missing HP.

				Removing stacks never deals direct damage. Current HP
				is only clamped when it exceeds the reduced Maximum HP.
			*/

			if (_ref_host._val_cur_hp > 0){

				if (_val_max_hp_delta > 0){

					_ref_host._val_cur_hp =
						min(
							_ref_host._val_max_hp,
							_ref_host._val_cur_hp +
							_val_max_hp_delta
						);
				}
				else{

					_ref_host._val_cur_hp =
						min(
							_ref_host._val_cur_hp,
							_ref_host._val_max_hp
						);
				}
			}
			else{
				_ref_host._val_cur_hp = 0;
			}

			_stct_unit._val_beast_hp_cur =
				_ref_host._val_cur_hp;

//======================//
//STORE OWNED BONUSES//
//======================//

			_ref_status._val_outleveled_hp_stat_bonus =
				_val_desired_hp_stat_bonus;

			_ref_status._val_outleveled_con_bonus =
				_val_desired_con_bonus;

			_ref_status._val_outleveled_ppow_bonus =
				_val_desired_ppow_bonus;

			_ref_status._val_outleveled_mpow_bonus =
				_val_desired_mpow_bonus;

			_ref_status._val_outleveled_pdef_bonus =
				_val_desired_pdef_bonus;

			_ref_status._val_outleveled_mdef_bonus =
				_val_desired_mdef_bonus;

			_ref_status._val_outleveled_speed_bonus =
				_val_desired_speed_bonus;

			_ref_status._val_outleveled_max_hp_bonus =
				_val_desired_max_hp_bonus;

//================//
//UPDATE STATUS//
//================//

			_ref_status._ct_status_stacks =
				_ct_stacks;

			_ref_status._str_status_desc =
				"+" +
				string(_ct_stacks * 10) +
				"% BASE PRIMARY STATS; 1 STACK PER 5 LEVELS ABOVE ENEMY TEAM AVERAGE";

//================//
//REMOVE AT ZERO//
//================//

			if (_ct_stacks <= 0){

				if (!_ref_status._flag_outleveled_cleanup){
					scr_status_destroy(_ref_status);
				}

				return undefined;
			}

//================//
//REPOSITION ICON//
//================//

			if (!_ref_status._flag_outleveled_cleanup){
				scr_status_reposition(_ref_host);
			}

			return _ref_status;

			#endregion

		break;

//===============================================================================//
// DEATH
//===============================================================================//

        case "DEATH":

            #region DEATH

            /*
                Intentionally preserve OUTLEVELED.

                OBJ_BATTLE_BEAST queues DEATH on hosted Statuses when the Beast
                dies. OUTLEVELED ignores that command so resurrection retains
                the same disparity Buff.
            */

            if (!instance_exists(_ref_status)){
                return undefined;
            }

            return _ref_status;

            #endregion

        break;

//===============================================================================//
// CLEANUP
//===============================================================================//

        case "CLEANUP":

            #region CLEANUP

            if (!instance_exists(_ref_status)){
                return undefined;
            }

            if (_ref_status._flag_outleveled_cleanup){
                return undefined;
            }

//=====================//
//MARK BATTLE CLEANUP//
//=====================//

            _ref_status._flag_outleveled_cleanup =
                true;

//======================//
//REMOVE OWNED BONUSES//
//======================//

            scr_status_buff_outleveled(
                "SET",
                _ref_status,
                0
            );

            return undefined;

            #endregion

        break;
    }

    return undefined;
}