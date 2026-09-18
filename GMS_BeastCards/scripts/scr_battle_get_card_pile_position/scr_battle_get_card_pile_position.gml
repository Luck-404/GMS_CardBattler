//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_CARD_PILE_POSITION
// FUNCTION: Returns the centered GUI location for each 75x75 pile icon.
//
//===============================================================================//

function scr_battle_get_card_pile_position(_str_pile){

    var _val_x = 528;
    var _val_y = 956;

    switch (_str_pile){

        case "DECK":
            _val_x = 47.5;
            _val_y = 1006.5;
        break;

        case "DISCARD":
            _val_x = 1008.5;
            _val_y = 894.5;
        break;

        case "EXHAUST":
            _val_x = 1008.5;
            _val_y = 1006.5;
        break;

        case "INVENTORY":
            _val_x = 47.5;
            _val_y = 894.5;
        break;
    }

    return {
        _val_x : _val_x,
        _val_y : _val_y
    };
}
