//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_OUTLEVELED_STACKS
// FUNCTION: Calculates OUTLEVELED stacks for one battle Beast.
//
//           One stack is granted for every complete 5 Levels that the Beast is
//           above the opposing team's floored average Level.
//
// EXAMPLE: Beast Level 7 vs opposing average Level 2 = 1 stack.
//          Beast Level 12 vs opposing average Level 2 = 2 stacks.
//
// ARGUMENTS: _ref_beast
//            _val_opposing_avg_level
//
// RETURNS: OUTLEVELED stack count.
//
//===============================================================================//

function scr_battle_get_outleveled_stacks(
    _ref_beast,
    _val_opposing_avg_level
){

    #region VALIDATION

    if (!instance_exists(_ref_beast)){
        return 0;
    }

    if (!is_struct(_ref_beast._ref_unit)){
        return 0;
    }

    if (!is_real(_val_opposing_avg_level)){
        return 0;
    }

    #endregion

    #region DISPARITY

    var _val_level =
        max(
            1,
            floor(
                _ref_beast._ref_unit._val_beast_level
            )
        );

    var _val_level_difference =
        _val_level -
        floor(_val_opposing_avg_level);

    if (_val_level_difference < 5){
        return 0;
    }

    return max(
        0,
        floor(
            _val_level_difference /
            5
        )
    );

    #endregion
}