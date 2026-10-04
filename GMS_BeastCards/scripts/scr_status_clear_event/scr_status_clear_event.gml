//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEAR_EVENT
// FUNCTION: Removes every active global Event Status.
//           Runs each Event's normal DEATH cleanup before removal so persistent
//           VFX, audio, temporary overrides, and other Event-owned state clean up
//           through the Event's authoritative path.
//
// ARGUMENTS: None.
// RETURNS: Number of Event Statuses removed.
//
//===============================================================================//

function scr_status_clear_event(){

    #region VALIDATION

    //----------------------//
    //VALIDATE GLOBAL LIST//
    //----------------------//
    if (!ds_exists(global.list_statuses,ds_type_list)){
        return 0;
    }

    #endregion

    #region REMOVE EVENTS

    var _ct_removed = 0;

    for (
        var _it_status = ds_list_size(global.list_statuses) - 1;
        _it_status >= 0;
        _it_status--
    ){

        var _ref_status =
            ds_list_find_value(
                global.list_statuses,
                _it_status
            );

        if (!instance_exists(_ref_status)){
            continue;
        }

        if (_ref_status._str_status_type != "EVENT"){
            continue;
        }

        //------------------//
        //RUN EVENT CLEANUP//
        //------------------//
        if (
            variable_instance_exists(
                _ref_status,
                "_scr_status"
            ) &&
            is_callable(
                _ref_status._scr_status
            )
        ){

            script_execute(
                _ref_status._scr_status,
                "DEATH",
                _ref_status
            );
        }
        else{
            scr_status_destroy(_ref_status);
        }

        _ct_removed++;
    }

    #endregion

    return _ct_removed;
}