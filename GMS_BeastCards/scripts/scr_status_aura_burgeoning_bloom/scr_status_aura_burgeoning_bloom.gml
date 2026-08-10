//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_BURGEONING_BLOOM
// FUNCTION: Handles the Burgeoning Bloom Aura.
//           Unstackable Infinite Self Aura.
//           Reduces the host's Maximum HP by 15% while active.
//           When the host is healed, 25% of actual HP restored
//           is splashed to adjacent allied Beasts.
//
//===============================================================================//
function scr_status_aura_burgeoning_bloom(_str_tag,_ref_status,_val_magnitude=undefined,_val_trigger_amount=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target =
				global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//------------------//
			//DEFAULT MAGNITUDE//
			//------------------//
			if (_val_magnitude == undefined){
				_val_magnitude = 0.25;
			}

			_val_magnitude =
				max(0,_val_magnitude);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"BURGEONING_BLOOM",
					_ref_target
				);

			if (_ref_existing_status != -1){
				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			_ref_new_status._scr_status =
				scr_status_aura_burgeoning_bloom;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"AURA";

			_ref_new_status._str_status_name =
				"BURGEONING_BLOOM";

			_ref_new_status._str_status_desc =
				"HEALING SPLASHES 25% TO ADJACENT ALLIES; MAX HP -15%";

			_ref_new_status._spr_status =
				spr_status_aura_burgeoning_bloom;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._str_trigger_region =
				undefined;

			_ref_new_status._str_aura_scope =
				"SELF";

			_ref_new_status._str_aura_trigger =
				"HEALED";

			//--------------------//
			//CALCULATE HP PENALTY//
			//--------------------//
			var _val_hp_reduction =
				0;

			if (_ref_target._val_max_hp > 1){

				_val_hp_reduction =
					round(
						_ref_target._val_max_hp *
						0.15
					);

				_val_hp_reduction =
					clamp(
						_val_hp_reduction,
						1,
						_ref_target._val_max_hp - 1
					);
			}

			_ref_new_status._val_aura_hp_max_reduction =
				_val_hp_reduction;

			//------------------//
			//REDUCE MAXIMUM HP//
			//------------------//
			_ref_target._val_max_hp -=
				_val_hp_reduction;

			_ref_target._val_max_hp =
				max(
					1,
					_ref_target._val_max_hp
				);

			//----------------//
			//CLAMP CURRENT HP//
			//----------------//
			_ref_target._val_cur_hp =
				min(
					_ref_target._val_cur_hp,
					_ref_target._val_max_hp
				);

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				_ref_target
			);

			return _ref_new_status;

		break;


		//---------//
		//TRIGGER//
		//---------//
		case "TRIGGER":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			if (
				_val_trigger_amount == undefined ||
				_val_trigger_amount <= 0
			){
				return false;
			}

			//--------------------------//
			//CALCULATE SPLASH HEALING//
			//--------------------------//
			var _val_splash_heal =
				round(
					_val_trigger_amount *
					_ref_status._val_status_magnitude
				);

			if (_val_splash_heal <= 0){
				return false;
			}

			//----------------------//
			//GET ADJACENT BEASTS//
			//----------------------//
			var _ref_left_target =
				scr_get_left_target(
					_ref_host
				);

			var _ref_right_target =
				scr_get_right_target(
					_ref_host
				);

			var _flag_healed =
				false;

			//--------------------//
			//HEAL LEFT ADJACENT//
			//--------------------//
			if (
				instance_exists(_ref_left_target) &&
				_ref_left_target._val_cur_hp > 0
			){

				if (
					scr_heal_target(
						_val_splash_heal,
						_ref_left_target,
						false
					)
				){
					_flag_healed = true;
				}
			}

			//---------------------//
			//HEAL RIGHT ADJACENT//
			//---------------------//
			if (
				instance_exists(_ref_right_target) &&
				_ref_right_target._val_cur_hp > 0
			){

				if (
					scr_heal_target(
						_val_splash_heal,
						_ref_right_target,
						false
					)
				){
					_flag_healed = true;
				}
			}

			return _flag_healed;

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			//-------------------//
			//RESTORE MAXIMUM HP//
			//-------------------//
			if (instance_exists(_ref_host)){

				_ref_host._val_max_hp +=
					_ref_status._val_aura_hp_max_reduction;
			}

			//---------------//
			//DESTROY STATUS//
			//---------------//
			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}