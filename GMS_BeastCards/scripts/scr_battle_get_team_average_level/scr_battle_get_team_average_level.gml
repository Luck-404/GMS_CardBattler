//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_TEAM_AVERAGE_LEVEL
// FUNCTION: Returns the floored average Level of every Beast belonging to the
//           requested battle team.
//
//           Uses the team's full battle roster rather than only living Beasts,
//           so deaths do not change Level disparity during the battle.
//
// ARGUMENTS: _str_team - PLAYER or ENEMY.
// RETURNS: Floored average Level, or 0 when no valid Beasts exist.
//
//===============================================================================//

function scr_battle_get_team_average_level(_str_team){

    #region VALIDATION

//================//
//NORMALIZE TEAM//
//================//

    _str_team = string_upper(string(_str_team));

    var _ref_controller = undefined;

//==================//
//SELECT CONTROLLER//
//==================//

    switch (_str_team){

        case "PLAYER":

            if (instance_exists(obj_battle_player_controller)){
                _ref_controller = obj_battle_player_controller;
            }

        break;

        case "ENEMY":

            if (instance_exists(obj_battle_enemy_controller)){
                _ref_controller = obj_battle_enemy_controller;
            }

        break;
    }

    if (!instance_exists(_ref_controller)){
        return 0;
    }

    if (!ds_exists(_ref_controller._list_beasts,ds_type_list)){
        return 0;
    }

    #endregion

    #region AVERAGE LEVEL

//================//
//ACCUMULATE LEVEL//
//================//

    var _val_level_total = 0;
    var _ct_beasts = 0;

    for (
        var _it_beast = 0;
        _it_beast < ds_list_size(_ref_controller._list_beasts);
        _it_beast++
    ){

        var _ref_beast =
            ds_list_find_value(
                _ref_controller._list_beasts,
                _it_beast
            );

        if (!instance_exists(_ref_beast)){
            continue;
        }

        if (!is_struct(_ref_beast._ref_unit)){
            continue;
        }

        var _val_level =
            max(
                1,
                floor(
                    _ref_beast._ref_unit._val_beast_level
                )
            );

        _val_level_total += _val_level;
        _ct_beasts++;
    }

//================//
//RETURN AVERAGE//
//================//

    if (_ct_beasts <= 0){
        return 0;
    }

    return floor(
        _val_level_total /
        _ct_beasts
    );

    #endregion
}