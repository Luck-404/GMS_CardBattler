//===============================================================================//
//
// SCRIPT: SCR_ENCOUNTER_GET_PLAYER_AVERAGE_LEVEL
// FUNCTION: Returns the average Level of all Beasts currently owned by the
//           player across both Party and Ranch.
//
//           Party and Ranch are separate storage lists, so every owned Beast
//           contributes once regardless of which group is currently active.
//
// RETURNS: Average owned Beast Level.
//          Returns 1 when no valid Beast structs are available.
//
//===============================================================================//

function scr_encounter_get_player_average_level(){

    #region VARIABLES

    var _val_level_total = 0;
    var _ct_beasts = 0;

    #endregion

    #region PARTY

//================//
//CHECK PARTY LIST//
//================//

    if (
        variable_global_exists("list_player_party") &&
        ds_exists(global.list_player_party,ds_type_list)
    ){

        for (
            var _it_beast = 0;
            _it_beast < ds_list_size(global.list_player_party);
            _it_beast++
        ){

            var _stct_beast =
                ds_list_find_value(
                    global.list_player_party,
                    _it_beast
                );

            if (!is_struct(_stct_beast)){
                continue;
            }

            if (
                !variable_struct_exists(
                    _stct_beast,
                    "_val_beast_level"
                )
            ){
                continue;
            }

            _val_level_total +=
                max(
                    1,
                    _stct_beast._val_beast_level
                );

            _ct_beasts++;
        }
    }

    #endregion

    #region RANCH

//================//
//CHECK RANCH LIST//
//================//

    if (
        variable_global_exists("list_player_ranch") &&
        ds_exists(global.list_player_ranch,ds_type_list)
    ){

        for (
            var _it_beast = 0;
            _it_beast < ds_list_size(global.list_player_ranch);
            _it_beast++
        ){

            var _stct_beast =
                ds_list_find_value(
                    global.list_player_ranch,
                    _it_beast
                );

            if (!is_struct(_stct_beast)){
                continue;
            }

            if (
                !variable_struct_exists(
                    _stct_beast,
                    "_val_beast_level"
                )
            ){
                continue;
            }

            _val_level_total +=
                max(
                    1,
                    _stct_beast._val_beast_level
                );

            _ct_beasts++;
        }
    }

    #endregion

    #region RESULT

//================//
//NO OWNED BEASTS//
//================//

    if (_ct_beasts <= 0){
        return 1;
    }

//================//
//RETURN AVERAGE//
//================//

    return
        _val_level_total /
        _ct_beasts;

    #endregion
}