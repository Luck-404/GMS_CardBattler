//===============================================================================//
//
// DRAW GUI: OBJ_GUI_INVENTORY_PANE
// FUNCTION: Inventory pipeline (FILTER → SORT → PAGINATION → DRAW)
//           Includes clickable SORT/FILTER UI + preview modal
//
//===============================================================================//

draw_sprite(spr_gui_inventory_pane, 0, x, y);
draw_set_font(fnt_small_gui);

//------------------------------------------------------------
// STATE RESET
//------------------------------------------------------------
_preview_item = undefined;

var _inv = global.player_inventory;
var _inv_count = ds_list_size(_inv);

//------------------------------------------------------------
// BUILD FILTERED LIST (PIPELINE STEP 1)
//------------------------------------------------------------
var _filtered = ds_list_create();

for (var i = 0; i < _inv_count; i++)
{
    var _it = ds_list_find_value(_inv, i);
    if (_it == undefined) continue;

    if (_filter_mode != "ALL")
    {
        if (_it[?"item_type"] != _filter_mode) continue;
    }

    ds_list_add(_filtered, _it);
}

var _filtered_count = ds_list_size(_filtered);

//------------------------------------------------------------
// SORT PIPELINE STEP 2
//------------------------------------------------------------
function _sort_recent(a, b)
{
    // RECENT = higher index first (simulate via list order reversed)
    return 0; // no-op; already inventory order is recent-first if you append
}

function _sort_alphabetical(a, b)
{
    return string_lower(a[?"item_name"]) > string_lower(b[?"item_name"]);
}

function _sort_type(a, b)
{
    var order = function(t)
    {
        switch (t)
        {
            case "CONSUMABLE": return 0;
            case "EGG":        return 1;
            case "HELD":       return 2;
            case "PRISM":      return 3;
            case "QUEST":      return 4;
        }
        return 99;
    };

    return order(a[?"item_type"]) > order(b[?"item_type"]);
}

// simple bubble-style sort (safe DS_MAP based)
for (var i = 0; i < _filtered_count - 1; i++)
{
    for (var j = i + 1; j < _filtered_count; j++)
    {
        var a = ds_list_find_value(_filtered, i);
        var b = ds_list_find_value(_filtered, j);

        var swap = false;

        switch (_sort_mode)
        {
            case "ALPHABETICAL":
                swap = string_lower(a[?"item_name"]) > string_lower(b[?"item_name"]);
            break;

            case "TYPE":
                swap = (_sort_type(a,b));
            break;

            case "RECENT":
                swap = false; // already in insertion order
            break;
        }

        if (swap)
        {
            ds_list_replace(_filtered, i, b);
            ds_list_replace(_filtered, j, a);
        }
    }
}

//------------------------------------------------------------
// PAGINATION STEP 3
//------------------------------------------------------------
var _per_page = 10;

var _total_pages = max(1, ceil(_filtered_count / _per_page));
_inventory_page = clamp(_inventory_page, 0, _total_pages - 1);

//------------------------------------------------------------
// SLOT LAYOUT (DYNAMIC FIT TO PANE HEIGHT)
//------------------------------------------------------------

// number of visible slots per page
_inventory_per_page = 10;

// usable vertical space inside pane
var _usable_h = _pane_h - 90; // top + bottom padding buffer

// total spacing between slots (9 gaps for 10 items)
var _total_spacing = (_inventory_per_page - 1) * 3;

// compute slot height so everything ALWAYS fits
_slot_spacing = 3;
_slot_h = (_usable_h - _total_spacing) / _inventory_per_page;

// sanity clamp (prevents negative if UI breaks)
_slot_h = max(40, _slot_h);

_slot_w = 770;

_inventory_x = _pane_left + 15;
_start_y = _pane_top + 20;
var _box_x = _inventory_x;

//------------------------------------------------------------
// DRAW ITEMS STEP 4
//------------------------------------------------------------
var _start_index = _inventory_page * _per_page;

