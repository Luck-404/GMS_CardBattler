//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_GET_DAMAGE_MULTIPLIER
// FUNCTION: Returns the Elite modifier's direct Card-damage multiplier.
//           GOLDEN = 1.20x. ENLIGHTENED = 1.50x. Others = 1.00x.
//
//===============================================================================//
function scr_battle_elite_get_damage_multiplier(_ref_caster){
    var _str_modifier = scr_battle_elite_get_modifier(_ref_caster);

    switch (_str_modifier){
        case "GOLDEN":
            return 1.20;

        case "ENLIGHTENED":
            return 1.50;
    }

    return 1;
}
