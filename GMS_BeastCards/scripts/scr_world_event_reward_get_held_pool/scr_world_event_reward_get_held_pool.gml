//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_REWARD_GET_HELD_POOL
// FUNCTION: Returns the curated premium Held Item pool for quality Tier II-IV.
//           Tier II contains strong general equipment; Tier III contains rarer
//           build-defining/event/resource tools; Tier IV contains the strongest
//           unique team-rule and high-impact effects.
//
//===============================================================================//

function scr_world_event_reward_get_held_pool(_str_tier){

	_str_tier =
		string_upper(
			string(
				_str_tier
			)
		);

	switch (_str_tier){

		case "IV":
			return [
				"HELD_AMPLIFYING_BELL",
				"HELD_ARCANE_CAPACITOR",
				"HELD_ARCHMAGES_FOCUS",
				"HELD_BLIGHT_VIAL",
				"HELD_EXPANDED_GRIMOIRE",
				"HELD_FORGOTTEN_MANUSCRIPT",
				"HELD_PHOENIX_EMBER",
				"HELD_POCKET_HIVE",
				"HELD_SEERS_LENS"
			];

		case "III":
			return [
				"HELD_BLOOD_MOON_TALISMAN",
				"HELD_BLOODSTAINED_IDOL",
				"HELD_BLOOMTIDE_CHALICE",
				"HELD_BROOD_TOTEM",
				"HELD_CINDER_CORE",
				"HELD_COLLECTORS_SEAL",
				"HELD_CURSED_IDOL",
				"HELD_DORMANT_POD",
				"HELD_FIRESTORM_LANTERN",
				"HELD_LUCKY_COIN",
				"HELD_RAINCALLER_SHELL",
				"HELD_REGROWTH_CHARM",
				"HELD_SALVAGERS_MAGNET",
				"HELD_SCRIBES_QUILL",
				"HELD_SNOW_GLOBE",
				"HELD_STORMGLASS",
				"HELD_VERDANT_SEED"
			];

		case "II":
		default:
			return [
				"HELD_BATTLE_STANDARD",
				"HELD_BOLSTERING_SHELL",
				"HELD_BURNING_ASH",
				"HELD_CERULEAN_INCENSE",
				"HELD_EMBER_LENS",
				"HELD_EMERALD_TALISMAN",
				"HELD_FLEET_FEATHER",
				"HELD_GOLD_FANG",
				"HELD_HAWKEYE_LENS",
				"HELD_HEALING_FRUIT",
				"HELD_INSPIRING_CHIME",
				"HELD_IRON_SHELL",
				"HELD_MENDING_MOSS",
				"HELD_NEUTRAL_LENS",
				"HELD_POWERFUL_STONE",
				"HELD_PURIFYING_BELL",
				"HELD_QUICKSILK_RIBBON",
				"HELD_RAZOR_FANG",
				"HELD_RESOLUTE_CHARM",
				"HELD_SCHOLARS_RIBBON",
				"HELD_SORCEROUS_GEM",
				"HELD_THORNPLATE",
				"HELD_TIDAL_LENS",
				"HELD_TRAVELERS_BUCKLER",
				"HELD_VERDANT_LENS",
				"HELD_VERMILION_INCENSE",
				"HELD_VIRIDIAN_INCENSE",
				"HELD_VITALITY_ROOT",
				"HELD_WARDING_CRYSTAL"
			];
	}
}
