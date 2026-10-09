//===============================================================================//
//
// SCRIPT: SCR_REWARD_GET_ELITE_RESOURCE_MULTIPLIERS
// FUNCTION: Returns battle-end resource / Risk-Tier reward modifiers supplied by
//           enemy Elites.
//
//           GOLDEN:
//           - Final battle Gold x5.
//
//           ENLIGHTENED:
//           - Base battle EXP per surviving Beast x5.
//
//           RISK TIER 1:
//           - Reward-quality multiplier 1.25x.
//           - This multiplier is consumed by SCR_REWARD_RESOLVE_BATTLE to improve
//             Card rarity distribution and rarer Item-channel chances.
//
//           Gold / EXP Elite modifiers remain non-stacking. Risk Tier uses the
//           highest Elite Risk Tier present in the defeated enemy roster.
//
//===============================================================================//
function scr_reward_get_elite_resource_multipliers(_ref_enemy_controller){
    var _stct_result = {
        _val_gold_multiplier : 1,
        _val_exp_multiplier : 1,
        _flag_golden : false,
        _flag_enlightened : false,
        _val_elite_risk_tier : 0,
        _val_risk_reward_quality_multiplier : 1
    };

    if (!instance_exists(_ref_enemy_controller)){
        return _stct_result;
    }

    if (
        !ds_exists(
            _ref_enemy_controller._list_beasts,
            ds_type_list
        )
    ){
        return _stct_result;
    }

    for (
        var _it_enemy = 0;
        _it_enemy <
            ds_list_size(
                _ref_enemy_controller._list_beasts
            );
        _it_enemy++
    ){
        var _ref_enemy =
            ds_list_find_value(
                _ref_enemy_controller._list_beasts,
                _it_enemy
            );

        if (!instance_exists(_ref_enemy)){
            continue;
        }

        var _str_modifier =
            scr_battle_elite_get_modifier(
                _ref_enemy
            );

        //====================//
        //ELITE RISK TIER//
        //====================//
        if (_str_modifier != ""){
            var _val_enemy_risk_tier = 0;

            if (
                variable_instance_exists(
                    _ref_enemy,
                    "_ref_unit"
                ) &&
                is_struct(_ref_enemy._ref_unit) &&
                variable_struct_exists(
                    _ref_enemy._ref_unit,
                    "_val_elite_risk_tier"
                )
            ){
                _val_enemy_risk_tier =
                    max(
                        0,
                        round(
                            _ref_enemy
                                ._ref_unit
                                ._val_elite_risk_tier
                        )
                    );
            }
            else if (
                variable_instance_exists(
                    _ref_enemy,
                    "_val_elite_risk_tier"
                )
            ){
                _val_enemy_risk_tier =
                    max(
                        0,
                        round(
                            _ref_enemy
                                ._val_elite_risk_tier
                        )
                    );
            }

            _stct_result._val_elite_risk_tier =
                max(
                    _stct_result._val_elite_risk_tier,
                    _val_enemy_risk_tier
                );
        }

        //====================//
        //ELITE MODIFIER//
        //====================//
        switch (_str_modifier){
            case "GOLDEN":
                _stct_result._flag_golden = true;
                _stct_result._val_gold_multiplier = 5;
            break;

            case "ENLIGHTENED":
                _stct_result._flag_enlightened = true;
                _stct_result._val_exp_multiplier = 5;
            break;
        }
    }

    if (_stct_result._val_elite_risk_tier >= 1){
        _stct_result._val_risk_reward_quality_multiplier = 1.25;
    }

    return _stct_result;
}
