//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_STATE_EFFECTS
// FUNCTIONS:
//   scr_battle_elite_get_elemental_variant
//   scr_battle_elite_is_status_immune
//   scr_battle_elite_assign_soulbound
//   scr_battle_elite_get_soulbound_guard
//   scr_battle_elite_trigger_entry_effects
//   scr_battle_elite_trigger_turn_start
//
// PURPOSE:
//   Centralizes Elite mechanics tied to battle entry and normal turn starts.
//
// ELEMENTAL:
//   STORM   - immune STORMSTRUCK; starts STORMING.
//   FIRE    - immune BURN and CHAR; starts FIRESTORM.
//   FROST   - immune FROSTBITE and FROSTBURN; starts SNOW.
//   VERDANT - immune POISON; starts SEEDFALL.
//
// SOULBOUND:
//   Chooses one allied Beast on battle entry.
//   Damage intended for that Beast is redirected to the Elite while active.
//
// PHASING:
//   Counts the Elite's own enemy turns.
//   Every third turn:
//   - cleanse half of the stacks of EACH negative Status;
//   - remaining negative Statuses do not tick that turn;
//   - self-Banish for one round and become untargetable.
//
//===============================================================================//

//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_GET_ELEMENTAL_VARIANT
//===============================================================================//
function scr_battle_elite_get_elemental_variant(_var_elite){
    var _stct_unit = undefined;

    if (is_struct(_var_elite)){
        _stct_unit = _var_elite;
    }
    else if (
        instance_exists(_var_elite) &&
        variable_instance_exists(_var_elite,"_ref_unit") &&
        is_struct(_var_elite._ref_unit)
    ){
        _stct_unit = _var_elite._ref_unit;
    }

    if (!is_struct(_stct_unit)){
        return "";
    }

    if (
        !variable_struct_exists(_stct_unit,"_flag_elite") ||
        !_stct_unit._flag_elite ||
        !variable_struct_exists(_stct_unit,"_str_elite_modifier") ||
        string_upper(string(_stct_unit._str_elite_modifier)) != "ELEMENTAL"
    ){
        return "";
    }

    if (
        variable_struct_exists(
            _stct_unit,
            "_str_elite_elemental_variant"
        )
    ){
        var _str_existing =
            string_upper(
                string(
                    _stct_unit
                        ._str_elite_elemental_variant
                )
            );

        if (
            _str_existing == "STORM" ||
            _str_existing == "FIRE" ||
            _str_existing == "FROST" ||
            _str_existing == "VERDANT"
        ){
            return _str_existing;
        }
    }

    var _arr_variants = [
        "STORM",
        "FIRE",
        "FROST",
        "VERDANT"
    ];

    var _str_selected =
        _arr_variants[
            irandom(
                array_length(_arr_variants) - 1
            )
        ];

    _stct_unit._str_elite_elemental_variant =
        _str_selected;

    return _str_selected;
}

//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_IS_STATUS_IMMUNE
// RETURNS: True when an Elemental Elite is immune to the requested Status.
//
//===============================================================================//
function scr_battle_elite_is_status_immune(_ref_target,_str_status_name){
    if (!instance_exists(_ref_target)){
        return false;
    }

    if (
        scr_battle_elite_get_modifier(
            _ref_target
        ) != "ELEMENTAL"
    ){
        return false;
    }

    var _str_variant =
        scr_battle_elite_get_elemental_variant(
            _ref_target
        );

    _str_status_name =
        string_upper(
            string(
                _str_status_name
            )
        );

    switch (_str_variant){
        case "STORM":
            return (
                _str_status_name ==
                "STORMSTRUCK"
            );

        case "FIRE":
            return (
                _str_status_name == "BURN" ||
                _str_status_name == "CHAR"
            );

        case "FROST":
            return (
                _str_status_name == "FROSTBITE" ||
                _str_status_name == "FROSTBURN"
            );

        case "VERDANT":
            return (
                _str_status_name ==
                "POISON"
            );
    }

    return false;
}


