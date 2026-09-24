
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ARMOR_OVER_TIME
// FUNCTION: Grants Armor immediately on application and again at each host END.
//
//           Unstackable timed Buff.
//           Reapplication preserves the highest applied Armor magnitude and
//           highest maximum lifetime independently, then resets current
//           lifetime to that maximum.
//
//           Each application immediately grants its own incoming magnitude.
//           All Armor gains use the existing Armor-gain helper.
//
//===============================================================================//

function scr_status_buff_armor_over_time(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

    switch (_str_tag){

        //=======//
        //APPLY//
        //=======//
        case "APPLY":{

            //================//
            //VALIDATE TARGET//
            //================//
            if (!instance_exists(_ref_target)){
                return undefined;
            }

            if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
                return undefined;
            }

            //==========//
            //DEFAULTS//
            //==========//
            if (_val_magnitude == undefined){
                _val_magnitude = 0;
            }

            if (_val_lifetime == undefined){
                _val_lifetime = 1;
            }

            _val_magnitude = max(0,_val_magnitude);
            _val_lifetime = max(1,_val_lifetime);

            //================//
            //CHECK EXISTING//
            //================//
            var _ref_existing_status = scr_status_check(
                "ARMOR_OVER_TIME",
                _ref_target
            );

            //==================//
            //REFRESH EXISTING//
            //==================//
            if (
                _ref_existing_status != -1 &&
                instance_exists(_ref_existing_status)
            ){

                //------------------------//
                //PRESERVE HIGHER MAGNITUDE//
                //------------------------//
                _ref_existing_status._val_status_magnitude = max(
                    _ref_existing_status._val_status_magnitude,
                    _val_magnitude
                );

                //---------------------//
                //PRESERVE MAX LIFETIME//
                //---------------------//
                scr_status_refresh_lifetime(
                    _ref_existing_status,
                    _val_lifetime
                );

                //------------------------//
                //RESET TO MAXIMUM LIFETIME//
                //------------------------//
                _ref_existing_status._val_status_lifetime =
                    _ref_existing_status._val_status_lifetime_max;

                //================//
                //UPDATE TOOLTIP//
                //================//
                _ref_existing_status._str_status_desc =
                    "GAIN APPLIED ARMOR IMMEDIATELY; +" +
                    string(_ref_existing_status._val_status_magnitude) +
                    " ARMOR AT TURN END";

                //======================//
                //GRANT IMMEDIATE ARMOR//
                //======================//
                // The current application grants its incoming amount.
                // A weaker application does not lower the stored magnitude.
                if (_val_magnitude > 0){

					scr_battle_armor_target(
						"FIXED",
						_val_magnitude,
						_ref_target
					);
                }

                scr_status_reposition(_ref_target);

                return _ref_existing_status;
            }

            //================//
            //CREATE STATUS//
            //================//
            var _ref_new_status = instance_create_layer(
                _ref_target.x,
                _ref_target.y,
                "ily_status",
                obj_battle_status
            );

            //================//
            //INIT LIFETIME//
            //================//
            scr_status_init_lifetime(
                _ref_new_status,
                _val_lifetime,
                false,
                false
            );

            //================//
            //STATUS DATA//
            //================//
            _ref_new_status._scr_status =
                scr_status_buff_armor_over_time;

            _ref_new_status._ref_host = _ref_target;

            _ref_new_status._str_status_type = "BUFF";
            _ref_new_status._str_status_name = "ARMOR_OVER_TIME";

            _ref_new_status._str_status_desc =
                "GAIN APPLIED ARMOR IMMEDIATELY; +" +
                string(_val_magnitude) +
                " ARMOR AT TURN END";

            _ref_new_status._spr_status =
                spr_status_buff_armor_over_time;

            _ref_new_status._ct_status_stacks = 1;
            _ref_new_status._flag_status_stackable = false;

            _ref_new_status._val_status_magnitude = _val_magnitude;

            //================//
            //END DECREMENT//
            //================//
            _ref_new_status._str_trigger_region = "END";

            //================//
            //REGISTER STATUS//
            //================//
            ds_list_add(
                _ref_target._list_statuses,
                _ref_new_status
            );

            //======================//
            //GRANT IMMEDIATE ARMOR//
            //======================//
            if (_val_magnitude > 0){

				scr_battle_armor_target(
					"FIXED",
					_val_magnitude,
					_ref_target
				);

            }

            scr_status_reposition(_ref_target);

            return _ref_new_status;
        }

        //========//
        //REPEAT//
        //========//
        case "REPEAT":{

            if (!instance_exists(_ref_status)){
                return undefined;
            }

            var _ref_host = _ref_status._ref_host;

            if (!instance_exists(_ref_host)){

                scr_status_destroy(_ref_status);

                return undefined;
            }

            //================//
            //GRANT END ARMOR//
            //================//
            if (_ref_status._val_status_magnitude > 0){

				scr_battle_armor_target(
					"FIXED",
					_ref_status._val_status_magnitude,
					_ref_host
				);
            }

            //================//
            //UPDATE LIFETIME//
            //================//
            scr_status_tick_lifetime(_ref_status);

            scr_status_reposition(_ref_host);

            return undefined;
        }

        //=======//
        //DEATH//
        //=======//
        case "DEATH":{

            if (instance_exists(_ref_status)){
                scr_status_destroy(_ref_status);
            }

            return undefined;
        }
    }

    return undefined;
}