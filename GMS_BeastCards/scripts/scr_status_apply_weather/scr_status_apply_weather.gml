//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_WEATHER
// FUNCTION: Applies or refreshes a global Weather Status.
//           Reapplying the same Weather refreshes its lifetime.
//           Applying a different Weather removes all current Weather first.
//           Normalizes incoming Weather IDs before resolution.
//           Logs successful Weather starts and refreshes.
//
// ACTIVE WEATHER:
// - FIRESTORM
// - HEATWAVE
// - RAIN
// - SEEDFALL
// - SNOW
// - STORMING
//
// ARGUMENTS: _str_weather_name - Weather ID to apply.
//            _val_lifetime - Optional lifetime override.
// RETURNS: Applied Weather Status, or undefined on failure.
//
//===============================================================================//

function scr_status_apply_weather(_str_weather_name,_val_lifetime=undefined){

    #region VALIDATION

    //----------------------//
    //VALIDATE GLOBAL LIST//
    //----------------------//
    if (!ds_exists(global.list_statuses,ds_type_list)){
        return undefined;
    }

    //================//
    //NORMALIZE NAME//
    //================//
    _str_weather_name =
        string_upper(
            string(
                _str_weather_name
            )
        );

    if (string_pos("WEATHER: ",_str_weather_name) == 1){
        _str_weather_name =
            string_delete(
                _str_weather_name,
                1,
                string_length("WEATHER: ")
            );
    }

    //==========================//
    //VALIDATE REQUESTED WEATHER//
    //==========================//
    switch (_str_weather_name){

        case "FIRESTORM":
        case "HEATWAVE":
        case "RAIN":
        case "SEEDFALL":
        case "SNOW":
        case "STORMING":
        break;

        default:
            return undefined;
    }

    #endregion

    #region CURRENT WEATHER

    var _ref_status = undefined;
    var _str_requested_weather = "WEATHER: " + _str_weather_name;
    var _c_popup = c_aqua;

    //=======================//
    //CHECK CURRENT WEATHER//
    //=======================//
    var _flag_same_weather_active = false;

    for (
        var _it_status = 0;
        _it_status < ds_list_size(global.list_statuses);
        _it_status++
    ){

        var _ref_check_status =
            ds_list_find_value(
                global.list_statuses,
                _it_status
            );

        if (!instance_exists(_ref_check_status)){
            continue;
        }

        if (_ref_check_status._str_status_type != "WEATHER"){
            continue;
        }

        if (_ref_check_status._str_status_name == _str_requested_weather){
            _flag_same_weather_active = true;
            break;
        }
    }

    //===========================//
    //REPLACE DIFFERENT WEATHER//
    //===========================//
    if (!_flag_same_weather_active){
        scr_status_clear_weather();
    }

    #endregion

    #region APPLY WEATHER

    switch (_str_weather_name){

        //==========//
        //FIRESTORM//
        //==========//
        case "FIRESTORM":

            _ref_status =
                scr_status_weather_firestorm(
                    "APPLY",
                    undefined,
                    _val_lifetime
                );

            _c_popup = c_red;

        break;

        //==========//
        //HEATWAVE//
        //==========//
        case "HEATWAVE":

            _ref_status =
                scr_status_weather_heatwave(
                    "APPLY",
                    undefined,
                    _val_lifetime
                );

            _c_popup = c_red;

        break;

        //======//
        //RAIN//
        //======//
        case "RAIN":

            _ref_status =
                scr_status_weather_rain(
                    "APPLY",
                    undefined,
                    _val_lifetime
                );

        break;

        //==========//
        //SEEDFALL//
        //==========//
        case "SEEDFALL":

            _ref_status =
                scr_status_weather_seedfall(
                    "APPLY",
                    undefined,
                    _val_lifetime
                );

            _c_popup = c_black;

        break;

        //======//
        //SNOW//
        //======//
        case "SNOW":

            _ref_status =
                scr_status_weather_snow(
                    "APPLY",
                    undefined,
                    _val_lifetime
                );

        break;

        //==========//
        //STORMING//
        //==========//
        case "STORMING":

            _ref_status =
                scr_status_weather_storming(
                    "APPLY",
                    undefined,
                    _val_lifetime
                );

        break;
    }

    #endregion

    #region FEEDBACK

    if (instance_exists(_ref_status)){

        scr_gui_spawn_popup_scrolling(
            "TEXT",
            _str_requested_weather,
            undefined,
            _c_popup,
            room_width * 0.5,
            room_height * 0.5
        );
    }

    #endregion

    #region DEBUG

    if (instance_exists(_ref_status)){

        var _str_lifetime = "INFINITE";

        if (!_ref_status._flag_status_infinite){
            _str_lifetime =
                string(
                    _ref_status._val_status_lifetime
                );
        }

        scr_debug_log(
            "BATTLE",
            "WEATHER",
            _ref_status,
            (_flag_same_weather_active ? "WEATHER REFRESHED: " : "WEATHER STARTED: ") +
            _str_weather_name +
            " | LIFETIME: " +
            _str_lifetime,
            "BATTLE",
            "SCR_STATUS_APPLY_WEATHER"
        );
    }

    #endregion

    return _ref_status;
}