//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_ASSIGN_SOULBOUND
// FUNCTION: Selects/persists one allied Beast protected by a SOULBOUND Elite.
//
//           Existing valid assignments are preserved.
//           New assignments choose one random living ally other than the Elite.
//
// ARGUMENTS: _ref_elite - active SOULBOUND Elite.
// RETURNS: Protected Beast instance, or undefined.
//
//===============================================================================//
function scr_battle_elite_assign_soulbound(_ref_elite){
    if (!instance_exists(_ref_elite)){
        return undefined;
    }

    if (
        _ref_elite._val_cur_hp <= 0 ||
        _ref_elite._str_list != "ALIVE" ||
        scr_battle_elite_get_modifier(
            _ref_elite
        ) != "SOULBOUND" ||
        !is_struct(_ref_elite._ref_unit)
    ){
        return undefined;
    }

    var _stct_unit =
        _ref_elite._ref_unit;

    if (
        !variable_struct_exists(
            _stct_unit,
            "_flag_elite_soulbound_assignment_initialized"
        )
    ){
        _stct_unit
            ._flag_elite_soulbound_assignment_initialized =
            false;
    }

    //========================//
    //PRESERVE VALID REFERENCE//
    //========================//
    if (
        variable_instance_exists(
            _ref_elite,
            "_ref_elite_soulbound_protected"
        ) &&
        instance_exists(
            _ref_elite
                ._ref_elite_soulbound_protected
        )
    ){
        var _ref_existing =
            _ref_elite
                ._ref_elite_soulbound_protected;

        if (
            _ref_existing != _ref_elite &&
            _ref_existing._str_team ==
                _ref_elite._str_team &&
            _ref_existing._str_list ==
                "ALIVE" &&
            _ref_existing._val_cur_hp > 0
        ){
            _stct_unit
                ._flag_elite_soulbound_assignment_initialized =
                true;

            return _ref_existing;
        }
    }

    //================//
    //GET TEAM LIST//
    //================//
    var _list_allies =
        undefined;

    if (_ref_elite._str_team == "PLAYER"){
        if (
            instance_exists(
                obj_battle_player_controller
            )
        ){
            _list_allies =
                obj_battle_player_controller
                    ._list_beasts_alive;
        }
    }
    else if (_ref_elite._str_team == "ENEMY"){
        if (
            instance_exists(
                obj_battle_enemy_controller
            )
        ){
            _list_allies =
                obj_battle_enemy_controller
                    ._list_beasts_alive;
        }
    }

    if (
        !ds_exists(
            _list_allies,
            ds_type_list
        )
    ){
        return undefined;
    }

    //================//
    //PRESERVE BY UID//
    //================//
    var _uid_existing =
        undefined;

    if (
        variable_struct_exists(
            _stct_unit,
            "_uid_elite_soulbound_protected"
        )
    ){
        _uid_existing =
            _stct_unit
                ._uid_elite_soulbound_protected;
    }

    if (_uid_existing != undefined){
        for (
            var _it_existing = 0;
            _it_existing <
                ds_list_size(
                    _list_allies
                );
            _it_existing++
        ){
            var _ref_existing =
                ds_list_find_value(
                    _list_allies,
                    _it_existing
                );

            if (
                !instance_exists(
                    _ref_existing
                ) ||
                _ref_existing ==
                    _ref_elite
            ){
                continue;
            }

            if (
                _ref_existing._uid_beast ==
                    _uid_existing &&
                _ref_existing._str_list ==
                    "ALIVE" &&
                _ref_existing._val_cur_hp > 0
            ){
                _ref_elite
                    ._ref_elite_soulbound_protected =
                    _ref_existing;

                _stct_unit
                    ._flag_elite_soulbound_assignment_initialized =
                    true;

                return _ref_existing;
            }
        }
    }

    //================================//
    //DO NOT RESELECT AFTER FIRST PICK//
    //================================//
    /*
        Soulbound chooses ONE ally.

        Once the initial assignment has been made, the relationship does not
        jump to a replacement ally if the protected Beast dies or disappears.
    */
    if (
        _stct_unit
            ._flag_elite_soulbound_assignment_initialized
    ){
        _ref_elite
            ._ref_elite_soulbound_protected =
            undefined;

        return undefined;
    }

    //================//
    //BUILD CANDIDATES//
    //================//
    var _arr_candidates = [];

    for (
        var _it_ally = 0;
        _it_ally <
            ds_list_size(
                _list_allies
            );
        _it_ally++
    ){
        var _ref_ally =
            ds_list_find_value(
                _list_allies,
                _it_ally
            );

        if (
            !instance_exists(
                _ref_ally
            ) ||
            _ref_ally ==
                _ref_elite ||
            _ref_ally._str_list !=
                "ALIVE" ||
            _ref_ally._val_cur_hp <= 0
        ){
            continue;
        }

        array_push(
            _arr_candidates,
            _ref_ally
        );
    }

    /*
        Entry assignment is now considered resolved even when no legal ally is
        available. Later summons do not become retroactive Soulbound targets.
    */
    _stct_unit
        ._flag_elite_soulbound_assignment_initialized =
        true;

    if (
        array_length(
            _arr_candidates
        ) <= 0
    ){
        _ref_elite
            ._ref_elite_soulbound_protected =
            undefined;

        _stct_unit
            ._uid_elite_soulbound_protected =
            undefined;

        return undefined;
    }

    //================//
    //SELECT TARGET//
    //================//
    var _ref_protected =
        _arr_candidates[
            irandom(
                array_length(
                    _arr_candidates
                ) - 1
            )
        ];

    _ref_elite
        ._ref_elite_soulbound_protected =
        _ref_protected;

    _stct_unit
        ._uid_elite_soulbound_protected =
        _ref_protected._uid_beast;

    scr_gui_spawn_popup_trigger_banner(
        "SOULBOUND: " +
        string_upper(
            _ref_protected
                ._ref_unit
                ._str_beast_name
        )
    );

    scr_debug_log(
        "BATTLE",
        "ELITE",
        _ref_elite,
        "SOULBOUND TARGET SELECTED" +
        " | PROTECTED: " +
        string_upper(
            _ref_protected
                ._ref_unit
                ._str_beast_name
        ) +
        " | UID: " +
        string(
            _ref_protected
                ._uid_beast
        ),
        "BATTLE",
        "SCR_BATTLE_ELITE_ASSIGN_SOULBOUND"
    );

    return _ref_protected;
}

