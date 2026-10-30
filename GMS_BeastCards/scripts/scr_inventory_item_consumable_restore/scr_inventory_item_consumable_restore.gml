//===============================================================================//
// SCRIPT: SCR_INVENTORY_ITEM_CONSUMABLE_RESTORE
// FUNCTION: Shared targeted flat, percent, full-heal, and revive consumable.
//           Failed use has no side effects; target pane owns consumption.
//===============================================================================//
function scr_inventory_item_consumable_restore(_stct_item,_stct_target_unit,_val_popup_x,_val_popup_y){
    if (!is_struct(_stct_item) || !is_struct(_stct_target_unit)) return false;
    if (!variable_struct_exists(_stct_item,"_str_consumable_action")) return false;
    var _str_action = _stct_item._str_consumable_action;
    var _val_hp_max = max(1,_stct_target_unit._val_beast_hp_max);
    var _val_hp_before = clamp(_stct_target_unit._val_beast_hp_cur,0,_val_hp_max);
    var _flag_dead = (_val_hp_before <= 0);
    var _val_amount = 0;
    if (_str_action == "REVIVE"){
        if (!_flag_dead){
            scr_gui_spawn_popup_scrolling("TEXT","NOT DEFEATED",undefined,c_white,_val_popup_x,_val_popup_y);
            return false;
        }
        _val_amount = max(1,ceil(_val_hp_max * _stct_item._val_consumable_amount));
        _stct_target_unit._val_beast_hp_cur = min(_val_hp_max,_val_amount);
        scr_gui_spawn_popup_scrolling("TEXT","REVIVED +"+string(_stct_target_unit._val_beast_hp_cur)+" HP",undefined,c_green,_val_popup_x,_val_popup_y);
        return true;
    }
    if (_flag_dead){
        scr_gui_spawn_popup_scrolling("TEXT","TARGET DEFEATED",undefined,c_white,_val_popup_x,_val_popup_y);
        return false;
    }
    if (_val_hp_before >= _val_hp_max){
        scr_gui_spawn_popup_scrolling("TEXT","FULL HP",undefined,c_white,_val_popup_x,_val_popup_y);
        return false;
    }
    switch (_str_action){
        case "HEAL_FLAT":
            _val_amount = max(0,ceil(_stct_item._val_consumable_amount));
        break;
        case "HEAL_PERCENT":
            _val_amount = max(1,ceil(_val_hp_max * _stct_item._val_consumable_amount));
        break;
        case "HEAL_FULL":
            _val_amount = _val_hp_max - _val_hp_before;
        break;
        default: return false;
    }
    _stct_target_unit._val_beast_hp_cur = min(_val_hp_max,_val_hp_before+_val_amount);
    var _val_healed = _stct_target_unit._val_beast_hp_cur - _val_hp_before;
    if (_val_healed <= 0) return false;
    scr_gui_spawn_popup_scrolling("TEXT","+"+string(_val_healed)+" HP",undefined,c_green,_val_popup_x,_val_popup_y);
    return true;
}
