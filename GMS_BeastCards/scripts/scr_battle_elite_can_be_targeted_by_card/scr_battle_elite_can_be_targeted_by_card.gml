//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_CAN_BE_TARGETED_BY_CARD
// FUNCTION: Returns whether one Beast may be directly selected as the target of
//           the supplied Card under Elite modifier rules.
//
//           EVASIVE blocks only direct targeting by RANGED ATTACK Cards.
//           Secondary AoE/adjacent/team effects are not direct selections and
//           therefore remain capable of affecting an Evasive Elite.
//
// ARGUMENTS: _ref_target - candidate battle Beast.
//            _stct_card  - Card struct attempting to select that Beast.
// RETURNS: True when direct selection is allowed; otherwise false.
//
//===============================================================================//
function scr_battle_elite_can_be_targeted_by_card(_ref_target,_stct_card){
    #region VALIDATION

    if (!instance_exists(_ref_target)){
        return false;
    }

    if (!is_struct(_stct_card)){
        return false;
    }

    if (
        !variable_struct_exists(_stct_card,"_str_card_type") ||
        !variable_struct_exists(_stct_card,"_str_card_range")
    ){
        return false;
    }

    #endregion

    #region ELITE TARGETING

    if (
        !variable_instance_exists(_ref_target,"_flag_elite") ||
        !_ref_target._flag_elite
    ){
        return true;
    }

    if (
        !variable_instance_exists(_ref_target,"_str_elite_modifier") ||
        string_upper(string(_ref_target._str_elite_modifier)) != "EVASIVE"
    ){
        return true;
    }

    if (
        string_upper(string(_stct_card._str_card_type)) == "ATTACK" &&
        string_upper(string(_stct_card._str_card_range)) == "RANGED"
    ){
        return false;
    }

    #endregion

    return true;
}