//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_GET_SOULBOUND_GUARD
// FUNCTION: Returns the active SOULBOUND Elite protecting one Beast.
//
//           Protection is suspended while the Soulbound Elite is Banished,
//           because Banished Beasts cannot trigger effects.
//
// ARGUMENTS: _ref_protected - prospective protected Beast.
//            _arr_visited - optional redirect-chain cycle guard.
// RETURNS: Active SOULBOUND Elite instance, or undefined.
//
//===============================================================================//
function scr_battle_elite_get_soulbound_guard(
    _ref_protected,
    _arr_visited=[]
){
    if (!instance_exists(_ref_protected)){
        return undefined;
    }

    var _list_allies =
        undefined;

    if (_ref_protected._str_team == "PLAYER"){
        if (
            instance_exists(
                obj_battle_player_controller
            )
        ){
            _list_allies =
                obj_battle_player_controller
                    ._list_beasts_alive;
        }
    }
    else if (
        _ref_protected._str_team ==
        "ENEMY"
    ){
        if (
            instance_exists(
                obj_battle_enemy_controller
            )
        ){
            _list_allies =
                obj_battle_enemy_controller
                    ._list_beasts_alive;
        }
    }

    if (
        !ds_exists(
            _list_allies,
            ds_type_list
        )
    ){
        return undefined;
    }

    for (
        var _it_ally = 0;
        _it_ally <
            ds_list_size(
                _list_allies
            );
        _it_ally++
    ){
        var _ref_guard =
            ds_list_find_value(
                _list_allies,
                _it_ally
            );

        if (
            !instance_exists(
                _ref_guard
            ) ||
            _ref_guard ==
                _ref_protected ||
            _ref_guard._str_list !=
                "ALIVE" ||
            _ref_guard._val_cur_hp <= 0 ||
            scr_battle_elite_get_modifier(
                _ref_guard
            ) !=
                "SOULBOUND" ||
            !is_struct(
                _ref_guard._ref_unit
            )
        ){
            continue;
        }

        if (
            is_array(
                _arr_visited
            ) &&
            array_contains(
                _arr_visited,
                _ref_guard
            )
        ){
            continue;
        }

        var _ref_assigned =
            scr_battle_elite_assign_soulbound(
                _ref_guard
            );

        if (
            instance_exists(
                _ref_assigned
            ) &&
            _ref_assigned ==
                _ref_protected
        ){
            return _ref_guard;
        }
    }

    return undefined;
}

