//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_DOT
// FUNCTION: Attempts to apply a damage-over-time Status to the supplied target.
//
//           Checks target CON resistance before applying.
//           Handles shared application feedback, debug logging, and DoT Traps.
//
//           BLIGHT VIAL:
//           After a NEW DoT Status is successfully created, if the actual caster
//           is holding HELD_BLIGHT_VIAL and the resulting DoT is stackable,
//           exactly +1 additional stack is added.
//
//           Existing DoTs do not receive another Vial bonus on reapplication.
//           Unstackable DoTs are unchanged.
//
// ARGUMENTS: _str_status_name - DoT ID.
//            _ref_target - Affected Beast.
//            _val_lifetime - Optional lifetime.
//            _flag_trigger_plague_garden - Existing Plague Garden behavior.
// RETURNS: Applied Status instance, or undefined if application fails.
//
//===============================================================================//

function scr_status_apply_dot(_str_status_name,_ref_target,_val_lifetime=undefined,_flag_trigger_plague_garden=true){

//----------------//
//VALIDATE TARGET//
//----------------//

    if (!instance_exists(_ref_target)){
        return undefined;
    }

    if (!is_struct(_ref_target._ref_unit)){
        return undefined;
    }

//========================//
//SNAPSHOT EXISTING STATUS//
//========================//
    var _ref_existing_status = scr_status_check(_str_status_name,_ref_target);

    var _ct_previous_stacks = 0;
    var _val_previous_lifetime = undefined;

    if (_ref_existing_status != -1 && instance_exists(_ref_existing_status)){
        _ct_previous_stacks = _ref_existing_status._ct_status_stacks;
        _val_previous_lifetime = _ref_existing_status._val_status_lifetime;
    }

//================//
//RESIST CHECK//
//================//
    if (scr_status_check_con_resistance(_ref_target,false,_str_status_name)){
        return undefined;
    }

//================//
//APPLY STATUS//
//================//
    var _ref_status = undefined;
    var _str_popup = undefined;
    var _c_popup = c_white;

    switch (_str_status_name){

//==============//
//STORMSTRUCK//
//==============//
        case "STORMSTRUCK":

            _ref_status = scr_status_dot_stormstruck("APPLY", undefined, _val_lifetime, _ref_target);

            _str_popup = "+1 STORMSTRUCK";
            _c_popup = c_aqua;

        break;

//===========//
//FROSTBURN//
//===========//
        case "FROSTBURN":

            _ref_status = scr_status_dot_frostburn("APPLY", undefined, _val_lifetime, _ref_target);

            _str_popup = "+1 FROSTBURN";
            _c_popup = c_aqua;

        break;

//===========//
//FROSTBITE//
//===========//
        case "FROSTBITE":

            _ref_status = scr_status_dot_frostbite("APPLY", undefined, _val_lifetime, _ref_target);

            _str_popup = "+1 FROSTBITE";
            _c_popup = c_aqua;

        break;

//=======//
//BLEED//
//=======//
        case "BLEED":

            _ref_status = scr_status_dot_bleed(
                "APPLY",
                undefined,
                _val_lifetime,
                _flag_trigger_plague_garden,
                _ref_target
            );

            if (instance_exists(_ref_status)){

                var _ct_bleed_added = max(
                    1,
                    _ref_status._ct_status_stacks - _ct_previous_stacks
                );

                _str_popup = "+" + string(_ct_bleed_added) + " BLEED";
            }

            _c_popup = c_maroon;

        break;

//======//
//BURN//
//======//
        case "BURN":

            _ref_status = scr_status_dot_burn(
                "APPLY",
                undefined,
                _val_lifetime,
                undefined,
                _ref_target
            );

            _str_popup = "+1 BURN";
            _c_popup = c_red;

        break;

//========//
//POISON//
//========//
        case "POISON":

            _ref_status = scr_status_dot_poison(
                "APPLY",
                undefined,
                _val_lifetime,
                _flag_trigger_plague_garden,
                _ref_target
            );

            _str_popup = "+1 POISON";
            _c_popup = c_lime;

        break;

//=======//
//VENOM//
//=======//
        case "VENOM":

            _ref_status = scr_status_dot_venom(
                "APPLY",
                undefined,
                _val_lifetime,
                _flag_trigger_plague_garden,
                _ref_target
            );

            _str_popup = "+1 VENOM";
            _c_popup = c_purple;

        break;
    }

//------------------------//
//VALIDATE APPLIED STATUS//
//------------------------//
    if (!instance_exists(_ref_status)){
        return undefined;
    }

//================//
//BLIGHT VIAL//
//================//
    if (
        _ct_previous_stacks <= 0 &&
        variable_instance_exists(
            _ref_status,
            "_flag_status_stackable"
        ) &&
        _ref_status._flag_status_stackable &&
        variable_global_exists(
            "ref_caster_beast"
        ) &&
        instance_exists(
            global.ref_caster_beast
        ) &&
        variable_instance_exists(
            global.ref_caster_beast,
            "_stct_held_item"
        )
    ){

        var _stct_caster_item =
            global.ref_caster_beast
                ._stct_held_item;

        if (
            is_struct(_stct_caster_item) &&
            variable_struct_exists(
                _stct_caster_item,
                "_str_item_id"
            ) &&
            string_upper(
                string(
                    _stct_caster_item
                        ._str_item_id
                )
            ) ==
            "HELD_BLIGHT_VIAL"
        ){

            scr_status_add_blight_vial_stack(
                _str_status_name,
                _ref_status,
                _ref_target,
                _val_lifetime
            );
        }
    }

//========================//
//SYNC POPUP TO REAL GAIN//
//========================//
    var _ct_total_stacks_added =
        max(
            1,
            _ref_status._ct_status_stacks -
            _ct_previous_stacks
        );

    _str_popup =
        "+" +
        string(
            _ct_total_stacks_added
        ) +
        " " +
        string_upper(
            _str_status_name
        );

//================//
//DOT FEEDBACK//
//================//
    if (_str_popup != undefined){

        scr_gui_spawn_popup_scrolling(
            "TEXT",
            _str_popup,
            undefined,
            _c_popup,
            _ref_target.x + irandom_range(-32,32),
            _ref_target.y - 24 + irandom_range(-32,32)
        );
    }

//==================//
//DEBUG APPLICATION//
//==================//
    scr_debug_log_status_application(
        _ref_target,
        _ref_status,
        _ct_previous_stacks,
        _val_previous_lifetime,
        "SCR_STATUS_APPLY_DOT"
    );

//===================//
//CHECK DOT TRAPS//
//===================//
    scr_battle_trigger_dot_traps(_ref_target);

    return _ref_status;
}