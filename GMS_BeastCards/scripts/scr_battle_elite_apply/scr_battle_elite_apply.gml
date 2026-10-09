//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_APPLY
// FUNCTION: Marks an initialized enemy Beast struct as Elite and applies the
//           universal Elite stat package exactly once.
//
//           RISK TIER 0:
//           - +10% to all seven primary stats.
//           - +25% final Maximum HP after the boosted HP Stat is resolved.
//
//           RISK TIER 1+:
//           - +20% to all seven primary stats.
//           - +50% final Maximum HP after the boosted HP Stat is resolved.
//
//           Implemented modifier initialization also includes:
//           HARDY        - +50% CON; +10% final Max HP.
//           BLOODTHIRSTY - +25 Crit percentage points; -50% final Max HP.
//           VENGEFUL     - snapshots post-Elite primary stats and guarantees a
//                          minimum enemy roster of Elite + 2 real allies during
//                          enemy INIT_BEASTS.
//
//           Before the first Elite stat mutation, the unmodified Beast stats are
//           snapshotted into _stct_elite_base_stats. This makes developer Cheat
//           promotion/change/demotion reversible instead of stacking modifiers.
//
//           HARDY's Immovable rule is resolved centrally by
//           SCR_BATTLE_HAS_REPOSITION_LOCK. EVASIVE has no stat mutation.
//
// ARGUMENTS: _stct_unit - initialized Beast struct becoming/remaining Elite.
//            _str_modifier - optional modifier ID; existing valid metadata is used
//                            when omitted, otherwise a random modifier is rolled.
// RETURNS: True when Elite metadata/stats resolve successfully; otherwise false.
//
//===============================================================================//
function scr_battle_elite_apply(_stct_unit,_str_modifier=undefined){
    #region VALIDATION

    if (!is_struct(_stct_unit)){
        return false;
    }

    if (
        !variable_struct_exists(_stct_unit,"_val_beast_level") ||
        !variable_struct_exists(_stct_unit,"_val_beast_hp_stat") ||
        !variable_struct_exists(_stct_unit,"_val_beast_con_stat") ||
        !variable_struct_exists(_stct_unit,"_val_beast_ppow_stat") ||
        !variable_struct_exists(_stct_unit,"_val_beast_mpow_stat") ||
        !variable_struct_exists(_stct_unit,"_val_beast_pdef_stat") ||
        !variable_struct_exists(_stct_unit,"_val_beast_mdef_stat") ||
        !variable_struct_exists(_stct_unit,"_val_beast_speed_stat")
    ){
        return false;
    }

    if (!variable_struct_exists(_stct_unit,"_val_beast_crit_stat")){
        _stct_unit._val_beast_crit_stat = 0;
    }

    #endregion

    #region PRE-ELITE BASE SNAPSHOT

    /*
        Store the clean pre-Elite state exactly once.

        Natural Elites receive this snapshot during encounter initialization.
        Cheat-promoted normal enemies receive it when promoted for the first time.
        Later modifier changes always rebuild from this same baseline.
    */
    if (
        !variable_struct_exists(
            _stct_unit,
            "_stct_elite_base_stats"
        ) ||
        !is_struct(
            _stct_unit._stct_elite_base_stats
        )
    ){
        var _val_base_hp_max =
            scr_beast_get_max_hp(
                _stct_unit._val_beast_hp_stat,
                _stct_unit._val_beast_level
            );

        if (
            variable_struct_exists(
                _stct_unit,
                "_val_beast_hp_max"
            ) &&
            is_real(
                _stct_unit._val_beast_hp_max
            ) &&
            _stct_unit._val_beast_hp_max > 0
        ){
            _val_base_hp_max =
                _stct_unit._val_beast_hp_max;
        }

        var _val_base_hp_cur =
            _val_base_hp_max;

        if (
            variable_struct_exists(
                _stct_unit,
                "_val_beast_hp_cur"
            ) &&
            is_real(
                _stct_unit._val_beast_hp_cur
            )
        ){
            _val_base_hp_cur =
                clamp(
                    _stct_unit._val_beast_hp_cur,
                    0,
                    _val_base_hp_max
                );
        }

        _stct_unit._stct_elite_base_stats = {
            _val_beast_hp_stat :
                _stct_unit._val_beast_hp_stat,

            _val_beast_con_stat :
                _stct_unit._val_beast_con_stat,

            _val_beast_ppow_stat :
                _stct_unit._val_beast_ppow_stat,

            _val_beast_mpow_stat :
                _stct_unit._val_beast_mpow_stat,

            _val_beast_pdef_stat :
                _stct_unit._val_beast_pdef_stat,

            _val_beast_mdef_stat :
                _stct_unit._val_beast_mdef_stat,

            _val_beast_speed_stat :
                _stct_unit._val_beast_speed_stat,

            _val_beast_crit_stat :
                _stct_unit._val_beast_crit_stat,

            _val_beast_hp_max :
                _val_base_hp_max,

            _val_beast_hp_cur :
                _val_base_hp_cur
        };
    }

    #endregion

    #region MODIFIER

    var _str_selected_modifier = "";

    if (_str_modifier != undefined){
        _str_selected_modifier = string_upper(string(_str_modifier));
    }

    if (
        _str_selected_modifier == "" &&
        variable_struct_exists(_stct_unit,"_str_elite_modifier")
    ){
        _str_selected_modifier = string_upper(string(_stct_unit._str_elite_modifier));
    }

    if (scr_battle_elite_get_info(_str_selected_modifier) == undefined){
        _str_selected_modifier = scr_battle_elite_roll_modifier();
    }

    if (scr_battle_elite_get_info(_str_selected_modifier) == undefined){
        return false;
    }

    #endregion

    #region METADATA

    _stct_unit._flag_elite = true;
    _stct_unit._str_elite_modifier = _str_selected_modifier;

    if (!variable_struct_exists(_stct_unit,"_flag_elite_stats_applied")){
        _stct_unit._flag_elite_stats_applied = false;
    }

    if (!variable_struct_exists(_stct_unit,"_str_elite_modifier_stats_applied")){
        _stct_unit._str_elite_modifier_stats_applied = "";
    }

    if (!variable_struct_exists(_stct_unit,"_arr_elite_card_ids")){
        _stct_unit._arr_elite_card_ids = [];
    }

    if (!variable_struct_exists(_stct_unit,"_str_elite_primary_card_id")){
        _stct_unit._str_elite_primary_card_id = "";
    }

    if (!variable_struct_exists(_stct_unit,"_str_elite_monarch_card_id")){
        _stct_unit._str_elite_monarch_card_id = "";
    }

    if (!variable_struct_exists(_stct_unit,"_arr_elite_vengeful_counted_death_uids")){
        _stct_unit._arr_elite_vengeful_counted_death_uids = [];
    }

    if (!variable_struct_exists(_stct_unit,"_arr_elite_vengeful_starting_ally_uids")){
        _stct_unit._arr_elite_vengeful_starting_ally_uids = [];
    }

    if (!variable_struct_exists(_stct_unit,"_stct_elite_vengeful_stat_basis")){
        _stct_unit._stct_elite_vengeful_stat_basis = undefined;
    }

    if (!variable_struct_exists(_stct_unit,"_val_elite_risk_tier")){
        _stct_unit._val_elite_risk_tier = 0;
    }

    #endregion

    #region PRIMARY STATS

    var _flag_elite_risk_tier_1 =
        _stct_unit._val_elite_risk_tier >= 1;

    var _val_universal_stat_bonus_percent =
        _flag_elite_risk_tier_1
        ? 20
        : 10;

    var _val_universal_final_hp_bonus_percent =
        _flag_elite_risk_tier_1
        ? 50
        : 25;

    if (!_stct_unit._flag_elite_stats_applied){
        var _val_stat_multiplier =
            1 +
            (
                _val_universal_stat_bonus_percent /
                100
            );

        _stct_unit._val_beast_hp_stat = max(0,round(_stct_unit._val_beast_hp_stat * _val_stat_multiplier));
        _stct_unit._val_beast_con_stat = max(0,round(_stct_unit._val_beast_con_stat * _val_stat_multiplier));
        _stct_unit._val_beast_ppow_stat = max(0,round(_stct_unit._val_beast_ppow_stat * _val_stat_multiplier));
        _stct_unit._val_beast_mpow_stat = max(0,round(_stct_unit._val_beast_mpow_stat * _val_stat_multiplier));
        _stct_unit._val_beast_pdef_stat = max(0,round(_stct_unit._val_beast_pdef_stat * _val_stat_multiplier));
        _stct_unit._val_beast_mdef_stat = max(0,round(_stct_unit._val_beast_mdef_stat * _val_stat_multiplier));
        _stct_unit._val_beast_speed_stat = max(0,round(_stct_unit._val_beast_speed_stat * _val_stat_multiplier));

        _stct_unit._flag_elite_stats_applied = true;
    }

    #endregion

    #region MODIFIER STATS

    if (_stct_unit._str_elite_modifier_stats_applied != _str_selected_modifier){
        switch (_str_selected_modifier){
            case "HARDY":
                _stct_unit._val_beast_con_stat = max(
                    0,
                    round(_stct_unit._val_beast_con_stat * 1.50)
                );
            break;

            case "BLOODTHIRSTY":
                _stct_unit._val_beast_crit_stat = max(
                    0,
                    _stct_unit._val_beast_crit_stat + 25
                );
            break;
        }

        _stct_unit._str_elite_modifier_stats_applied =
            _str_selected_modifier;
    }

    #endregion

    #region VENGEFUL INITIALIZATION

    if (_str_selected_modifier == "VENGEFUL"){
        //-----------------------//
        //PRIMARY-STAT SNAPSHOT//
        //-----------------------//
        if (
            !is_struct(
                _stct_unit
                    ._stct_elite_vengeful_stat_basis
            )
        ){
            _stct_unit
                ._stct_elite_vengeful_stat_basis =
                {
                    _val_beast_hp_stat :
                        _stct_unit._val_beast_hp_stat,

                    _val_beast_con_stat :
                        _stct_unit._val_beast_con_stat,

                    _val_beast_ppow_stat :
                        _stct_unit._val_beast_ppow_stat,

                    _val_beast_mpow_stat :
                        _stct_unit._val_beast_mpow_stat,

                    _val_beast_pdef_stat :
                        _stct_unit._val_beast_pdef_stat,

                    _val_beast_mdef_stat :
                        _stct_unit._val_beast_mdef_stat,

                    _val_beast_speed_stat :
                        _stct_unit._val_beast_speed_stat
                };
        }

        //-----------------------//
        //GUARANTEE TWO ALLIES//
        //-----------------------//
        /*
            During enemy INIT_BEASTS this function is called while slot 0 is
            being resolved. Increasing the controller's requested Beast count
            extends that same roster loop, producing actual allied Beasts rather
            than treating empty formation slots as dead allies.

            Cheat promotion during an active battle does not retroactively spawn
            additional units because the controller is no longer in INIT_BEASTS.
        */
        if (
            instance_exists(
                obj_battle_enemy_controller
            ) &&
            obj_battle_enemy_controller
                ._state_enemy ==
                ENUM_ENEMY_STATE.INIT_BEASTS
        ){
            obj_battle_enemy_controller
                ._ct_beasts =
                max(
                    3,
                    obj_battle_enemy_controller
                        ._ct_beasts
                );
        }
    }

    #endregion

    #region MAXIMUM HP

    var _val_stat_scaled_max_hp = scr_beast_get_max_hp(
        _stct_unit._val_beast_hp_stat,
        _stct_unit._val_beast_level
    );

    if (_val_stat_scaled_max_hp <= 0){
        return false;
    }

    var _val_final_hp_multiplier =
        1 +
        (
            _val_universal_final_hp_bonus_percent /
            100
        );

    switch (_str_selected_modifier){
        case "HARDY":
            _val_final_hp_multiplier *= 1.10;
        break;

        case "BLOODTHIRSTY":
            _val_final_hp_multiplier *= 0.50;
        break;
    }

    _stct_unit._val_beast_hp_max = max(
        1,
        ceil(_val_stat_scaled_max_hp * _val_final_hp_multiplier)
    );

    _stct_unit._val_beast_hp_cur =
        _stct_unit._val_beast_hp_max;

    #endregion

    #region DEBUG

    scr_debug_log(
        "BATTLE",
        "ELITE",
        _stct_unit,
        "ELITE APPLIED" +
        " | MODIFIER: " + _str_selected_modifier +
        " | RISK TIER: " + string(_stct_unit._val_elite_risk_tier) +
        " | BASE STAT BONUS: +" + string(_val_universal_stat_bonus_percent) + "%" +
        " | BASE FINAL HP BONUS: +" + string(_val_universal_final_hp_bonus_percent) + "%" +
        " | LEVEL: " + string(_stct_unit._val_beast_level) +
        " | HP: " + string(_stct_unit._val_beast_hp_cur) + "/" + string(_stct_unit._val_beast_hp_max) +
        " | HP STAT: " + string(_stct_unit._val_beast_hp_stat) +
        " | CON: " + string(_stct_unit._val_beast_con_stat) +
        " | PPOW: " + string(_stct_unit._val_beast_ppow_stat) +
        " | MPOW: " + string(_stct_unit._val_beast_mpow_stat) +
        " | PDEF: " + string(_stct_unit._val_beast_pdef_stat) +
        " | MDEF: " + string(_stct_unit._val_beast_mdef_stat) +
        " | SPEED: " + string(_stct_unit._val_beast_speed_stat) +
        " | CRIT: " + string(_stct_unit._val_beast_crit_stat),
        "INIT",
        "SCR_BATTLE_ELITE_APPLY"
    );

    #endregion

    return true;
}