//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_TRIGGER_ENTRY_EFFECTS
// FUNCTION: Resolves Elite effects that occur when battle setup completes.
// ARGUMENTS: _list_beasts - battle Beast list.
// RETURNS: Number of entry effects successfully triggered.
//
//===============================================================================//
function scr_battle_elite_trigger_entry_effects(_list_beasts){
    if (!ds_exists(_list_beasts,ds_type_list)){
        return 0;
    }

    var _ct_triggered = 0;

    for (
        var _it_beast = 0;
        _it_beast <
            ds_list_size(
                _list_beasts
            );
        _it_beast++
    ){
        var _ref_beast =
            ds_list_find_value(
                _list_beasts,
                _it_beast
            );

        if (
            !instance_exists(
                _ref_beast
            ) ||
            _ref_beast._val_cur_hp <= 0 ||
            _ref_beast._str_list !=
                "ALIVE"
        ){
            continue;
        }

        var _str_modifier =
            scr_battle_elite_get_modifier(
                _ref_beast
            );

        //===========//
        //ELEMENTAL//
        //===========//
        if (_str_modifier == "ELEMENTAL"){
            if (
                variable_instance_exists(
                    _ref_beast,
                    "_flag_elite_elemental_entry_applied"
                ) &&
                _ref_beast
                    ._flag_elite_elemental_entry_applied
            ){
                continue;
            }

            var _str_variant =
                scr_battle_elite_get_elemental_variant(
                    _ref_beast
                );

            var _str_weather = "";

            switch (_str_variant){
                case "STORM":
                    _str_weather =
                        "STORMING";
                break;

                case "FIRE":
                    _str_weather =
                        "FIRESTORM";
                break;

                case "FROST":
                    _str_weather =
                        "SNOW";
                break;

                case "VERDANT":
                    _str_weather =
                        "SEEDFALL";
                break;
            }

            if (_str_weather == ""){
                continue;
            }

            var _ref_weather =
                scr_status_apply_weather(
                    _str_weather
                );

            if (!instance_exists(_ref_weather)){
                continue;
            }

            _ref_beast
                ._flag_elite_elemental_entry_applied =
                true;

            scr_gui_spawn_popup_trigger_banner(
                "ELEMENTAL: " +
                _str_variant
            );

            scr_debug_log(
                "BATTLE",
                "ELITE",
                _ref_beast,
                "ELEMENTAL ENTRY" +
                " | VARIANT: " +
                _str_variant +
                " | WEATHER: " +
                _str_weather,
                "BATTLE",
                "SCR_BATTLE_ELITE_TRIGGER_ENTRY_EFFECTS"
            );

            _ct_triggered++;

            continue;
        }

        //===========//
        //SOULBOUND//
        //===========//
        if (_str_modifier == "SOULBOUND"){
            var _ref_protected =
                scr_battle_elite_assign_soulbound(
                    _ref_beast
                );

            if (
                instance_exists(
                    _ref_protected
                )
            ){
                _ct_triggered++;
            }
        }
    }

    return _ct_triggered;
}

