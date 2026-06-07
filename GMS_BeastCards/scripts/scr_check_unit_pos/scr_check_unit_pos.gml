//
// scr_check_unit_pos(_host)
// Repositions all minions relative to host every step
//
function scr_check_unit_pos(_host)
{
    var _list = _host._minions;
    var _count = ds_list_size(_list);

    if (_count <= 0) exit;

    var _cx = _host.x;
    var _cy = _host.y + 50;

    var _x_spacing = 32;

    // NEW: vertical breathing room (fixes stacking issue)
    var _row_gap = 48;

    //------------------------------------------------------------
    // INDEX ORDERING RULE
    //------------------------------------------------------------
    function get_idx(_i,_host,_count)
    {
        if (_host._team == "PLAYER")
            return (_count - 1) - _i;

        return _i;
    }

    //------------------------------------------------------------------
    // 1 MINION
    //------------------------------------------------------------------
    if (_count == 1)
    {
        var _m = ds_list_find_value(_list, get_idx(0,_host,_count));
        _m.x = _cx;
        _m.y = _cy + _row_gap;
        exit;
    }

    //------------------------------------------------------------------
    // 2 MINIONS
    //------------------------------------------------------------------
    if (_count == 2)
    {
        for (var i = 0; i < 2; i++)
        {
            var _m = ds_list_find_value(_list, get_idx(i,_host,_count));
            _m.x = _cx + (-1 + (i * 2)) * _x_spacing;
            _m.y = _cy + _row_gap;
        }
        exit;
    }

    //------------------------------------------------------------------
    // 3 MINIONS
    //------------------------------------------------------------------
    if (_count == 3)
    {
        ds_list_find_value(_list, get_idx(0,_host,_count)).x = _cx - _x_spacing;
        ds_list_find_value(_list, get_idx(0,_host,_count)).y = _cy + _row_gap;

        ds_list_find_value(_list, get_idx(1,_host,_count)).x = _cx + _x_spacing;
        ds_list_find_value(_list, get_idx(1,_host,_count)).y = _cy + _row_gap;

        ds_list_find_value(_list, get_idx(2,_host,_count)).x = _cx;
        ds_list_find_value(_list, get_idx(2,_host,_count)).y = _cy + _row_gap + 16;

        exit;
    }

    //------------------------------------------------------------------
    // 4 MINIONS (2x2)
    //------------------------------------------------------------------
    if (_count == 4)
    {
        for (var i = 0; i < 4; i++)
        {
            var _row = i div 2;
            var _col = i mod 2;

            var _m = ds_list_find_value(_list, get_idx(i,_host,_count));

            _m.x = _cx + (_col * 2 - 1) * _x_spacing;
            _m.y = _cy + (_row * _row_gap) + 32;
        }
        exit;
    }

    //------------------------------------------------------------------
    // 5 MINIONS
    //------------------------------------------------------------------
    if (_count == 5)
    {
        for (var i = 0; i < 3; i++)
        {
            var _m = ds_list_find_value(_list, get_idx(i,_host,_count));
            _m.x = _cx + (i - 1) * _x_spacing;
            _m.y = _cy + _row_gap;
        }

        for (var i = 0; i < 2; i++)
        {
            var _m = ds_list_find_value(_list, get_idx(3 + i,_host,_count));
            _m.x = _cx + (-0.5 + i) * (_x_spacing * 2);
            _m.y = _cy + (_row_gap * 2);
        }

        exit;
    }

    //------------------------------------------------------------------
    // 6 MINIONS (3x2)
    //------------------------------------------------------------------
    if (_count == 6)
    {
        for (var i = 0; i < 6; i++)
        {
            var _row = i div 3;
            var _col = i mod 3;

            var _m = ds_list_find_value(_list, get_idx(i,_host,_count));

            _m.x = _cx + (_col - 1) * _x_spacing;
            _m.y = _cy + _row * _row_gap + 32;
        }
        exit;
    }

    //------------------------------------------------------------------
    // 7+ FALLBACK
    //------------------------------------------------------------------
    var _cols = 4;

    for (var i = 0; i < _count; i++)
    {
        var _row = i div _cols;
        var _col = i mod _cols;

        var _m = ds_list_find_value(_list, get_idx(i,_host,_count));

        _m.x = _cx + (_col - (_cols - 1) * 0.5) * _x_spacing;
        _m.y = _cy + _row * _row_gap + 32;
    }
}