for (var i = 0; i < _per_page; i++)
{
    var idx = _start_index + i;
    if (idx >= _filtered_count) break;

    var _item = ds_list_find_value(_filtered, idx);

    var _box_y = _start_y + i * (_slot_h + _slot_spacing);

    //--------------------------------------------------------
    // TYPE COLOR
    //--------------------------------------------------------
    var _slot_color = c_gray;

    switch (_item[?"item_type"])
    {
        case "QUEST":      _slot_color = c_yellow; break;
        case "CONSUMABLE": _slot_color = c_green;  break;
        case "PRISM":      _slot_color = c_aqua;   break;
        case "HELD":       _slot_color = make_colour_rgb(255,140,0); break;
        case "EGG":        _slot_color = make_colour_rgb(180,100,255); break;
    }

    //--------------------------------------------------------
    // SLOT BACKGROUND
    //--------------------------------------------------------
    draw_set_colour(c_black);
    draw_rectangle(_box_x, _box_y, _box_x + _slot_w, _box_y + _slot_h, false);

    draw_set_colour(_slot_color);
    draw_rectangle(_box_x + 2, _box_y + 2, _box_x + _slot_w - 2, _box_y + _slot_h - 2, false);

    //--------------------------------------------------------
    // ITEM SPRITE (LEFT)
    //--------------------------------------------------------
    draw_sprite_ext(
        _item[?"item_sprite"],
        0,
        _box_x + 20,
        _box_y + (_slot_h * 0.5),
        1,
        1,
        0,
        c_white,
        1
    );

    //--------------------------------------------------------
    // TEXT
    //--------------------------------------------------------
    draw_set_colour(c_black);

    var _txt = _item[?"item_name"];

    if (_item[?"item_stackable"])
        _txt += " x" + string(_item[?"item_amount"]);

    draw_text(_box_x + 60, _box_y + 28, _txt);

    //--------------------------------------------------------
    // HOVER (LARGER HIT AREA + STRONGER HIGHLIGHT)
    //--------------------------------------------------------
    var hover =
        device_mouse_x_to_gui(0) > _box_x &&
        device_mouse_x_to_gui(0) < _box_x + _slot_w &&
        device_mouse_y_to_gui(0) > _box_y &&
        device_mouse_y_to_gui(0) < _box_y + _slot_h;

    if (hover)
    {
        draw_set_colour(c_white);
        draw_rectangle(
            _box_x - 2,
            _box_y - 2,
            _box_x + _slot_w + 2,
            _box_y + _slot_h + 2,
            true
        );

        if (keyboard_check(vk_lcontrol))
        {
            _preview_item = _item;
        }
    }
}

//------------------------------------------------------------
// PAGE TEXT
//------------------------------------------------------------
draw_set_colour(c_black);
draw_set_halign(fa_center);
draw_text(
    _page_center_x,
    _page_y,
    "PAGE " + string(_inventory_page + 1) + "/" + string(_total_pages)
);
draw_set_halign(fa_left);

//------------------------------------------------------------
// SORT / FILTER BUTTONS (CLICKABLE TEXT AREAS)
//------------------------------------------------------------
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// SORT (BOTTOM LEFT)
var _sort_x = _pane_left + 20;
var _sort_y = _pane_top + _pane_h - 70;

var sort_hover =
    _mx > _sort_x && _mx < _sort_x + 200 &&
    _my > _sort_y && _my < _sort_y + 25;

draw_set_colour(sort_hover ? c_white : c_gray);
draw_rectangle(_sort_x, _sort_y, _sort_x + 200, _sort_y + 25, false);

draw_set_colour(c_black);
draw_text(_sort_x + 5, _sort_y + 5, "SORT: " + _sort_mode);

// FILTER (BOTTOM RIGHT)
var _filter_x = _pane_left + _pane_w - 220;
var _filter_y = _sort_y;

var filter_hover =
    _mx > _filter_x && _mx < _filter_x + 200 &&
    _my > _filter_y && _my < _filter_y + 25;

draw_set_colour(filter_hover ? c_white : c_gray);
draw_rectangle(_filter_x, _filter_y, _filter_x + 200, _filter_y + 25, false);

draw_set_colour(c_black);
draw_text(_filter_x + 5, _filter_y + 5, "FILTER: " + _filter_mode);

//------------------------------------------------------------
// CLICK INPUT (MODE CYCLING)
//------------------------------------------------------------
if (mouse_check_button_pressed(mb_left))
{
    if (sort_hover)
    {
        switch (_sort_mode)
        {
            case "RECENT": _sort_mode = "TYPE"; break;
            case "TYPE": _sort_mode = "ALPHABETICAL"; break;
            case "ALPHABETICAL": _sort_mode = "RECENT"; break;
        }
    }

    if (filter_hover)
    {
        switch (_filter_mode)
        {
            case "ALL": _filter_mode = "CONSUMABLE"; break;
            case "CONSUMABLE": _filter_mode = "EGG"; break;
            case "EGG": _filter_mode = "HELD"; break;
            case "HELD": _filter_mode = "PRISM"; break;
            case "PRISM": _filter_mode = "QUEST"; break;
            case "QUEST": _filter_mode = "ALL"; break;
        }
    }
}

//------------------------------------------------------------
// PREVIEW MODAL (CTRL HELD)
//------------------------------------------------------------
if (_preview_item != undefined && keyboard_check(vk_lcontrol))
{
    var cx = display_get_gui_width() * 0.5;
    var cy = display_get_gui_height() * 0.5;

    draw_set_colour(c_black);
    draw_rectangle(cx - 300, cy - 300, cx + 300, cy + 300, false);

    draw_sprite_ext(
        _preview_item[?"item_sprite"],
        0,
        cx,
        cy - 40,
        _preview_scale,
        _preview_scale,
        0,
        c_white,
        1
    );

    draw_set_colour(c_white);
    draw_text(cx - 120, cy + 80, _preview_item[?"item_name"]);

    draw_set_colour(c_ltgray);
    draw_text_ext(cx - 120, cy + 100, _preview_item[?"item_desc"], 16, 300);
}