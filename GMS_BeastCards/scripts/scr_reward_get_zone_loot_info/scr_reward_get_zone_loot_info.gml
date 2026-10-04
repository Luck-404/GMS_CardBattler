//===============================================================================//
//
// SCRIPT: SCR_REWARD_GET_ZONE_LOOT_INFO
// FUNCTION: Returns the area-specific reward pool assigned to an encounter zone.
//
//           Zone Materials, normal Items, Secret/Quest Items, and Zone Cards are
//           independent from Beast-specific rewards.
//
// ARGUMENTS: _str_loot_zone_id - Logical loot-zone ID stored by encounter zones.
// RETURNS: Zone reward definition struct.
//
//===============================================================================//

function scr_reward_get_zone_loot_info(_str_loot_zone_id){

	#region VARIABLES

	_str_loot_zone_id =
		string_upper(
			string(
				_str_loot_zone_id
			)
		);

	var _str_display_name =
		string_replace_all(
			_str_loot_zone_id,
			"_",
			" "
		);

	var _arr_material_pool = [];
	var _arr_bonus_item_pool = [];
	var _arr_secret_item_pool = [];
	var _arr_card_pool = [];

	#endregion

	#region ZONE LOOT

	switch (_str_loot_zone_id){

		//===================//
		//VIRIDIAN OUTSKIRTS//
		//===================//
		case "VIRIDIAN_OUTSKIRTS":

			_arr_material_pool = [
				"MATERIAL_BLADE_GRASS",
				"MATERIAL_LIGHTWOOD",
				"MATERIAL_LEAF_LITTER"
			];

			_arr_bonus_item_pool = [
				"HELD_BATTLE_STANDARD",
				"HELD_LUCKY_COIN",
				"HELD_TRAVELERS_BUCKLER",
				"HELD_VIRIDIAN_INCENSE"
			];

			_arr_card_pool = [
				"ENTANGLE",
				"LIFEBLOOM",
				"NATURES_MEND",
				"REJUVENATE"
			];

		break;

		//===============//
		//VIRIDIAN WOODS//
		//===============//
		case "VIRIDIAN_WOODS":

			_arr_material_pool = [
				"MATERIAL_LIGHTWOOD",
				"MATERIAL_DARKWOOD",
				"MATERIAL_LEAF_LITTER",
				"MATERIAL_VINES"
			];

			_arr_bonus_item_pool = [
				"HELD_BLOOMTIDE_CHALICE",
				"HELD_BROOD_TOTEM",
				"HELD_DORMANT_POD",
				"HELD_MENDING_MOSS",
				"HELD_THORNPLATE",
				"HELD_VITALITY_ROOT"
			];

			_arr_card_pool = [
				"NATURES_BOND",
				"PREDATORS_MARK",
				"SHIMMERING_SPORES",
				"PACK_INSTINCT"
			];

		break;

		//================//
		//VIRIDIAN JUNGLE//
		//================//
		case "VIRIDIAN_JUNGLE":

			_arr_material_pool = [
				"MATERIAL_DARKWOOD",
				"MATERIAL_LIFEPETAL",
				"MATERIAL_VINES",
				"MATERIAL_SILK"
			];

			_arr_bonus_item_pool = [
				"HELD_BLIGHT_VIAL",
				"HELD_FLEET_FEATHER",
				"HELD_POCKET_HIVE",
				"HELD_QUICKSILK_RIBBON",
				"HELD_VERDANT_LENS"
			];

			_arr_card_pool = [
				"PREDATORY_SCENT",
				"DRAINING_KISS",
				"TOXIC_HIDE",
				"SLEEPING_POLLEN"
			];

		break;

		//==================//
		//VIRIDIAN WETLANDS//
		//==================//
		case "VIRIDIAN_WETLANDS":

			_arr_material_pool = [
				"MATERIAL_SOFTSTONE",
				"MATERIAL_LEAF_LITTER",
				"MATERIAL_VINES",
				"MATERIAL_LIFEPETAL"
			];

			_arr_bonus_item_pool = [
				"HELD_COLLECTORS_SEAL",
				"HELD_PURIFYING_BELL",
				"HELD_RAINCALLER_SHELL",
				"HELD_SCRIBES_QUILL",
				"HELD_SEERS_LENS"
			];

			_arr_card_pool = [
				"LIFEBLOOM",
				"REJUVENATE",
				"POLLINATE",
				"SAPSPRING"
			];

		break;

		//============================//
		//VIRIDIAN / CERULEAN WETLANDS//
		//============================//
		case "VIRIDIAN_CERULEAN_WETLANDS":

			_arr_material_pool = [
				"MATERIAL_SOFTSTONE",
				"MATERIAL_HARDSTONE",
				"MATERIAL_VINES",
				"MATERIAL_LIFEPETAL",
				"MATERIAL_SILK"
			];

			_arr_bonus_item_pool = [
				"HELD_ARCANE_CAPACITOR",
				"HELD_CERULEAN_INCENSE",
				"HELD_HAWKEYE_LENS",
				"HELD_SNOW_GLOBE",
				"HELD_STORMGLASS",
				"HELD_TIDAL_LENS",
				"HELD_WARDING_CRYSTAL"
			];

			_arr_card_pool = [
				"FROSTBOLT",
				"DEEP_CURRENT",
				"RAZOR_FIN",
				"TIDAL_SLASH",
				"POLLINATE"
			];

		break;

		//============================//
		//VIRIDIAN / VERMILION BORDER//
		//============================//
		case "VIRIDIAN_VERMILION_BORDER":

			_arr_material_pool = [
				"MATERIAL_HARDSTONE",
				"MATERIAL_BLADE_GRASS",
				"MATERIAL_IRON",
				"MATERIAL_CRIMSITE",
				"MATERIAL_DARKWOOD"
			];

			_arr_bonus_item_pool = [
				"HELD_BLOOD_MOON_TALISMAN",
				"HELD_BLOODSTAINED_IDOL",
				"HELD_CINDER_CORE",
				"HELD_EMBER_LENS",
				"HELD_FIRESTORM_LANTERN",
				"HELD_IRON_SHELL",
				"HELD_PHOENIX_EMBER",
				"HELD_RAZOR_FANG",
				"HELD_SALVAGERS_MAGNET",
				"HELD_VERMILION_INCENSE"
			];

			_arr_card_pool = [
				"MOLTEN_EDGE",
				"OVERHEAT",
				"OPEN_VEIN",
				"CINDER_KICK",
				"PREDATORS_MARK"
			];

		break;

		//==================//
		//VIRIDIAN DUNGEON//
		//==================//
		case "VIRIDIAN_DUNGEON":

			_arr_material_pool = [
				"MATERIAL_HARDSTONE",
				"MATERIAL_IRON",
				"MATERIAL_CRIMSITE",
				"MATERIAL_ROUGH_BONE"
			];

			_arr_bonus_item_pool = [
				"HELD_AMPLIFYING_BELL",
				"HELD_CURSED_IDOL",
				"HELD_EXPANDED_GRIMOIRE",
				"HELD_NEUTRAL_LENS",
				"HELD_REGROWTH_CHARM",
				"HELD_RESOLUTE_CHARM",
				"HELD_SCHOLARS_RIBBON"
			];

			_arr_card_pool = [
				"NATURES_MEND",
				"POTENT_FRUIT",
				"VERDANT_INSIGHT",
				"PACK_INSTINCT",
				"SLEEPING_POLLEN",
				"VERDANT_EMBRACE"
			];

		break;

		//===========//
		//UNASSIGNED//
		//===========//
		case "UNASSIGNED":
		case "":
		break;

		//=======//
		//UNKNOWN//
		//=======//
		default:

			scr_debug_log(
				"REWARD",
				"ZONE",
				undefined,
				"UNKNOWN LOOT ZONE: " +
				_str_loot_zone_id,
				"WARNING",
				"SCR_REWARD_GET_ZONE_LOOT_INFO"
			);

		break;
	}

	#endregion

	#region RESULT

	return {
		_str_loot_zone_id : _str_loot_zone_id,
		_str_display_name : _str_display_name,

		_arr_material_pool : _arr_material_pool,
		_arr_bonus_item_pool : _arr_bonus_item_pool,
		_arr_secret_item_pool : _arr_secret_item_pool,
		_arr_card_pool : _arr_card_pool
	};

	#endregion
}