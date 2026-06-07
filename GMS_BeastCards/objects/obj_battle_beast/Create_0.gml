//
//
// CREATE: OBJ_BATTLE_BEAST
//
//

//
//VARIABLES
//
_sprite = undefined;
_uid = -1;
_team = "PLAYER";
_list = "ALIVE";
_pos = -1;
_cur_hp = 1;
_max_hp = 1;
_overhealth = 0;
_armor = 0;
_statuses = ds_list_create();
_minions_max = 1;
_minions = ds_list_create();
_decklist = ds_list_create();
_hand_pos = 0;
_ref_unit = undefined; //stores an exact ref of the rolled or copied unit
_flag_death_handled = false;
_preview_beast = false;

//CHECKS
_beast_color_check = true;
_beast_archetype_check = true;
_beast_class_check = true;
_beast_range_check = true;
_beast_able_check = true;
//
//INIT
//


//
//METHODS
//
function scr_get_battle_x(_team, _pos)
{
    if (_team == "PLAYER")
    {
        return room_width/2 - 80 - (100 * _pos);
    }
    else
    {
        return room_width/2 + 80 + (100 * _pos);
    }
}

function scr_get_dead_x(_team, _alive_count, _dead_pos)
{
    if (_team == "PLAYER")
    {
        return room_width/2 - 80
             - (100 * (_alive_count + _dead_pos));
    }
    else
    {
        return room_width/2 + 80
             + (100 * (_alive_count + _dead_pos));
    }
}