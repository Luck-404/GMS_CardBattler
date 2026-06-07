function scr_level_up_beast(_beast)
{
    // dead beasts gain nothing
    if (_beast[?"beast_hp_cur"] <= 0)
        exit;

    //--------------------------------------------------
    // LEVEL
    //--------------------------------------------------
    _beast[?"beast_level"] += 1;

    //--------------------------------------------------
    // SAVE OLD HP RATIO
    //--------------------------------------------------
    var _old_cur = _beast[?"beast_hp_cur"];
    var _old_max = _beast[?"beast_hp_max"];

    var _hp_ratio = 1;

    if (_old_max > 0)
        _hp_ratio = _old_cur / _old_max;

    //--------------------------------------------------
    // RECALCULATE HP
    //--------------------------------------------------
    var _level = _beast[?"beast_level"];

    var _hp_stat = _beast[?"beast_hp_stat"];
    var _hp_modifier = scr_get_beast_grade_modifier(_hp_stat);

    // same formula, but scaled by level
    var _hp_calculated = ceil(
        10 + ((_hp_modifier * 10) * _level) / 4
    );

    ds_map_replace(_beast, "beast_hp_max", _hp_calculated);

    //--------------------------------------------------
    // KEEP SAME HP PERCENT
    //--------------------------------------------------
    var _new_cur = ceil(_hp_calculated * _hp_ratio);

    _new_cur = clamp(_new_cur, 1, _hp_calculated);

    ds_map_replace(_beast, "beast_hp_cur", _new_cur);
}