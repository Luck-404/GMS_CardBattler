//===============================================================================//
//
// SCRIPT: SCR_APPLY_BUFF_STATUS
// FUNCTION: Applies Buff statuses through their shared status callbacks.
//           Passes configurable magnitude and lifetime where supported.
//           Infinite Buffs ignore supplied lifetime.
//
//===============================================================================//

function scr_apply_buff_status(_str_status_name,_val_magnitude=0,_val_lifetime=undefined){

	switch(_str_status_name){

		//=======================================================================//
		// CERULEAN
		//=======================================================================//

		//----------//
		//IMMOVABLE//
		//----------//
		case "IMMOVABLE":

			var _ref_immovable_status =
				scr_status_buff_immovable("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_immovable_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"IMMOVABLE",
					undefined,
					c_aqua,
					global.ref_target_beast.x,
					global.ref_target_beast.y - 48
				);
			}

		break;


		//----------//
		//ICE MIRROR//
		//----------//
		case "ICE_MIRROR":

			var _ref_ice_mirror_status =
				scr_status_buff_ice_mirror("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_ice_mirror_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"ICE MIRROR",
					undefined,
					c_aqua,
					global.ref_target_beast.x,
					global.ref_target_beast.y - 48
				);
			}

		break;


		//-----------//
		//MANA SPRING//
		//-----------//
		case "MANA_SPRING":

			var _ref_mana_spring_status =
				scr_status_buff_mana_spring("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_mana_spring_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"MANA SPRING",
					undefined,
					c_blue,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;


		//-----------//
		//RAZOR SHELL//
		//-----------//
		case "RAZOR_SHELL":

			var _ref_razor_shell_status =
				scr_status_buff_razor_shell("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_razor_shell_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"RAZOR SHELL",
					undefined,
					c_white,
					global.ref_target_beast.x,
					global.ref_target_beast.y - 48
				);
			}

		break;


		//--------------//
		//STATIC BARRIER//
		//--------------//
		case "STATIC_BARRIER":

			var _ref_static_barrier_status =
				scr_status_buff_static_barrier("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_static_barrier_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"STATIC BARRIER",
					undefined,
					c_aqua,
					global.ref_target_beast.x,
					global.ref_target_beast.y - 48
				);
			}

		break;


		//------------//
		//FROZEN ARMOR//
		//------------//
		case "FROZEN_ARMOR":

			var _ref_frozen_armor_status =
				scr_status_buff_frozen_armor("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_frozen_armor_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"FROZEN ARMOR",
					undefined,
					c_aqua,
					global.ref_target_beast.x,
					global.ref_target_beast.y - 48
				);
			}

		break;


		//-----------------//
		//DIVINE PROTECTION//
		//-----------------//
		case "DIVINE_PROTECTION":

			var _ref_divine_protection_status =
				scr_status_buff_divine_protection("APPLY",undefined,_val_magnitude);

			if (_ref_divine_protection_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"DIVINE PROTECTION",
					undefined,
					c_aqua,
					global.ref_target_beast.x,
					global.ref_target_beast.y - 48
				);
			}

		break;


		//=======================================================================//
		// VIRIDIAN ARCHETYPE / GLOBAL
		//=======================================================================//

		//-------------//
		//APEX PREDATOR//
		//-------------//
		case "APEX_PREDATOR":

			var _ref_apex_status =
				scr_status_buff_apex_predator("APPLY",undefined,_val_magnitude);

			if (_ref_apex_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"APEX +" + string(_val_magnitude),
					undefined,
					c_green,
					global.ref_target_beast.x,
					global.ref_target_beast.y - 48
				);
			}

		break;


		//-------------//
		//PLAGUE GARDEN//
		//-------------//
		case "PLAGUE_GARDEN":

			var _ref_plague_garden_status =
				scr_status_buff_plague_garden("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_plague_garden_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"PLAGUE GARDEN",
					undefined,
					c_green,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;


		//-------------------//
		//HEART OF THE FOREST//
		//-------------------//
		case "HEART_OF_THE_FOREST":

			var _ref_heart_status =
				scr_status_buff_heart_of_the_forest("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_heart_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"HEART OF THE FOREST",
					undefined,
					c_green,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;


		//-------------//
		//ENDLESS BLOOM//
		//-------------//
		case "ENDLESS_BLOOM":

			var _ref_endless_bloom_status =
				scr_status_buff_endless_bloom("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_endless_bloom_status != undefined){

				scr_spawn_popup_scrolling(
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

		//---------------//
		//VERDANT INSIGHT//
		//---------------//
		case "VERDANT_INSIGHT":

			var _ref_verdant_insight_status =
				scr_status_buff_verdant_insight("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_verdant_insight_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"VERDANT INSIGHT",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//----------//
		//WILD VIGOR//
		//----------//
		case "WILD_VIGOR":

			var _ref_wild_vigor_status =
				scr_status_buff_wild_vigor("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_wild_vigor_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WILD VIGOR",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//-----//
		//BOOST//
		//-----//
		case "BOOST":

			var _ref_boost_status =
				scr_status_buff_boost("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_boost_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"BOOST",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//------------//
		//REGENERATION//
		//------------//
		case "REGENERATION":

			var _ref_regeneration_status =
				scr_status_buff_regeneration("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_regeneration_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"REGENERATION",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//-------------//
		//PACK INSTINCT//
		//-------------//
		case "PACK_INSTINCT":

			var _ref_pack_instinct_status =
				scr_status_buff_pack_instinct("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_pack_instinct_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"PACK INSTINCT",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//----------//
		//TOXIC HIDE//
		//----------//
		case "TOXIC_HIDE":

			var _ref_toxic_hide_status =
				scr_status_buff_toxic_hide("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_toxic_hide_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"TOXIC HIDE",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//-------------//
		//NATURE'S BOND//
		//-------------//
		case "NATURES_BOND":

			var _ref_natures_bond_status =
				scr_status_buff_natures_bond("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_natures_bond_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"NATURE'S BOND",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//--------//
		//MANAVINE//
		//--------//
		case "MANAVINE":

			var _ref_manavine_status =
				scr_status_buff_manavine("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_manavine_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+" + string(_ref_manavine_status._val_status_magnitude) + " MANA",
					undefined,
					c_green,
					global.ref_caster_beast.x + irandom_range(-32,32),
					global.ref_caster_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//------//
		//THORNS//
		//------//
		case "THORNS":

			var _ref_thorns_status =
				scr_status_buff_thorns("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_thorns_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"THORNS",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//-----//
		//BLOOM//
		//-----//
		case "BLOOM":

			var _ref_bloom_status =
				scr_status_buff_bloom("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_bloom_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"BLOOM +" + string(_val_magnitude) + " OVERHEALTH",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//=======================================================================//
		// GENERAL / UNCOLORED
		//=======================================================================//

		//-----//
		//TAUNT//
		//-----//
		case "TAUNT":

			var _ref_taunt_status =
				scr_status_buff_taunt("APPLY",undefined,_val_lifetime);

			if (_ref_taunt_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"TAUNT",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//---------------//
		//ARMOR OVER TIME//
		//---------------//
		case "ARMOR_OVER_TIME":

			var _ref_armor_status =
				scr_status_buff_armor_over_time("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_armor_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"ARMOR OVER TIME",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//--------//
		//REDIRECT//
		//--------//
		case "REDIRECT":

			var _ref_redirect_status =
				scr_status_buff_redirect("APPLY",undefined);

			if (_ref_redirect_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"REDIRECT",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//-----------//
		//SECOND LIFE//
		//-----------//
		case "SECOND_LIFE":

			var _ref_second_life_status =
				scr_status_buff_second_life("APPLY",undefined,_val_lifetime);

			if (_ref_second_life_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"SECOND LIFE",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//-----------//
		//INSPIRATION//
		//-----------//
		case "INSPIRATION":

			var _ref_inspiration_status =
				scr_status_buff_inspiration("APPLY",undefined,_val_lifetime);

			if (_ref_inspiration_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+2 MANA",
					undefined,
					c_black,
					global.ref_caster_beast.x + irandom_range(-32,32),
					global.ref_caster_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//----------//
		//OVERHEALTH//
		//----------//
		case "OVERHEALTH":

			var _ref_overhealth_status =
				scr_status_buff_overhealth("APPLY",undefined,_val_magnitude,_val_lifetime);

			if (_ref_overhealth_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+" + string(_val_magnitude) + " OVERHEALTH",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//------//
		//DRAW 2//
		//------//
		case "DRAW_2":

			var _ref_draw_status =
				scr_status_buff_draw_2("APPLY",undefined,_val_lifetime);

			if (_ref_draw_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+2 CARD DRAW",
					undefined,
					c_green,
					global.ref_caster_beast.x + irandom_range(-32,32),
					global.ref_caster_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//-------------//
		//MALLEABILITY//
		//-------------//
		case "MALLEABILITY":

			var _ref_malleability_status =
				scr_status_buff_malleability("APPLY",undefined);

			if (_ref_malleability_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"MALLEABILITY",
					undefined,
					c_white,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;
	}
}