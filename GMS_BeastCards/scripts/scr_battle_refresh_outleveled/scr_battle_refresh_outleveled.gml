//===============================================================================//
//
// SCRIPT: SCR_BATTLE_REFRESH_OUTLEVELED
// FUNCTION: Recalculates Level disparity for every Beast on both battle teams.
//
//           Team average Level is floored.
//           Each Beast receives one OUTLEVELED stack per complete 5 Levels
//           above the opposing team's average Level.
//
//           Uses each team's complete battle roster so deaths do not alter
//           disparity.
//
// RETURNS: Struct containing both team average Levels.
//
//===============================================================================//

function scr_battle_refresh_outleveled(){

    #region RESULT

    var _stct_result = {
        _val_player_avg_level : 0,
        _val_enemy_avg_level : 0
    };

    #endregion

    #region VALIDATION

    if (
        !instance_exists(obj_battle_player_controller) ||
        !instance_exists(obj_battle_enemy_controller)
    ){
        return _stct_result;
    }

    if (
        !ds_exists(
            obj_battle_player_controller._list_beasts,
            ds_type_list
        ) ||
        !ds_exists(
            obj_battle_enemy_controller._list_beasts,
            ds_type_list
        )
    ){
        return _stct_result;
    }

    #endregion

    #region TEAM AVERAGES

    _stct_result._val_player_avg_level =
        scr_battle_get_team_average_level(
            "PLAYER"
        );

    _stct_result._val_enemy_avg_level =
        scr_battle_get_team_average_level(
            "ENEMY"
        );

    #endregion

    #region PLAYER TEAM

    var _list_player =
        obj_battle_player_controller._list_beasts;

    for (
        var _it_beast = 0;
        _it_beast < ds_list_size(_list_player);
        _it_beast++
    ){

        var _ref_beast =
            ds_list_find_value(
                _list_player,
                _it_beast
            );

        if (!instance_exists(_ref_beast)){
            continue;
        }

        if (!is_struct(_ref_beast._ref_unit)){
            continue;
        }

//====================//
//SNAPSHOT BASE STATS//
//====================//

        if (
            !variable_instance_exists(
                _ref_beast,
                "_val_outleveled_base_hp_stat"
            )
        ){

            _ref_beast._val_outleveled_base_hp_stat =
                _ref_beast._ref_unit._val_beast_hp_stat;

            _ref_beast._val_outleveled_base_con =
                _ref_beast._ref_unit._val_beast_con_stat;

            _ref_beast._val_outleveled_base_ppow =
                _ref_beast._ref_unit._val_beast_ppow_stat;

            _ref_beast._val_outleveled_base_mpow =
                _ref_beast._ref_unit._val_beast_mpow_stat;

            _ref_beast._val_outleveled_base_pdef =
                _ref_beast._ref_unit._val_beast_pdef_stat;

            _ref_beast._val_outleveled_base_mdef =
                _ref_beast._ref_unit._val_beast_mdef_stat;

            _ref_beast._val_outleveled_base_speed =
                _ref_beast._ref_unit._val_beast_speed_stat;
        }

//==================//
//CALCULATE STACKS//
//==================//

        var _ct_stacks =
            scr_battle_get_outleveled_stacks(
                _ref_beast,
                _stct_result._val_enemy_avg_level
            );

        var _ref_status =
            scr_status_check(
                "OUTLEVELED",
                _ref_beast
            );

//================//
//APPLY / REFRESH//
//================//

        if (_ct_stacks > 0){

            if (
                _ref_status != -1 &&
                instance_exists(_ref_status)
            ){

                scr_status_buff_outleveled(
                    "SET",
                    _ref_status,
                    _ct_stacks
                );
            }
            else{

                scr_status_buff_outleveled(
                    "APPLY",
                    undefined,
                    _ct_stacks,
                    _ref_beast
                );
            }
        }

//================//
//REMOVE NO LONGER//
//================//

        else if (
            _ref_status != -1 &&
            instance_exists(_ref_status)
        ){

            scr_status_buff_outleveled(
                "SET",
                _ref_status,
                0
            );
        }
    }

    #endregion

    #region ENEMY TEAM

    var _list_enemy =
        obj_battle_enemy_controller._list_beasts;

    for (
        var _it_beast = 0;
        _it_beast < ds_list_size(_list_enemy);
        _it_beast++
    ){

        var _ref_beast =
            ds_list_find_value(
                _list_enemy,
                _it_beast
            );

        if (!instance_exists(_ref_beast)){
            continue;
        }

        if (!is_struct(_ref_beast._ref_unit)){
            continue;
        }

//====================//
//SNAPSHOT BASE STATS//
//====================//

        if (
            !variable_instance_exists(
                _ref_beast,
                "_val_outleveled_base_hp_stat"
            )
        ){

            _ref_beast._val_outleveled_base_hp_stat =
                _ref_beast._ref_unit._val_beast_hp_stat;

            _ref_beast._val_outleveled_base_con =
                _ref_beast._ref_unit._val_beast_con_stat;

            _ref_beast._val_outleveled_base_ppow =
                _ref_beast._ref_unit._val_beast_ppow_stat;

            _ref_beast._val_outleveled_base_mpow =
                _ref_beast._ref_unit._val_beast_mpow_stat;

            _ref_beast._val_outleveled_base_pdef =
                _ref_beast._ref_unit._val_beast_pdef_stat;

            _ref_beast._val_outleveled_base_mdef =
                _ref_beast._ref_unit._val_beast_mdef_stat;

            _ref_beast._val_outleveled_base_speed =
                _ref_beast._ref_unit._val_beast_speed_stat;
        }

//==================//
//CALCULATE STACKS//
//==================//

        var _ct_stacks =
            scr_battle_get_outleveled_stacks(
                _ref_beast,
                _stct_result._val_player_avg_level
            );

        var _ref_status =
            scr_status_check(
                "OUTLEVELED",
                _ref_beast
            );

//================//
//APPLY / REFRESH//
//================//

        if (_ct_stacks > 0){

            if (
                _ref_status != -1 &&
                instance_exists(_ref_status)
            ){

                scr_status_buff_outleveled(
                    "SET",
                    _ref_status,
                    _ct_stacks
                );
            }
            else{

                scr_status_buff_outleveled(
                    "APPLY",
                    undefined,
                    _ct_stacks,
                    _ref_beast
                );
            }
        }

//================//
//REMOVE NO LONGER//
//================//

        else if (
            _ref_status != -1 &&
            instance_exists(_ref_status)
        ){

            scr_status_buff_outleveled(
                "SET",
                _ref_status,
                0
            );
        }
    }

    #endregion

    #region START PANE

//==========================//
//REFRESH DISPLAYED AVERAGES//
//==========================//

    if (instance_exists(obj_gui_battle_start_pane)){

        obj_gui_battle_start_pane._val_player_avg_level =
            _stct_result._val_player_avg_level;

        obj_gui_battle_start_pane._val_enemy_avg_level =
            _stct_result._val_enemy_avg_level;
    }

    #endregion

    return _stct_result;
}