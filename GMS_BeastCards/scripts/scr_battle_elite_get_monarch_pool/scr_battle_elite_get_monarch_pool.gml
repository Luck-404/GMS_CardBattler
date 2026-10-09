//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_GET_MONARCH_POOL
// FUNCTION: Returns the approved Archetype Card pool for a Monarch Elite's
//           primary color.
//
//           Eligibility requirements are NOT bypassed here. The selected Card is
//           filtered separately against the Beast's Archetype and Class so the
//           Monarch only receives a Card it can legally cast.
//
// ARGUMENTS: _str_color - VIRIDIAN, CERULEAN, or VERMILION.
// RETURNS: New array of approved Archetype Card IDs.
//
//===============================================================================//
function scr_battle_elite_get_monarch_pool(_str_color){
    _str_color = string_upper(string(_str_color));

    switch (_str_color){
        case "CERULEAN":
            return [
                "CALL_THE_DEEP",
                "CERULEAN_GODS_WRATH",
                "ICE_AGE",
                "KRAKEN_AWAKENS",
                "LEVIATHANS_BLESSING",
                "OCEANS_EMBRACE",
                "SHATTERSTORM",
                "THE_ABYSS_STARES_BACK",
                "WINTERS_HOUR"
            ];

        case "VERMILION":
            return [
                "BLOOD_MOON",
                "CATACLYSM",
                "DRAGONSTORM",
                "ENDLESS_RAGE",
                "INFERNO_ETERNAL",
                "MOLTEN_RUIN",
                "PHOENIX_REBIRTH",
                "SACRIFICIAL_PYRE",
                "THE_RED_FEAST"
            ];

        case "VIRIDIAN":
            return [
                "ANCIENT_GROVE",
                "APEX_PREDATOR",
                "CHANNEL_THE_SPIRITS",
                "ENDLESS_BLOOM",
                "FOR_THE_THROAT",
                "HEART_OF_THE_FOREST",
                "PLAGUE_GARDEN",
                "PROLIFERATE"
            ];
    }

    return [];
}