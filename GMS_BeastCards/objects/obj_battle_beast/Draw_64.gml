//
//
// DRAW GUI: OBJ_BATTLE_BEAST | HANDLE LOGIC OF BEAST
//
//
#region DRAW SELF AND SHADOW
draw_self();


var _scale_x = (_team == "PLAYER") ? 0.2 : -0.2;
var _scale_y = 0.2;

// hover enlarge
if position_meeting(mouse_x, mouse_y, self)
{
	if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_CASTER && _team == "PLAYER"){
		draw_sprite(spr_battle_caster_hover,0,x,y-50);
	}
	if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_TARGET){
		draw_sprite(spr_battle_target_hover,0,x,y-50);
	}	
    _scale_x *= 1.15;
    _scale_y *= 1.15;
}

var _shadow = scr_get_beast_type_shadow(_ref_unit[?"beast_color_type"]);

draw_sprite_ext(_shadow, 0, x, y+16 + 18, 1, 1, 0, c_white, 1);

//DRWA GREY IF IT DOES NOT MEET CASTING CHECKS
if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_CASTER && (_beast_color_check == false || _beast_archetype_check == false || _beast_class_check == false)){
	draw_sprite_ext(_sprite, 0, x, y, _scale_x, _scale_y, 0, c_ltgray, 1);	
} 

//DRAW GRAY IF DOES NOT MEET RANGE CHECK
else if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_TARGET && _beast_range_check == false){
	draw_sprite_ext(_sprite, 0, x, y, _scale_x, _scale_y, 0, c_ltgray, 1);	
} 

//DRAW NORMALLY
else {
	draw_sprite_ext(_sprite, 0, x, y, _scale_x, _scale_y, 0, c_white, 1);
}

//SET DEFAULTS TO AVOID FLICKER
if (obj_battle_player_controller._player_state != PLAYER_STATE.SELECT_CASTER){
	_beast_color_check = true;
	_beast_archetype_check = true;
	_beast_class_check = true;
}

if (obj_battle_player_controller._player_state != PLAYER_STATE.SELECT_TARGET){
	_beast_range_check = true;
}
#endregion

#region DRAW HP BAR

var _bar_w = 96;
var _bar_h = 10;
var _bar_x1 = x - (_bar_w * 0.5);
var _bar_y1 = y - 65;
var _bar_x2 = _bar_x1 + _bar_w;
var _bar_y2 = _bar_y1 + _bar_h;

draw_set_colour(c_red);
draw_rectangle(_bar_x1,_bar_y1,_bar_x2,_bar_y2,false);

var _hp_fill = clamp(_cur_hp / _max_hp,0,1);

draw_set_colour(c_green);
draw_rectangle(
    _bar_x1,
    _bar_y1,
    _bar_x1 + (_bar_w * _hp_fill),
    _bar_y2,
    false
);

if (_overhealth > 0)
{
    var _over_fill = clamp(_overhealth / _max_hp,0,1);

    draw_set_colour(c_lime);
    draw_rectangle(
        _bar_x2,
        _bar_y1,
        _bar_x2 + (_bar_w * _over_fill),
        _bar_y2,
        false
    );
}

draw_set_colour(c_black);
draw_rectangle(_bar_x1,_bar_y1,_bar_x2,_bar_y2,true);

//
// hp text
//
draw_set_font(fnt_gui_small);
draw_set_colour(c_white);

var _hp_text = string(_cur_hp);

if (_overhealth > 0)
{
    _hp_text += "+" + string(_overhealth);
}

_hp_text += "/" + string(_max_hp);

draw_text(
    x - string_width(_hp_text)/2,
    _bar_y1 - 16,
    _hp_text
);

#endregion

#region DRAW ARMOR

if (_armor > 0)
{
    draw_set_font(fnt_gui_small);
    draw_set_colour(c_white);

    draw_text(
        x + 62,
        y - 80,
        string(_armor)
    );
}

#endregion

if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_TARGET){
	if (self == global.caster_beast){
		draw_sprite(spr_battle_caster_hover,0,x,y-50);
	}
}

#region DRAW SELECTION HIGHLIGHT

if (global.caster_beast == self)
{
    draw_set_colour(c_black);
    draw_rectangle(x-70,y-90,x+70,y+90,true);
}

if (global.target_beast == self)
{
    draw_set_colour(c_black);
    draw_rectangle(x-75,y-95,x+75,y+95,true);
}

#endregion

#region DEATH CHECK
if (_cur_hp <= 0)
{
    //
    // kill minions
    //
    for (var _i = ds_list_size(_minions)-1; _i >= 0; _i--)
    {
        var _m = ds_list_find_value(_minions,_i);
        if (instance_exists(_m)) instance_destroy(_m);
    }

    //
    // kill effects
    //
    for (var _i = ds_list_size(_effects)-1; _i >= 0; _i--)
    {
        var _e = ds_list_find_value(_effects,_i);
        if (instance_exists(_e)) instance_destroy(_e);
    }

    //
    // move between lists
    //
    var _alive;
    var _dead;

    if (_team == "PLAYER")
    {
        _alive = obj_battle_player_controller._beasts_alive;
        _dead  = obj_battle_player_controller._beasts_graveyard;
    }
    else
    {
        _alive = obj_battle_enemy_controller._beasts_alive;
        _dead  = obj_battle_enemy_controller._beasts_graveyard;
    }

    ds_list_delete(_alive,_pos);
    ds_list_add(_dead,self);

    //
    // reposition alive
    //
    for (var _i = 0; _i < ds_list_size(_alive); _i++)
    {
        var _b = ds_list_find_value(_alive,_i);
        _b._pos = _i;
        _b.x = scr_get_battle_x(_b._team,_i);
    }

    //
    // reposition dead
    //
    for (var _i = 0; _i < ds_list_size(_dead); _i++)
    {
        var _b = ds_list_find_value(_dead,_i);
        _b.x = scr_get_dead_x(_b._team,_i);
    }

    draw_sprite(spr_battle_enemy_dead,0,x,y);
    exit;
}
#endregion