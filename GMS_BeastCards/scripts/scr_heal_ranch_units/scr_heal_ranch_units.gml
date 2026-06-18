//===============================================================================//
//
// SCR_HEAL_RANCH_UNITS
// FUNCTION: Triggered after battle completion.
//           Heals all beasts currently stored in the ranch.
//           Restores a percentage of each beast's maximum HP.
//           Will not heal beyond maximum HP.
//
//===============================================================================//
function scr_heal_ranch_units(_amount)
{
    // _amount expected as decimal percent
    // Example:
    // 0.33 = 33%
    // 0.50 = 50%
    // 1.00 = full heal

    var _ranch_count = ds_list_size(global.player_ranch);

    for (var _i = 0; _i < _ranch_count; _i++)
    {
        var _beast = ds_list_find_value(global.player_ranch, _i);

        if (_beast == undefined)
            continue;

        var _max_hp = _beast[?"beast_hp_max"];
        var _cur_hp = _beast[?"beast_hp_cur"];

        var _heal_amount = ceil(_max_hp * _amount);

        _cur_hp += _heal_amount;
        _cur_hp = min(_cur_hp, _max_hp);

        _beast[?"beast_hp_cur"] = _cur_hp;
    }
}