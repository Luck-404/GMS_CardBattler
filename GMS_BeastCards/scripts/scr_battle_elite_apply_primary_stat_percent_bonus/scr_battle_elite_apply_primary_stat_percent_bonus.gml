//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_APPLY_PRIMARY_STAT_PERCENT_BONUS
// FUNCTION: Permanently increases a living battle Beast's seven primary stats
//           by a percentage of either its current stats or a supplied snapshot.
//
//           Primary stats:
//           HP, CON, PPOW, MPOW, PDEF, MDEF, SPEED.
//
//           HP Stat changes update derived Maximum HP without healing Current HP.
//           Existing non-stat Max-HP changes remain independent because only this
//           bonus's derived-Max-HP delta is added.
//
//           Elite final-HP multipliers are preserved when the target itself is
//           Elite (universal x1.25, plus Hardy/Bloodthirsty where applicable).
//
// ARGUMENTS: _ref_target - living battle Beast receiving the permanent bonus.
//            _val_percent - positive percentage, e.g. 10 or 25.
//            _stct_basis - optional primary-stat snapshot. When omitted, current
//                          primary stats are used as the basis.
//            _str_source - debug/presentation source label.
// RETURNS: Struct describing applied stat bonuses, or undefined on failure.
//
//===============================================================================//
function scr_battle_elite_apply_primary_stat_percent_bonus(
    _ref_target,
    _val_percent,
    _stct_basis=undefined,
    _str_source="ELITE"
){
    #region VALIDATION

    if (!instance_exists(_ref_target)){
        return undefined;
    }

    if (
        _ref_target._val_cur_hp <= 0 ||
        _ref_target._str_list != "ALIVE"
    ){
        return undefined;
    }

    if (!is_struct(_ref_target._ref_unit)){
        return undefined;
    }

    if (!is_real(_val_percent)){
        return undefined;
    }

    _val_percent = max(0,_val_percent);

    if (_val_percent <= 0){
        return undefined;
    }

    var _stct_unit =
        _ref_target._ref_unit;

    #endregion

    #region BASIS

    if (!is_struct(_stct_basis)){
        _stct_basis = {
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

    var _val_factor =
        _val_percent / 100;

    var _val_hp_bonus =
        max(
            0,
            round(
                _stct_basis._val_beast_hp_stat *
                _val_factor
            )
        );

    var _val_con_bonus =
        max(
            0,
            round(
                _stct_basis._val_beast_con_stat *
                _val_factor
            )
        );

    var _val_ppow_bonus =
        max(
            0,
            round(
                _stct_basis._val_beast_ppow_stat *
                _val_factor
            )
        );

    var _val_mpow_bonus =
        max(
            0,
            round(
                _stct_basis._val_beast_mpow_stat *
                _val_factor
            )
        );

    var _val_pdef_bonus =
        max(
            0,
            round(
                _stct_basis._val_beast_pdef_stat *
                _val_factor
            )
        );

    var _val_mdef_bonus =
        max(
            0,
            round(
                _stct_basis._val_beast_mdef_stat *
                _val_factor
            )
        );

    var _val_speed_bonus =
        max(
            0,
            round(
                _stct_basis._val_beast_speed_stat *
                _val_factor
            )
        );

    #endregion

    #region HP DELTA

    var _val_old_hp_stat =
        _stct_unit._val_beast_hp_stat;

    var _val_new_hp_stat =
        _val_old_hp_stat +
        _val_hp_bonus;

    var _val_level =
        max(
            1,
            floor(
                _stct_unit._val_beast_level
            )
        );

    var _val_final_hp_multiplier = 1;

    if (
        variable_struct_exists(
            _stct_unit,
            "_flag_elite"
        ) &&
        _stct_unit._flag_elite
    ){
        _val_final_hp_multiplier = 1.25;

        var _str_modifier = "";

        if (
            variable_struct_exists(
                _stct_unit,
                "_str_elite_modifier"
            )
        ){
            _str_modifier =
                string_upper(
                    string(
                        _stct_unit
                            ._str_elite_modifier
                    )
                );
        }

        switch (_str_modifier){
            case "HARDY":
                _val_final_hp_multiplier *=
                    1.10;
            break;

            case "BLOODTHIRSTY":
                _val_final_hp_multiplier *=
                    0.50;
            break;
        }
    }

    var _val_old_derived_max =
        ceil(
            scr_beast_get_max_hp(
                _val_old_hp_stat,
                _val_level
            ) *
            _val_final_hp_multiplier
        );

    var _val_new_derived_max =
        ceil(
            scr_beast_get_max_hp(
                _val_new_hp_stat,
                _val_level
            ) *
            _val_final_hp_multiplier
        );

    var _val_max_hp_bonus =
        max(
            0,
            _val_new_derived_max -
            _val_old_derived_max
        );

    #endregion

    #region APPLY STATS

    _stct_unit._val_beast_hp_stat +=
        _val_hp_bonus;

    _stct_unit._val_beast_con_stat +=
        _val_con_bonus;

    _stct_unit._val_beast_ppow_stat +=
        _val_ppow_bonus;

    _stct_unit._val_beast_mpow_stat +=
        _val_mpow_bonus;

    _stct_unit._val_beast_pdef_stat +=
        _val_pdef_bonus;

    _stct_unit._val_beast_mdef_stat +=
        _val_mdef_bonus;

    _stct_unit._val_beast_speed_stat +=
        _val_speed_bonus;

    #endregion

    #region RUNTIME SYNC

    if (_val_max_hp_bonus > 0){
        _ref_target._val_max_hp +=
            _val_max_hp_bonus;

        _stct_unit._val_beast_hp_max +=
            _val_max_hp_bonus;

        /*
            This is a stat buff, not healing.
            Current HP intentionally remains unchanged.
        */
        _ref_target._val_cur_hp =
            min(
                _ref_target._val_cur_hp,
                _ref_target._val_max_hp
            );
    }

    _ref_target._val_speed_base +=
        _val_speed_bonus;

    #endregion

    #region RESULT

    var _stct_result = {
        _val_percent :
            _val_percent,

        _val_hp_stat_bonus :
            _val_hp_bonus,

        _val_con_bonus :
            _val_con_bonus,

        _val_ppow_bonus :
            _val_ppow_bonus,

        _val_mpow_bonus :
            _val_mpow_bonus,

        _val_pdef_bonus :
            _val_pdef_bonus,

        _val_mdef_bonus :
            _val_mdef_bonus,

        _val_speed_bonus :
            _val_speed_bonus,

        _val_max_hp_bonus :
            _val_max_hp_bonus
    };

    scr_debug_log(
        "BATTLE",
        "ELITE",
        _ref_target,
        string_upper(
            string(
                _str_source
            )
        ) +
        " PRIMARY STAT BONUS" +
        " | +" +
        string(
            _val_percent
        ) +
        "%" +
        " | HP STAT: +" +
        string(
            _val_hp_bonus
        ) +
        " | CON: +" +
        string(
            _val_con_bonus
        ) +
        " | PPOW: +" +
        string(
            _val_ppow_bonus
        ) +
        " | MPOW: +" +
        string(
            _val_mpow_bonus
        ) +
        " | PDEF: +" +
        string(
            _val_pdef_bonus
        ) +
        " | MDEF: +" +
        string(
            _val_mdef_bonus
        ) +
        " | SPEED: +" +
        string(
            _val_speed_bonus
        ) +
        " | MAX HP: +" +
        string(
            _val_max_hp_bonus
        ),
        "BATTLE",
        "SCR_BATTLE_ELITE_APPLY_PRIMARY_STAT_PERCENT_BONUS"
    );

    return _stct_result;

    #endregion
}
