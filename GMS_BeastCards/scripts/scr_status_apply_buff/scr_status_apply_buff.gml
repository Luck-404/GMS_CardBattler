//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_BUFF
// FUNCTION: Applies Buff Statuses through their shared Status callbacks.
//           Passes configurable Magnitude and Lifetime where supported.
//           Infinite Buffs ignore supplied Lifetime.
//           Handles shared Buff VFX, SFX, and application logging.
//
// ARGUMENTS: _str_status_name is the Buff ID; _ref_target is the recipient Beast, or existing global marker for global-hosted buffs; _val_magnitude and _val_lifetime preserve original optional values.
//
// RETURNS: Applied Status instance, or undefined if the application fails.
//
//===============================================================================//

function scr_status_apply_buff(_str_status_name,_ref_target,_val_magnitude=undefined,_val_lifetime=undefined){

	//========================//
	//SNAPSHOT EXISTING STATUS//
	//========================//
	var _ref_existing_status = -1;

	//========================//
	//CHECK VALID BEAST TARGET//
	//========================//
	if (is_real(_ref_target)){

		if (instance_exists(_ref_target)){

			_ref_existing_status = scr_status_check(
				_str_status_name,
				_ref_target
			);
		}
	}

	if (
		_ref_existing_status == -1 &&
		variable_global_exists("list_statuses") &&
		ds_exists(global.list_statuses,ds_type_list)
	){
		_ref_existing_status = scr_status_check(_str_status_name,global.list_statuses);
	}

	var _ct_previous_stacks = 0;
	var _val_previous_lifetime = undefined;

	if (_ref_existing_status != -1 && instance_exists(_ref_existing_status)){
		_ct_previous_stacks = _ref_existing_status._ct_status_stacks;
		_val_previous_lifetime = _ref_existing_status._val_status_lifetime;
	}

	var _ref_applied_status = undefined;

	switch (_str_status_name){

		//=======================//
		//PERSISTENT OVERHEALTH//
		//=======================//
		case "PERSISTENT_OVERHEALTH":

			_ref_applied_status = scr_status_buff_persistent_overhealth(
				"APPLY",
				undefined,
				_val_magnitude,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"+" + string(max(0,_val_magnitude)) +
						" PERSISTENT OVERHEALTH",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//=======================================================================//
		// VERMILION
		//=======================================================================//
			//================//
			//INFERNO ETERNAL//
			//================//
			case "INFERNO_ETERNAL":

				_ref_applied_status = scr_status_buff_inferno_eternal(
					"APPLY",
					undefined,
					_val_magnitude,
					_val_lifetime,
					_ref_target
				);

				if (instance_exists(_ref_applied_status)){

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"INFERNO ETERNAL",
						undefined,
						c_red,
						room_width * 0.5,
						room_height * 0.5
					);
				}

			break;		
	
			//=================//
			//PHOENIX REBIRTH//
			//=================//
			case "PHOENIX_REBIRTH":

				_ref_applied_status = scr_status_buff_phoenix_rebirth("APPLY", undefined, _val_magnitude, _ref_target);

				if (instance_exists(_ref_applied_status)){

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"PHOENIX REBIRTH",
						undefined,
						c_red,
						_ref_target.x,
						_ref_target.y - 48
					);
				}

			break;	
	
			//=============//
			//ENDLESS RAGE//
			//=============//
			case "ENDLESS_RAGE":

				_ref_applied_status = scr_status_buff_endless_rage(
					"APPLY",
					undefined,
					_val_magnitude,
					_val_lifetime,
					_ref_target
				);

				if (instance_exists(_ref_applied_status)){

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"ENDLESS RAGE",
						undefined,
						c_red,
						_ref_target.x,
						_ref_target.y - 48
					);
				}

			break;

		//===========//
		//PYRE WEAPON//
		//===========//
		case "PYRE_WEAPON":

			_ref_applied_status = scr_status_buff_pyre_weapon(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"PYRE WEAPON",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//=============//
		//PAIN RESPONSE//
		//=============//
		case "PAIN_RESPONSE":

			_ref_applied_status = scr_status_buff_pain_response(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"PAIN RESPONSE",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//===========//
		//RELENTLESS//
		//===========//
		case "RELENTLESS":

			_ref_applied_status = scr_status_buff_relentless(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"RELENTLESS",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//===================//
		//MELTING ARMAMENTS//
		//===================//
		case "MELTING_ARMAMENTS":

			_ref_applied_status = scr_status_buff_melting_armaments(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"MELTING ARMAMENTS",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;	
	
		//============//
		//INNER FLAME//
		//============//
		case "INNER_FLAME":

			_ref_applied_status = scr_status_buff_inner_flame("APPLY", undefined, _val_magnitude, _ref_target);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"INNER FLAME",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//----------------//
		//FLAMING LASHES//
		//----------------//
		case "FLAMING_LASHES":

			_ref_applied_status = scr_status_buff_flaming_lashes(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"FLAMING LASHES",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//--------------//
		//MOLTEN AEGIS//
		//--------------//
		case "MOLTEN_AEGIS":

			_ref_applied_status = scr_status_buff_molten_aegis(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"MOLTEN AEGIS",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;		
		
		//=============//
		//BATTLE FRENZY//
		//=============//
		case "BATTLE_FRENZY":

			_ref_applied_status = scr_status_buff_battle_frenzy(
				"APPLY",
				undefined,
				_val_magnitude,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"BATTLE FRENZY",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;		
		
		//------------//
		//LAST STAND//
		//------------//
		case "LAST_STAND":

			_ref_applied_status = scr_status_buff_last_stand(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"LAST STAND",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//---------------//
		//FURNACE HEART//
		//---------------//
		case "FURNACE_HEART":

			_ref_applied_status = scr_status_buff_furnace_heart(
				"APPLY",
				undefined,
				undefined,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"FURNACE HEART",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//-------------//
		//CINDERGUARD//
		//-------------//
		case "CINDERGUARD":

			_ref_applied_status = scr_status_buff_cinderguard(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"CINDERGUARD",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;		
		
		//----------------//
		//BURNING PARRY//
		//----------------//
		case "BURNING_PARRY":

			_ref_applied_status = scr_status_buff_burning_parry(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"BURNING PARRY",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;
		
		//-----------//
		//BACKDRAFT//
		//-----------//
		case "BACKDRAFT":

			_ref_applied_status = scr_status_buff_backdraft(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"BACKDRAFT",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//----------------//
		//BURNING THORNS//
		//----------------//
		case "BURNING_THORNS":

			_ref_applied_status = scr_status_buff_burning_thorns(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"BURNING THORNS",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//=======================================================================//
		// CERULEAN
		//=======================================================================//

		//-------------//
		//ABYSSAL FORM//
		//-------------//
		case "ABYSSAL_FORM":

			_ref_applied_status = scr_status_buff_abyssal_form(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"ABYSSAL FORM",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//---------------//
		//CALL THE DEEP//
		//---------------//
		case "CALL_THE_DEEP":

			_ref_applied_status = scr_status_buff_call_the_deep("APPLY", undefined, _val_magnitude, _ref_target);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"CALL THE DEEP",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//---------------//
		//DEEP MOMENTUM//
		//---------------//
		case "DEEP_MOMENTUM":

			_ref_applied_status = scr_status_buff_deep_momentum(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"DEEP MOMENTUM",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

	//---------------//
	//CRIMSON FOCUS//
	//---------------//
	case "CRIMSON_FOCUS":

		_ref_applied_status = scr_status_buff_crimson_focus(
			"APPLY",
			undefined,
			_val_magnitude,
			_val_lifetime,
			_ref_target
		);

		if (instance_exists(_ref_applied_status)){

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"CRIT CHANCE +" +
					string(_ref_applied_status._val_status_magnitude) +
					"%",
				undefined,
				c_red,
				_ref_target.x,
				_ref_target.y - 48
			);
		}

	break;

		//------------------//
		//ICEBOUND INSTINCT//
		//------------------//
		case "ICEBOUND_INSTINCT":

			_ref_applied_status = scr_status_buff_icebound_instinct(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"ICEBOUND INSTINCT",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//------------------//
		//FROZEN PRECISION//
		//------------------//
		case "FROZEN_PRECISION":

			_ref_applied_status = scr_status_buff_frozen_precision(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"FROZEN PRECISION",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//--------------//
		//FROST WEAPON//
		//--------------//
		case "FROST_WEAPON":

			_ref_applied_status = scr_status_buff_frost_weapon(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"FROST WEAPON",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//--------------//
		//ARCTIC FOCUS//
		//--------------//
		case "ARCTIC_FOCUS":

			_ref_applied_status = scr_status_buff_arctic_focus(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"ARCTIC FOCUS",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//----------//
		//IMMOVABLE//
		//----------//
		case "IMMOVABLE":

			_ref_applied_status = scr_status_buff_immovable(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"IMMOVABLE",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//------------------//
		//SAILOR'S RESOLVE//
		//------------------//
		case "SAILORS_RESOLVE":

			_ref_applied_status = scr_status_buff_sailors_resolve(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"SAILOR'S RESOLVE",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//------------//
		//ICE MIRROR//
		//------------//
		case "ICE_MIRROR":

			_ref_applied_status = scr_status_buff_ice_mirror(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"ICE MIRROR",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//-------------//
		//MANA SPRING//
		//-------------//
		case "MANA_SPRING":

			_ref_applied_status = scr_status_buff_mana_spring(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"MANA SPRING",
					undefined,
					c_blue,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;

		//-------------//
		//RAZOR SHELL//
		//-------------//
		case "RAZOR_SHELL":

			_ref_applied_status = scr_status_buff_razor_shell(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"RAZOR SHELL",
					undefined,
					c_white,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

	//===========//
	//SECOND WIND//
	//===========//
	case "SECOND_WIND":

		_ref_applied_status = scr_status_buff_second_wind("APPLY", undefined, _val_magnitude, _ref_target);

		if (instance_exists(_ref_applied_status)){

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"SECOND WIND",
				undefined,
				c_red,
				_ref_target.x,
				_ref_target.y - 48
			);
		}

	break;

		//----------------//
		//STATIC BARRIER//
		//----------------//
		case "STATIC_BARRIER":

			_ref_applied_status = scr_status_buff_static_barrier(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"STATIC BARRIER",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//--------------//
		//FROZEN ARMOR//
		//--------------//
		case "FROZEN_ARMOR":

			_ref_applied_status = scr_status_buff_frozen_armor(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"FROZEN ARMOR",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//-------------------//
		//DIVINE PROTECTION//
		//-------------------//
		case "DIVINE_PROTECTION":

			_ref_applied_status = scr_status_buff_divine_protection("APPLY", undefined, _val_magnitude, _ref_target);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"DIVINE PROTECTION",
					undefined,
					c_aqua,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//=======================================================================//
		// VIRIDIAN ARCHETYPE / GLOBAL
		//=======================================================================//

		//---------------//
		//APEX PREDATOR//
		//---------------//
		case "APEX_PREDATOR":

			_ref_applied_status = scr_status_buff_apex_predator("APPLY", undefined, _val_magnitude, _ref_target);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"APEX +" + string(_val_magnitude),
					undefined,
					c_green,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//---------------//
		//PLAGUE GARDEN//
		//---------------//
		case "PLAGUE_GARDEN":

			_ref_applied_status = scr_status_buff_plague_garden(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"PLAGUE GARDEN",
					undefined,
					c_green,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;

		//---------------------//
		//HEART OF THE FOREST//
		//---------------------//
		case "HEART_OF_THE_FOREST":

			_ref_applied_status = scr_status_buff_heart_of_the_forest(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"HEART OF THE FOREST",
					undefined,
					c_green,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;

		//---------------//
		//ENDLESS BLOOM//
		//---------------//
		case "ENDLESS_BLOOM":

			_ref_applied_status = scr_status_buff_endless_bloom(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"ENDLESS BLOOM",
					undefined,
					c_green,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;

		//=======================================================================//
		// VIRIDIAN
		//=======================================================================//

		//-----------------//
		//VERDANT INSIGHT//
		//-----------------//
		case "VERDANT_INSIGHT":

			_ref_applied_status = scr_status_buff_verdant_insight(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"VERDANT INSIGHT",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//------------//
		//WILD VIGOR//
		//------------//
		case "WILD_VIGOR":

			_ref_applied_status = scr_status_buff_wild_vigor(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"WILD VIGOR",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//-------//
		//BOOST//
		//-------//
		case "BOOST":

			_ref_applied_status = scr_status_buff_boost(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"BOOST",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//--------------//
		//REGENERATION//
		//--------------//
		case "REGENERATION":

			_ref_applied_status = scr_status_buff_regeneration(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"REGENERATION",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//---------------//
		//PACK INSTINCT//
		//---------------//
		case "PACK_INSTINCT":

			_ref_applied_status = scr_status_buff_pack_instinct(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"PACK INSTINCT",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//------------//
		//TOXIC HIDE//
		//------------//
		case "TOXIC_HIDE":

			_ref_applied_status = scr_status_buff_toxic_hide(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"TOXIC HIDE",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//---------------//
		//NATURE'S BOND//
		//---------------//
		case "NATURES_BOND":

			_ref_applied_status = scr_status_buff_natures_bond(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"NATURE'S BOND",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//----------//
		//MANAVINE//
		//----------//
		case "MANAVINE":

			_ref_applied_status = scr_status_buff_manavine(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"+" + string(_ref_applied_status._val_status_magnitude) + " MANA",
					undefined,
					c_green,
					global.ref_caster_beast.x + irandom_range(-32,32),
					global.ref_caster_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//--------//
		//THORNS//
		//--------//
		case "THORNS":

			_ref_applied_status = scr_status_buff_thorns(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"THORNS",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//=======================================================================//
		// GENERAL / UNCOLORED
		//=======================================================================//

		//-------//
		//TAUNT//
		//-------//
		case "TAUNT":

			_ref_applied_status = scr_status_buff_taunt("APPLY", undefined, _val_lifetime, _ref_target);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"TAUNT",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//-----------------//
		//ARMOR OVER TIME//
		//-----------------//
		case "ARMOR_OVER_TIME":

			_ref_applied_status = scr_status_buff_armor_over_time(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"ARMOR OVER TIME",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//----------//
		//REDIRECT//
		//----------//
		case "REDIRECT":

			_ref_applied_status = scr_status_buff_redirect("APPLY", undefined, _ref_target);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"REDIRECT",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//-------------//
		//SECOND LIFE//
		//-------------//
		case "SECOND_LIFE":

			_ref_applied_status = scr_status_buff_second_life("APPLY", undefined, _val_lifetime, _ref_target);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"SECOND LIFE",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//-------------//
		//INSPIRATION//
		//-------------//
		case "INSPIRATION":

			_ref_applied_status = scr_status_buff_inspiration("APPLY", undefined, _val_lifetime, _ref_target);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"+2 MANA",
					undefined,
					c_black,
					global.ref_caster_beast.x + irandom_range(-32,32),
					global.ref_caster_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//------------//
		//OVERHEALTH//
		//------------//
		case "OVERHEALTH":

			_ref_applied_status = scr_status_buff_overhealth(
				"APPLY",
				undefined,
				_val_magnitude,
				_val_lifetime,
				_ref_target
			);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"+" + string(_ref_applied_status._val_status_magnitude) + " OVERHEALTH",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//--------//
		//DRAW 2//
		//--------//
		case "DRAW_2":

			_ref_applied_status = scr_status_buff_draw_2("APPLY", undefined, _val_lifetime, _ref_target);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"+2 CARD DRAW",
					undefined,
					c_green,
					global.ref_caster_beast.x + irandom_range(-32,32),
					global.ref_caster_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//---------------//
		//MALLEABILITY//
		//---------------//
		case "MALLEABILITY":

			_ref_applied_status = scr_status_buff_malleability("APPLY", undefined, _ref_target);

			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"MALLEABILITY",
					undefined,
					c_white,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;
	}

	//---------------------//
	//VALIDATE APPLICATION//
	//---------------------//
	if (!instance_exists(_ref_applied_status)){
		return undefined;
	}

	//===================//
	//BUFF PRESENTATION//
	//===================//

	//----------------//
	//SELECT BUFF SFX//
	//----------------//
	var _snd_sfx = snd_battle_buff;

	//------------------------//
	//ONLY PLAY ONCE PER CAST//
	//------------------------//
	if (instance_exists(global.ref_cast_card)){

		if (global.ref_cast_card._flag_buff_sfx_played){
			_snd_sfx = undefined;
		}
		else{
			global.ref_cast_card._flag_buff_sfx_played = true;
		}
	}

	//=============//
	//GLOBAL BUFF//
	//=============//
	if (_ref_applied_status._str_status_type == "GLOBAL"){

		scr_battle_vfx(
			_ref_applied_status,
			spr_battle_vfx_global_buff,
			undefined,
			undefined,
			0,
			0,
			1,
			0,
			_snd_sfx
		);
	}

	//===============//
	//TARGETED BUFF//
	//===============//
	else if (instance_exists(_ref_applied_status._ref_host)){

		scr_battle_vfx(
			_ref_applied_status._ref_host,
			spr_battle_vfx_buff,
			undefined,
			undefined,
			0,
			0,
			1,
			0,
			_snd_sfx
		);
	}

	//==================//
	//DEBUG APPLICATION//
	//==================//
	if (_ref_applied_status._str_status_type == "GLOBAL"){

		var _ct_current_stacks = max(1,_ref_applied_status._ct_status_stacks);
		var _ct_added_stacks = max(0,_ct_current_stacks - _ct_previous_stacks);
		var _str_lifetime = "INFINITE";

		if (!_ref_applied_status._flag_status_infinite){
			_str_lifetime = string(_ref_applied_status._val_status_lifetime);
		}

		var _str_message = "";

		if (_ref_applied_status._flag_status_stackable && _ct_added_stacks > 0){

			_str_message =
				"GLOBAL GAINED " + string(_ct_added_stacks) +
				(_ct_added_stacks == 1 ? " STACK" : " STACKS") +
				" OF " + string_upper(_ref_applied_status._str_status_name) +
				" | TOTAL: " + string(_ct_current_stacks) +
				" | LIFETIME: " + _str_lifetime;
		}
		else if (_ct_previous_stacks <= 0){

			_str_message =
				"GLOBAL GAINED " + string_upper(_ref_applied_status._str_status_name) +
				" | LIFETIME: " + _str_lifetime;
		}
		else{

			_str_message =
				"GLOBAL REFRESHED " + string_upper(_ref_applied_status._str_status_name) +
				" | LIFETIME: " + _str_lifetime;
		}

		scr_debug_log(
			"BATTLE",
			"STATUS",
			_ref_applied_status,
			_str_message,
			"BATTLE",
			"SCR_STATUS_APPLY_BUFF"
		);
	}
	else{

		var _ref_log_target = _ref_target;

		if (instance_exists(_ref_applied_status._ref_host)){
			_ref_log_target = _ref_applied_status._ref_host;
		}

		if (instance_exists(_ref_log_target)){

			scr_debug_log_status_application(
				_ref_log_target,
				_ref_applied_status,
				_ct_previous_stacks,
				_val_previous_lifetime,
				"SCR_STATUS_APPLY_BUFF"
			);
		}
	}

	return _ref_applied_status;
}