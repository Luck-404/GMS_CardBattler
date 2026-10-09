//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_DAMAGE_RAW_TARGET
// FUNCTION: Resolves legacy raw Status/Weather damage while allowing SOULBOUND
//           to redirect only the DAMAGE portion. Successful raw damage also
//           triggers the staged HIT frame on rollout-enabled battle Beasts.
//
//           This helper intentionally does NOT use normal REDIRECT/Blood Oath.
//           Legacy raw DoT damage did not previously trigger those Buffs, so
//           preserving that behavior avoids changing unrelated mechanics.
//
//           Damage profile:
//           - bypasses Minions;
//           - bypasses Armor;
//           - damages Overhealth first;
//           - then damages HP.
//
//           This matches existing raw DoT damage such as Bleed/Burn/Frostbite.
//
// ARGUMENTS: _ref_target - Beast currently hosting/receiving the raw damage.
//            _val_damage - raw damage amount.
//            _stct_options:
//              _c_overhealth - popup color for Overhealth damage.
//              _c_hp         - popup color for HP damage.
//              _str_source   - debug source label.
// RETURNS: Result struct.
//
//===============================================================================//
function scr_battle_elite_damage_raw_target(
    _ref_target,
    _val_damage,
    _stct_options=undefined
){
    var _stct_result = {
        _flag_success :
            false,

        _flag_soulbound_redirected :
            false,

        _ref_original_target :
            _ref_target,

        _ref_target :
            _ref_target,

        _val_overhealth_damage :
            0,

        _val_hp_damage :
            0,

        _val_total_damage :
            0
    };

    #region VALIDATION

    if (
        !instance_exists(
            _ref_target
        ) ||
        !is_real(
            _val_damage
        )
    ){
        return _stct_result;
    }

    _val_damage =
        max(
            0,
            _val_damage
        );

    if (_val_damage <= 0){
        return _stct_result;
    }

    #endregion

    #region OPTIONS

    var _c_overhealth =
        c_green;

    var _c_hp =
        c_maroon;

    var _str_source =
        "RAW DAMAGE";

    if (is_struct(_stct_options)){
        if (
            variable_struct_exists(
                _stct_options,
                "_c_overhealth"
            )
        ){
            _c_overhealth =
                _stct_options
                    ._c_overhealth;
        }

        if (
            variable_struct_exists(
                _stct_options,
                "_c_hp"
            )
        ){
            _c_hp =
                _stct_options
                    ._c_hp;
        }

        if (
            variable_struct_exists(
                _stct_options,
                "_str_source"
            )
        ){
            _str_source =
                string_upper(
                    string(
                        _stct_options
                            ._str_source
                    )
                );
        }
    }

    #endregion

    #region SOULBOUND-ONLY REDIRECT

    var _ref_original_target =
        _ref_target;

    var _ref_damage_target =
        _ref_target;

    var _arr_visited = [
        _ref_damage_target
    ];

    while (
        instance_exists(
            _ref_damage_target
        )
    ){
        var _ref_guard =
            scr_battle_elite_get_soulbound_guard(
                _ref_damage_target,
                _arr_visited
            );

        if (
            !instance_exists(
                _ref_guard
            )
        ){
            break;
        }

        _ref_damage_target =
            _ref_guard;

        array_push(
            _arr_visited,
            _ref_damage_target
        );

        _stct_result
            ._flag_soulbound_redirected =
            true;
    }

    if (
        !instance_exists(
            _ref_damage_target
        )
    ){
        return _stct_result;
    }

    _stct_result._ref_target =
        _ref_damage_target;

    #endregion

    #region OVERHEALTH

    if (
        _val_damage > 0 &&
        _ref_damage_target
            ._val_overhealth > 0
    ){
        var _val_overhealth_damage =
            min(
                _ref_damage_target
                    ._val_overhealth,
                _val_damage
            );

        _ref_damage_target
            ._val_overhealth -=
            _val_overhealth_damage;

        _val_damage -=
            _val_overhealth_damage;

        _stct_result
            ._val_overhealth_damage =
            _val_overhealth_damage;

        _stct_result
            ._val_total_damage +=
            _val_overhealth_damage;

        scr_gui_spawn_popup_scrolling(
            "TEXT",
            "-" +
                string(
                    _val_overhealth_damage
                ),
            undefined,
            _c_overhealth,
            _ref_damage_target.x +
                irandom_range(-32,32),
            _ref_damage_target.y -
                24 +
                irandom_range(-32,32)
        );
    }

    #endregion

    #region HP

    if (
        _val_damage > 0 &&
        _ref_damage_target
            ._val_cur_hp > 0
    ){
        var _val_hp_damage =
            min(
                _ref_damage_target
                    ._val_cur_hp,
                _val_damage
            );

        _ref_damage_target
            ._val_cur_hp =
            max(
                0,
                _ref_damage_target
                    ._val_cur_hp -
                _val_hp_damage
            );

        _stct_result
            ._val_hp_damage =
            _val_hp_damage;

        _stct_result
            ._val_total_damage +=
            _val_hp_damage;

        scr_gui_spawn_popup_scrolling(
            "TEXT",
            "-" +
                string(
                    _val_hp_damage
                ),
            undefined,
            _c_hp,
            _ref_damage_target.x +
                irandom_range(-32,32),
            _ref_damage_target.y -
                24 +
                irandom_range(-32,32)
        );
    }

    #endregion

    _stct_result._flag_success =
        (
            _stct_result
                ._val_total_damage >
            0
        );

    //===================//
    //BEAST HIT ANIMATION//
    //===================//
    if (_stct_result._flag_success){
        scr_beast_animation_play(_ref_damage_target,"HIT");
    }

    if (
        _stct_result
            ._flag_soulbound_redirected
    ){
        scr_debug_log(
            "BATTLE",
            "ELITE",
            _ref_damage_target,
            "SOULBOUND RAW DAMAGE REDIRECT" +
            " | SOURCE: " +
            _str_source +
            " | ORIGINAL: " +
            string_upper(
                _ref_original_target
                    ._ref_unit
                    ._str_beast_name
            ) +
            " | RECIPIENT: " +
            string_upper(
                _ref_damage_target
                    ._ref_unit
                    ._str_beast_name
            ) +
            " | DAMAGE: " +
            string(
                _stct_result
                    ._val_total_damage
            ),
            "BATTLE",
            "SCR_BATTLE_ELITE_DAMAGE_RAW_TARGET"
        );
    }

    return _stct_result;
}
