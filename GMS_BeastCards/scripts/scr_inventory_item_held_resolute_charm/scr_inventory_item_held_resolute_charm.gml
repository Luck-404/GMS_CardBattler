
 //===============================================================================//
 //
 // SCRIPT: SCR_INVENTORY_ITEM_HELD_RESOLUTE_CHARM
 // FUNCTION: Applies or removes Resolute Charm held item effects.
 //           EQUIP adds 20 Constitution.
 //           UNEQUIP removes the Constitution bonus.
 //
 //===============================================================================//

function scr_inventory_item_held_resolute_charm(_str_state,_stct_item,_stct_target_unit){

    #region VALIDATION

    if (_stct_item == undefined){
        return false;
    }

    if (!is_struct(_stct_target_unit)){
        return false;
    }

    if (!variable_struct_exists(_stct_target_unit,"_val_beast_con_stat")){
        return false;
    }

    #endregion

    #region HANDLE STATE

    switch (_str_state){

        case "EQUIP":

            _stct_target_unit._val_beast_con_stat += 20;

            return true;

        case "UNEQUIP":

            _stct_target_unit._val_beast_con_stat = max(
                0,
                _stct_target_unit._val_beast_con_stat - 20
            );

            return true;
    }

    #endregion

    return false;
}
