//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_ROLL_MODIFIER
// FUNCTION: Rolls one currently implemented Elite modifier uniformly.
//
//           REFORGED is intentionally excluded until its Card-reforge mechanic
//           is implemented. Existing legacy/forced Reforged metadata can still
//           be read by presentation/registry code, but new encounters cannot
//           randomly generate it.
//
// ARGUMENTS: None.
// RETURNS: Implemented Elite modifier ID.
//
//===============================================================================//
function scr_battle_elite_roll_modifier(){
    static _arr_elite_modifiers = [
        "BLOODTHIRSTY",
        "ELEMENTAL",
        "ENLIGHTENED",
        "EVASIVE",
        "GOLDEN",
        "HARDY",
        "LEECHING",
        "MARTYR",
        "MONARCH",
        "PHASING",
        "SCHOLARLY",
        "SOULBOUND",
        "THORNY",
        "VENGEFUL"
    ];

    return _arr_elite_modifiers[
        irandom(
            array_length(
                _arr_elite_modifiers
            ) - 1
        )
    ];
}
