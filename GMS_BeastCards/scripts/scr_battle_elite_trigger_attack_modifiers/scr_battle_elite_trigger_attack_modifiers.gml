//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_TRIGGER_ATTACK_MODIFIERS
// FUNCTION: Resolves Elite mechanics that occur once after an Attack Card.
//
//           THORNY:
//           - Each Thorny Elite struck by the Attack retaliates once.
//           - Multi-hit Attacks do not trigger multiple retaliations against the
//             same Thorny defender.
//           - Retaliation deals 3 FIXED Neutral damage.
//           - FIXED damage cannot recursively trigger Thorny.
//
//           LEECHING:
//           - After Thorny reactions, a surviving Leeching Elite heals for 10%
//             of enemy Overhealth + HP damage dealt by that Attack.
//           - Armor damage and Minion damage are excluded.
//           - Normal LEECH Buff behavior remains separate and may coexist.
//
// ARGUMENTS: _ref_attacker - Beast that resolved the Attack Card.
//            _stct_card - resolved Attack Card struct.
// RETURNS: True when at least one Elite mechanic triggers.
//
//===============================================================================//
function scr_battle_elite_trigger_attack_modifiers(_ref_attacker,_stct_card){
    #region VALIDATION

    if (!instance_exists(_ref_attacker)){
        return false;
    }

    if (!is_struct(_stct_card)){
        return false;
    }

    if (_stct_card._str_card_type != "ATTACK"){
        return false;
    }

    var _ref_card = global.ref_cast_card;

    if (
        !instance_exists(_ref_card) ||
        !variable_instance_exists(
            _ref_card,
            "_arr_damage_results"
        ) ||
        !is_array(
            _ref_card._arr_damage_results
        )
    ){
        return false;
    }

    var _arr_results =
        _ref_card._arr_damage_results;

    var _flag_triggered = false;

    #endregion

    #region THORNY

    /*
        Thorny is an Attack-level reaction, not a hit-level reaction.

        A Card that hits the same Thorny Elite three times still causes exactly
        one retaliation from that Elite. An AoE Attack may trigger one
        retaliation from EACH distinct Thorny Elite it attacked.
    */

    if (!global.flag_thorns_retaliating){
        var _arr_thorny_triggered = [];

        for (
            var _it_result = 0;
            _it_result <
                array_length(
                    _arr_results
                );
            _it_result++
        ){
            var _stct_result =
                _arr_results[
                    _it_result
                ];

            if (!is_struct(_stct_result)){
                continue;
            }

            if (
                _stct_result._ref_caster !=
                    _ref_attacker
            ){
                continue;
            }

            var _ref_defender =
                _stct_result._ref_target;

            if (
                !instance_exists(
                    _ref_defender
                ) ||
                _ref_defender._str_team ==
                    _ref_attacker._str_team
            ){
                continue;
            }

            if (
                scr_battle_elite_get_modifier(
                    _ref_defender
                ) !=
                "THORNY"
            ){
                continue;
            }

            if (
                array_contains(
                    _arr_thorny_triggered,
                    _ref_defender
                )
            ){
                continue;
            }

            array_push(
                _arr_thorny_triggered,
                _ref_defender
            );

            if (
                !instance_exists(
                    _ref_attacker
                ) ||
                _ref_attacker._val_cur_hp <= 0
            ){
                break;
            }

            global.flag_thorns_retaliating =
                true;

            scr_battle_damage_target(
                "FIXED",
                _ref_defender,
                _ref_attacker,
                3
            );

            global.flag_thorns_retaliating =
                false;

            scr_gui_spawn_popup_trigger_banner(
                "THORNY: 3 RETALIATION"
            );

            scr_debug_log_battle_trigger(
                "ELITE: THORNY",
                _ref_defender,
                _ref_attacker,
                "ATTACK RETALIATION: 3 FIXED",
                "SCR_BATTLE_ELITE_TRIGGER_ATTACK_MODIFIERS"
            );

            _flag_triggered = true;
        }

        global.flag_thorns_retaliating =
            false;
    }

    #endregion

    #region LEECHING

    /*
        Existing normal LEECH is intentionally untouched.

        Elite Leeching is its own inherent modifier and therefore stacks
        independently with a temporary normal LEECH Buff if one is present.
    */

    if (
        instance_exists(
            _ref_attacker
        ) &&
        _ref_attacker._val_cur_hp > 0 &&
        scr_battle_elite_get_modifier(
            _ref_attacker
        ) ==
        "LEECHING"
    ){
        var _val_eligible_damage = 0;

        for (
            var _it_result = 0;
            _it_result <
                array_length(
                    _arr_results
                );
            _it_result++
        ){
            var _stct_result =
                _arr_results[
                    _it_result
                ];

            if (!is_struct(_stct_result)){
                continue;
            }

            if (
                _stct_result._ref_caster !=
                    _ref_attacker
            ){
                continue;
            }

            var _ref_hit_target =
                _stct_result._ref_target;

            if (
                !instance_exists(
                    _ref_hit_target
                ) ||
                _ref_hit_target ==
                    _ref_attacker ||
                _ref_hit_target._str_team ==
                    _ref_attacker._str_team
            ){
                continue;
            }

            //----------------//
            //OVERHEALTH ONLY//
            //----------------//
            if (
                variable_struct_exists(
                    _stct_result,
                    "_val_overhealth_damage"
                ) &&
                is_real(
                    _stct_result
                        ._val_overhealth_damage
                )
            ){
                _val_eligible_damage +=
                    max(
                        0,
                        _stct_result
                            ._val_overhealth_damage
                    );
            }

            //--------//
            //HP ONLY//
            //--------//
            if (
                variable_struct_exists(
                    _stct_result,
                    "_val_hp_damage"
                ) &&
                is_real(
                    _stct_result
                        ._val_hp_damage
                )
            ){
                _val_eligible_damage +=
                    max(
                        0,
                        _stct_result
                            ._val_hp_damage
                    );
            }
        }

        var _val_healing =
            floor(
                _val_eligible_damage *
                0.10
            );

        if (_val_healing > 0){
            scr_battle_heal_target(
                "FIXED",
                _val_healing,
                _ref_attacker
            );

            scr_gui_spawn_popup_trigger_banner(
                "LEECHING: +" +
                string(
                    _val_healing
                ) +
                " HP"
            );

            scr_debug_log_battle_trigger(
                "ELITE: LEECHING",
                _ref_attacker,
                _ref_attacker,
                "OVERHEALTH + HP DAMAGE: " +
                string(
                    _val_eligible_damage
                ) +
                " | HEAL: " +
                string(
                    _val_healing
                ),
                "SCR_BATTLE_ELITE_TRIGGER_ATTACK_MODIFIERS"
            );

            _flag_triggered = true;
        }
    }

    #endregion

    return _flag_triggered;
}