//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_TRIGGER_TURN_START
// FUNCTION: Resolves Elite mechanics before the host team's normal Status queue.
// ARGUMENTS: _list_beasts_alive - current living team formation.
// RETURNS: Number of Elite effects triggered.
//
//===============================================================================//
function scr_battle_elite_trigger_turn_start(_list_beasts_alive){
    if (!ds_exists(_list_beasts_alive,ds_type_list)){
        return 0;
    }

    /*
        Snapshot the current formation because Phasing removes Beasts from the
        living list while this function is processing them.
    */
    var _arr_beasts = [];

    for (
        var _it_beast = 0;
        _it_beast < ds_list_size(_list_beasts_alive);
        _it_beast++
    ){
        array_push(
            _arr_beasts,
            ds_list_find_value(
                _list_beasts_alive,
                _it_beast
            )
        );
    }

    var _ct_triggered = 0;

    for (
        var _it_beast = 0;
        _it_beast < array_length(_arr_beasts);
        _it_beast++
    ){
        var _ref_beast =
            _arr_beasts[
                _it_beast
            ];

        if (
            !instance_exists(_ref_beast) ||
            _ref_beast._val_cur_hp <= 0 ||
            _ref_beast._str_list != "ALIVE"
        ){
            continue;
        }

        if (
            scr_battle_elite_get_modifier(
                _ref_beast
            ) != "PHASING"
        ){
            continue;
        }

        if (
            !variable_instance_exists(
                _ref_beast,
                "_ct_elite_phasing_turns_seen"
            )
        ){
            _ref_beast
                ._ct_elite_phasing_turns_seen =
                0;
        }

        _ref_beast
            ._ct_elite_phasing_turns_seen++;

        if (
            _ref_beast
                ._ct_elite_phasing_turns_seen
            mod 3 != 0
        ){
            continue;
        }

        //==========================//
        //SNAPSHOT NEGATIVE STATUSES//
        //==========================//
        var _arr_negative = [];

        if (
            ds_exists(
                _ref_beast._list_statuses,
                ds_type_list
            )
        ){
            for (
                var _it_status = 0;
                _it_status <
                    ds_list_size(
                        _ref_beast._list_statuses
                    );
                _it_status++
            ){
                var _ref_status =
                    ds_list_find_value(
                        _ref_beast._list_statuses,
                        _it_status
                    );

                if (!instance_exists(_ref_status)){
                    continue;
                }

                var _flag_negative = (
                    _ref_status._str_status_type ==
                        "DEBUFF" ||
                    _ref_status._str_status_type ==
                        "DOT" ||
                    _ref_status._str_status_type ==
                        "CC"
                );

                if (!_flag_negative){
                    continue;
                }

                /*
                    BANISH is not present yet during the cleanse pass, but exclude
                    it explicitly for cheat/debug re-entry safety.
                */
                if (
                    _ref_status._str_status_name ==
                    "BANISH"
                ){
                    continue;
                }

                array_push(
                    _arr_negative,
                    {
                        _str_status_name :
                            _ref_status
                                ._str_status_name,

                        _str_status_type :
                            _ref_status
                                ._str_status_type,

                        _ct_stacks :
                            max(
                                1,
                                _ref_status
                                    ._ct_status_stacks
                            )
                    }
                );
            }
        }

        //===================//
        //CLEANSE HALF STACKS//
        //===================//
        var _ct_total_stacks_removed = 0;

        for (
            var _it_negative = 0;
            _it_negative <
                array_length(
                    _arr_negative
                );
            _it_negative++
        ){
            var _stct_negative =
                _arr_negative[
                    _it_negative
                ];

            /*
                Leave floor(stacks / 2).
                Therefore remove ceil(stacks / 2).
                A one-stack negative Status is fully removed.
            */
            var _ct_remove =
                ceil(
                    _stct_negative._ct_stacks /
                    2
                );

            var _stct_cleanse =
                scr_status_cleanse(
                    _ref_beast,
                    _stct_negative
                        ._str_status_type,
                    _ct_remove,
                    {
                        _str_mode :
                            "STACKS",

                        _str_status_id :
                            _stct_negative
                                ._str_status_name,

                        /*
                            Phasing explicitly affects EACH negative Status,
                            including normally uncleansable negative effects.
                        */
                        _flag_ignore_uncleansable :
                            true,

                        _flag_show_popups :
                            false
                    }
                );

            if (is_struct(_stct_cleanse)){
                _ct_total_stacks_removed +=
                    _stct_cleanse
                        ._ct_stacks_removed;
            }
        }

        if (_ct_total_stacks_removed > 0){
            scr_battle_vfx_cleanse(
                _ref_beast
            );
        }

        //================//
        //SELF BANISH//
        //================//
        /*
            Call the Banish Status directly. This is an inherent self-effect and
            must not be blocked by the host's own CON resistance.
        */
        var _ref_banish =
            scr_status_cc_banish(
                "APPLY",
                undefined,
                1,
                _ref_beast
            );

        if (!instance_exists(_ref_banish)){
            continue;
        }

        scr_gui_spawn_popup_trigger_banner(
            "PHASING"
        );

        scr_debug_log(
            "BATTLE",
            "ELITE",
            _ref_beast,
            "PHASING TRIGGERED" +
            " | TURN: " +
            string(
                _ref_beast
                    ._ct_elite_phasing_turns_seen
            ) +
            " | NEGATIVE STACKS CLEANSED: " +
            string(
                _ct_total_stacks_removed
            ) +
            " | BANISH: 1 ROUND",
            "BATTLE",
            "SCR_BATTLE_ELITE_TRIGGER_TURN_START"
        );

        _ct_triggered++;
    }

    return _ct_triggered;
}
