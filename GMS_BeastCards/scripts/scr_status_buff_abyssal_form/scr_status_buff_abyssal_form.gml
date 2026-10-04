//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ABYSSAL_FORM
// FUNCTION: Handles Abyssal Form.
//           Unstackable Timed Buff.
//           Increases every primary Beast stat by 40:
//             HP, CON, PPOW, MPOW, PDEF, MDEF, and Speed.
//           HP-stat gain increases derived Maximum HP.
//           Speed-stat gain updates the active battle Speed base.
//           Whenever the host Attacks, randomly applies Stun,
//           Banish, or Stormstruck to the Attack target.
//           Generic form drawing handles the Abyssal Form transformation.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged:
//              _val_magnitude=undefined,
//              _val_lifetime=undefined,
//              _ref_attack_target=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_abyssal_form(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_attack_target=undefined,_ref_target=undefined){

    switch (_str_tag){

        //=======//
        //APPLY//
        //=======//
        case "APPLY":

            if (!instance_exists(_ref_target)){
                return undefined;
            }

            if (!is_struct(_ref_target._ref_unit)){
                return undefined;
            }

            //----------//
            //DEFAULTS//
            //----------//
            if (_val_magnitude == undefined){
                _val_magnitude = 40;
            }

            if (_val_lifetime == undefined){
                _val_lifetime = 5;
            }

            _val_magnitude = max(0,_val_magnitude);
            _val_lifetime = max(1,_val_lifetime);

            //----------------//
            //CHECK EXISTING//
            //----------------//
            var _ref_existing_status =
                scr_status_check(
                    "ABYSSAL_FORM",
                    _ref_target
                );

            if (_ref_existing_status != -1){

                scr_status_refresh_lifetime(
                    _ref_existing_status,
                    _val_lifetime
                );

                return _ref_existing_status;
            }

            //================//
            //GET BEAST DATA//
            //================//
            var _stct_unit =
                _ref_target._ref_unit;

            var _val_level =
                _stct_unit._val_beast_level;

            //=====================//
            //CALCULATE HP INCREASE//
            //=====================//
            // HP is a primary stat, but runtime Maximum HP is derived from
            // HP stat + level. Calculate only Abyssal Form's owned Max-HP
            // contribution so other Max-HP modifiers remain independent.
            var _val_old_hp_stat =
                _stct_unit._val_beast_hp_stat;

            var _val_new_hp_stat =
                _val_old_hp_stat +
                _val_magnitude;

            var _val_old_derived_max_hp =
                scr_beast_get_max_hp(
                    _val_old_hp_stat,
                    _val_level
                );

            var _val_new_derived_max_hp =
                scr_beast_get_max_hp(
                    _val_new_hp_stat,
                    _val_level
                );

            var _val_max_hp_bonus =
                max(
                    0,
                    _val_new_derived_max_hp -
                    _val_old_derived_max_hp
                );

            //======================//
            //INCREASE PRIMARY STATS//
            //======================//
            _stct_unit._val_beast_hp_stat +=
                _val_magnitude;

            _stct_unit._val_beast_con_stat +=
                _val_magnitude;

            _stct_unit._val_beast_ppow_stat +=
                _val_magnitude;

            _stct_unit._val_beast_mpow_stat +=
                _val_magnitude;

            _stct_unit._val_beast_pdef_stat +=
                _val_magnitude;

            _stct_unit._val_beast_mdef_stat +=
                _val_magnitude;

            _stct_unit._val_beast_speed_stat +=
                _val_magnitude;

            //====================//
            //UPDATE RUNTIME HP//
            //====================//
            if (_val_max_hp_bonus > 0){

                _ref_target._val_max_hp +=
                    _val_max_hp_bonus;

                // Keep the backing Beast struct synchronized with the active
                // battle Beast. Current HP is intentionally not healed.
                _stct_unit._val_beast_hp_max +=
                    _val_max_hp_bonus;
            }

            //=======================//
            //UPDATE RUNTIME SPEED//
            //=======================//
            _ref_target._val_speed_base +=
                _val_magnitude;

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

            scr_status_init_lifetime(
                _ref_new_status,
                _val_lifetime,
                false,
                false
            );

            _ref_new_status._scr_status =
                scr_status_buff_abyssal_form;

            _ref_new_status._ref_host =
                _ref_target;

            _ref_new_status._str_status_type =
                "BUFF";

            _ref_new_status._str_status_name =
                "ABYSSAL_FORM";

            _ref_new_status._str_status_desc =
                "ALL PRIMARY STATS +40: HP, CON, PPOW, MPOW, PDEF, MDEF, SPEED; ATTACKS APPLY A RANDOM ABYSSAL EFFECT";

            _ref_new_status._spr_status =
                spr_status_buff_abyssal_form;

            _ref_new_status._ct_status_stacks =
                1;

            _ref_new_status._flag_status_stackable =
                false;

            _ref_new_status._val_status_magnitude =
                _val_magnitude;

            //=======================//
            //TRACK PRIMARY STAT BONUS//
            //=======================//
            _ref_new_status._val_abyssal_hp_stat_bonus =
                _val_magnitude;

            _ref_new_status._str_trigger_region =
                "END";

            //----------------//
            //REGISTER STATUS//
            //----------------//
            ds_list_add(
                _ref_target._list_statuses,
                _ref_new_status
            );

            //------------------//
            //REFRESH FORM DRAW//
            //------------------//
            scr_battle_refresh_beast_form_draw(
                _ref_target
            );

            scr_status_reposition(
                _ref_target
            );

            return _ref_new_status;

        break;

        //=========//
        //TRIGGER//
        //=========//
        case "TRIGGER":

            if (!instance_exists(_ref_status)){
                return false;
            }

            var _ref_host =
                _ref_status._ref_host;

            if (!instance_exists(_ref_host)){
                return false;
            }

            if (!instance_exists(_ref_attack_target)){
                return false;
            }

            if (_ref_attack_target._val_cur_hp <= 0){
                return false;
            }

            if (_ref_attack_target._str_team == _ref_host._str_team){
                return false;
            }

            //--------------------//
            //ROLL ABYSSAL EFFECT//
            //--------------------//
            var _val_roll =
                irandom_range(
                    0,
                    2
                );

            switch (_val_roll){

                //------//
                //STUN//
                //------//
                case 0:

                    scr_status_apply_cc(
                        "STUN",
                        _ref_attack_target,
                        1
                    );

                break;

                //--------//
                //BANISH//
                //--------//
                case 1:

                    scr_status_apply_cc(
                        "BANISH",
                        _ref_attack_target,
                        1
                    );

                break;

                //-------------//
                //STORMSTRUCK//
                //-------------//
                case 2:

                    scr_status_apply_dot(
                        "STORMSTRUCK",
                        _ref_attack_target
                    );

                break;
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

            var _ref_host =
                _ref_status._ref_host;

            if (!instance_exists(_ref_host)){

                scr_status_destroy(
                    _ref_status
                );

                return undefined;
            }

            scr_status_tick_lifetime(
                _ref_status
            );

            scr_status_reposition(
                _ref_host
            );

        break;

        //=======//
        //DEATH//
        //=======//
        case "DEATH":

            if (!instance_exists(_ref_status)){
                return undefined;
            }

            var _ref_host =
                _ref_status._ref_host;

            if (
                instance_exists(_ref_host) &&
                is_struct(_ref_host._ref_unit)
            ){

                var _stct_unit =
                    _ref_host._ref_unit;

                var _val_bonus =
                    max(
                        0,
                        _ref_status._val_status_magnitude
                    );

                //=========================//
                //CALCULATE CURRENT HP BONUS//
                //=========================//
                // Recalculate Abyssal Form's HP contribution at the host's
                // CURRENT level before removing the HP stat. This keeps
                // removal correct even if the Beast leveled while transformed.
                var _val_hp_stat_before =
                    _stct_unit._val_beast_hp_stat;

                var _val_hp_stat_after =
                    max(
                        0,
                        _val_hp_stat_before -
                        _val_bonus
                    );

                var _val_level =
                    _stct_unit._val_beast_level;

                var _val_derived_max_before =
                    scr_beast_get_max_hp(
                        _val_hp_stat_before,
                        _val_level
                    );

                var _val_derived_max_after =
                    scr_beast_get_max_hp(
                        _val_hp_stat_after,
                        _val_level
                    );

                var _val_max_hp_bonus =
                    max(
                        0,
                        _val_derived_max_before -
                        _val_derived_max_after
                    );

                //====================//
                //REMOVE STAT BONUSES//
                //====================//
                _stct_unit._val_beast_hp_stat =
                    _val_hp_stat_after;

                _stct_unit._val_beast_con_stat =
                    max(
                        0,
                        _stct_unit._val_beast_con_stat -
                        _val_bonus
                    );

                _stct_unit._val_beast_ppow_stat =
                    max(
                        0,
                        _stct_unit._val_beast_ppow_stat -
                        _val_bonus
                    );

                _stct_unit._val_beast_mpow_stat =
                    max(
                        0,
                        _stct_unit._val_beast_mpow_stat -
                        _val_bonus
                    );

                _stct_unit._val_beast_pdef_stat =
                    max(
                        0,
                        _stct_unit._val_beast_pdef_stat -
                        _val_bonus
                    );

                _stct_unit._val_beast_mdef_stat =
                    max(
                        0,
                        _stct_unit._val_beast_mdef_stat -
                        _val_bonus
                    );

                _stct_unit._val_beast_speed_stat =
                    max(
                        0,
                        _stct_unit._val_beast_speed_stat -
                        _val_bonus
                    );

                //==================//
                //REMOVE MAX HP GAIN//
                //==================//
                if (_val_max_hp_bonus > 0){

                    _ref_host._val_max_hp =
                        max(
                            1,
                            _ref_host._val_max_hp -
                            _val_max_hp_bonus
                        );

                    _ref_host._val_cur_hp =
                        min(
                            _ref_host._val_cur_hp,
                            _ref_host._val_max_hp
                        );

                    _stct_unit._val_beast_hp_max =
                        max(
                            1,
                            _stct_unit._val_beast_hp_max -
                            _val_max_hp_bonus
                        );

                    _stct_unit._val_beast_hp_cur =
                        min(
                            _stct_unit._val_beast_hp_cur,
                            _stct_unit._val_beast_hp_max
                        );
                }

                //==================//
                //REMOVE SPEED GAIN//
                //==================//
                _ref_host._val_speed_base =
                    max(
                        0,
                        _ref_host._val_speed_base -
                        _val_bonus
                    );

                //------------------//
                //REFRESH FORM DRAW//
                //------------------//
                scr_battle_refresh_beast_form_draw(
                    _ref_host
                );
            }

            //----------------//
            //DESTROY STATUS//
            //----------------//
            scr_status_destroy(
                _ref_status
            );

        break;
    }

    return undefined;
}