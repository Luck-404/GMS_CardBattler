//===============================================================================//
//
// SCRIPT: SCR_ENCOUNTER_GET_ZONE_LEVEL_RANGE
// FUNCTION: Returns the temporary encounter Level range associated with the
//           supplied overworld room.
//
// CURRENT TEST RULES:
//
//           CENTER ROOM:       Level 1-5
//           CARDINAL ROOMS:    Level 5-10
//           OTHER ROOMS:       Level 10-15
//
//           Ranch is assigned 1-5 as a safe fallback, although ordinary wild
//           encounters should not normally begin there.
//
//           These values are currently used by encounter-size weighting and
//           will later also drive enemy-Level generation.
//
//===============================================================================//

function scr_encounter_get_zone_level_range(_rm_source){

    #region ROOM NAME

    var _str_room_name = "";

    if (_rm_source != undefined){

        _str_room_name =
            string_upper(
                room_get_name(_rm_source)
            );
    }

    #endregion

    #region CENTER

    switch (_str_room_name){

        case "RM_OW_CENTER":
        case "RM_CENTER":

            return {
                _val_level_min : 1,
                _val_level_max : 5
            };

        break;
    }

    #endregion

    #region RANCH

    switch (_str_room_name){

        case "RM_OW_RANCH":
        case "RM_RANCH":

            return {
                _val_level_min : 1,
                _val_level_max : 5
            };

        break;
    }

    #endregion

    #region CARDINAL ROOMS

    switch (_str_room_name){

        case "RM_OW_NORTH":
        case "RM_OW_SOUTH":
        case "RM_OW_EAST":
        case "RM_OW_WEST":

        case "RM_OW_N":
        case "RM_OW_S":
        case "RM_OW_E":
        case "RM_OW_W":

        case "RM_NORTH":
        case "RM_SOUTH":
        case "RM_EAST":
        case "RM_WEST":

        case "RM_N":
        case "RM_S":
        case "RM_E":
        case "RM_W":

            return {
                _val_level_min : 5,
                _val_level_max : 10
            };

        break;
    }

    #endregion

    #region OTHER ROOMS

//================//
//CURRENT FALLBACK//
//================//

    return {
        _val_level_min : 10,
        _val_level_max : 15
    };

    #endregion
}