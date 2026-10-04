//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_STORMGLASS
// FUNCTION: Handles Stormglass Held Item behavior.
//           On battle ENTRY, starts STORMING through the shared Weather
//           applier. The item remains equipped after triggering.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Held Item struct.
//            _ref_target - Persistent Beast struct for EQUIP/UNEQUIP, or the
//                          battle Beast instance for TRIGGER.
// RETURNS: True when the requested state resolves successfully.
//
//===============================================================================//

function scr_inventory_item_held_stormglass(_str_state,_stct_item,_ref_target){

    #region VALIDATION

    if (!is_struct(_stct_item)){
        return false;
    }

    #endregion

    #region HANDLE STATE

    switch (_str_state){

        case "EQUIP":

            return is_struct(_ref_target);

        case "TRIGGER":

            //----------------//
            //VALIDATE HOLDER//
            //----------------//
            if (!instance_exists(_ref_target)){
                return false;
            }

            if (
                _ref_target._str_list != "ALIVE" ||
                _ref_target._val_cur_hp <= 0
            ){
                return false;
            }

            //===================//
            //START ENVIRONMENT//
            //===================//
            var _ref_environment =
                scr_status_apply_weather(
                    "STORMING"
                );

            return instance_exists(_ref_environment);

        case "UNEQUIP":

            return is_struct(_ref_target);
    }

    #endregion

    return false;
}