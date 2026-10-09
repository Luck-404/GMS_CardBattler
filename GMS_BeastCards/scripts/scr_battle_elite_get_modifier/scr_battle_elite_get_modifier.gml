//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_GET_MODIFIER
// FUNCTION: Returns one battle/overworld Beast's Elite modifier ID, or "".
//
//===============================================================================//
function scr_battle_elite_get_modifier(_ref_beast){
    if (!instance_exists(_ref_beast)){
        return "";
    }

    if (
        variable_instance_exists(_ref_beast,"_flag_elite") &&
        _ref_beast._flag_elite &&
        variable_instance_exists(_ref_beast,"_str_elite_modifier")
    ){
        return string_upper(string(_ref_beast._str_elite_modifier));
    }

    var _stct_unit = undefined;

    if (
        variable_instance_exists(_ref_beast,"_ref_unit") &&
        is_struct(_ref_beast._ref_unit)
    ){
        _stct_unit = _ref_beast._ref_unit;
    }
    else if (
        variable_instance_exists(_ref_beast,"_stct_unit") &&
        is_struct(_ref_beast._stct_unit)
    ){
        _stct_unit = _ref_beast._stct_unit;
    }

    if (
        is_struct(_stct_unit) &&
        variable_struct_exists(_stct_unit,"_flag_elite") &&
        _stct_unit._flag_elite &&
        variable_struct_exists(_stct_unit,"_str_elite_modifier")
    ){
        return string_upper(string(_stct_unit._str_elite_modifier));
    }

    return "";
}
