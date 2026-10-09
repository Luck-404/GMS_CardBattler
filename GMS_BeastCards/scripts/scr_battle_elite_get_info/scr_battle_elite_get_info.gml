//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_GET_INFO
// FUNCTION: Returns static presentation/design metadata for one Elite modifier.
//
//           _flag_elite_mechanic_active reports whether the modifier's gameplay
//           mechanic is installed in the current Elite implementation.
//           REFORGED remains intentionally deferred.
//
//===============================================================================//
function scr_battle_elite_get_info(_str_modifier){
    _str_modifier = string_upper(string(_str_modifier));

    var _stct_info = {
        _str_elite_id : _str_modifier,
        _str_elite_name : "",
        _str_elite_desc : "",
        _c_elite_tint : c_white,
        _spr_elite_icon : undefined,
        _spr_elite_vfx : undefined,
        _flag_elite_mechanic_active : false
    };

    switch (_str_modifier){
        case "BLOODTHIRSTY":
            _stct_info._str_elite_name = "BLOODTHIRSTY";
            _stct_info._str_elite_desc = "Critical Hit Chance +25 percentage points. Final Maximum HP reduced by 50%.";
            _stct_info._c_elite_tint = make_colour_rgb(190,30,35);
            _stct_info._flag_elite_mechanic_active = true;
        break;

        case "ELEMENTAL":
            _stct_info._str_elite_name = "ELEMENTAL";
            _stct_info._str_elite_desc = "Storm: immune to Stormstruck + Storming. Fire: immune to Burn/Char + Firestorm. Frost: immune to Frostbite/Frostburn + Snow. Verdant: immune to Poison + Seedfall.";
            _stct_info._c_elite_tint = make_colour_rgb(100,190,240);
            _stct_info._flag_elite_mechanic_active = true;

        break;

        case "ENLIGHTENED":
            _stct_info._str_elite_name = "ENLIGHTENED";
            _stct_info._str_elite_desc = "Deals 50% more damage. Battle rewards grant 5x EXP.";
            _stct_info._c_elite_tint = make_colour_rgb(245,245,190);
            _stct_info._flag_elite_mechanic_active = true;

        break;

        case "EVASIVE":
            _stct_info._str_elite_name = "EVASIVE";
            _stct_info._str_elite_desc = "Cannot be directly targeted by Ranged Attacks. Secondary area hits can still affect it.";
            _stct_info._c_elite_tint = make_colour_rgb(100,220,255);
            _stct_info._flag_elite_mechanic_active = true;
        break;

        case "GOLDEN":
            _stct_info._str_elite_name = "GOLDEN";
            _stct_info._str_elite_desc = "Deals 20% more damage. Battle rewards grant 5x Gold.";
            _stct_info._c_elite_tint = make_colour_rgb(235,190,45);
            _stct_info._flag_elite_mechanic_active = true;

        break;

        case "HARDY":
            _stct_info._str_elite_name = "HARDY";
            _stct_info._str_elite_desc = "CON +50% after Elite primary stats. Final Maximum HP +10%. Immune to repositioning.";
            _stct_info._c_elite_tint = make_colour_rgb(155,165,175);
            _stct_info._flag_elite_mechanic_active = true;
        break;

        case "LEECHING":
            _stct_info._str_elite_name = "LEECHING";
            _stct_info._str_elite_desc = "Attacks Leech 10% of damage dealt to target Overhealth and HP. Armor and Minion damage do not count.";
            _stct_info._c_elite_tint = make_colour_rgb(160,55,120);
            _stct_info._flag_elite_mechanic_active = true;
        break;

        case "MARTYR":
            _stct_info._str_elite_name = "MARTYR";
            _stct_info._str_elite_desc = "On death, grants living allied Beasts permanent, uncleansable MARTYRS_GIFT: +25% to all primary stats per stack.";
            _stct_info._c_elite_tint = make_colour_rgb(245,235,175);
            _stct_info._flag_elite_mechanic_active = true;

        break;

        case "MONARCH":
            _stct_info._str_elite_name = "MONARCH";
            _stct_info._str_elite_desc = "Gains one persisted legal Archetype Card from its color's approved Monarch pool.";
            _stct_info._c_elite_tint = make_colour_rgb(205,155,45);
            _stct_info._flag_elite_mechanic_active = true;
        break;

        case "PHASING":
            _stct_info._str_elite_name = "PHASING";
            _stct_info._str_elite_desc = "Every third own turn, halve the stacks of each negative Status, then Banish for one round and become untargetable.";
            _stct_info._c_elite_tint = make_colour_rgb(165,115,225);
            _stct_info._flag_elite_mechanic_active = true;

        break;

        case "REFORGED":
            _stct_info._str_elite_name = "REFORGED";
            _stct_info._str_elite_desc = "DEFERRED. Planned: each Card receives one random legal Reforge effect.";
            _stct_info._c_elite_tint = make_colour_rgb(210,125,70);
        break;

        case "SCHOLARLY":
            _stct_info._str_elite_name = "SCHOLARLY";
            _stct_info._str_elite_desc = "Draws and plays 2 Cards instead of 1 each turn and gains one additional Elite-pool Card.";
            _stct_info._c_elite_tint = make_colour_rgb(105,145,235);
            _stct_info._flag_elite_mechanic_active = true;
        break;

        case "SOULBOUND":
            _stct_info._str_elite_name = "SOULBOUND";
            _stct_info._str_elite_desc = "Chooses one ally once. All damage that ally would take is redirected to the Elite while the Elite remains alive and active.";
            _stct_info._c_elite_tint = make_colour_rgb(105,210,205);
            _stct_info._flag_elite_mechanic_active = true;

        break;

        case "THORNY":
            _stct_info._str_elite_name = "THORNY";
            _stct_info._str_elite_desc = "Permanent Thorns: deal 3 damage back for every Attack against this Elite.";
            _stct_info._c_elite_tint = make_colour_rgb(75,165,80);
            _stct_info._flag_elite_mechanic_active = true;
        break;

        case "VENGEFUL":
            _stct_info._str_elite_name = "VENGEFUL";
            _stct_info._str_elite_desc = "Gains +10% to all primary stats for every counted dead starting ally. The Elite badge shows the current Vengeful stack count.";
            _stct_info._c_elite_tint = make_colour_rgb(170,55,60);
            _stct_info._flag_elite_mechanic_active = true;

        break;

        default:
            return undefined;
    }

    return _stct_info;
}
