//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_GET_CARD_POOL
// FUNCTION: Returns the special Card ID pool available to an Elite Beast's
//           primary color.
//
//           These Cards are not added to ordinary Beast decks. Elite battle
//           initialization rolls from this pool and persists the exact rolled
//           Card ID on the Elite Beast struct.
//
// ARGUMENTS: _str_color - VIRIDIAN, CERULEAN, or VERMILION.
// RETURNS: New array of eligible Elite Card IDs. Empty for invalid colors.
//
//===============================================================================//

function scr_battle_elite_get_card_pool(_str_color){
	#region NORMALIZE

	_str_color =
		string_upper(
			string(
				_str_color
			)
		);

	#endregion

	#region POOLS

	switch (_str_color){

		//========//
		//CERULEAN//
		//========//
		case "CERULEAN":
			return [
				"CALM_SEAS",
				"CHILLING_WORD",
				"CRYSTAL_SHELL",
				"DENSE_FOG",
				"DROP_ANCHOR",
				"FRACTURE",
				"FROSTBURN_NOVA",
				"FROSTFORM",
				"KRAKENS_CHOSEN",
				"KRAKENSLAM",
				"OCEANS_BLESSING",
				"PULLED_UNDER",
				"ROUGH_SEAS",
				"WINTERS_HOUR"
			];

		//=========//
		//VERMILION//
		//=========//
		case "VERMILION":
			return [
				"ASHEN_FORMATION",
				"BLOODLETTING",
				"BURSTING_METEOR",
				"CHAIN_COMBUSTION",
				"EXSANGUINATE",
				"FIREBALL",
				"RAGEFIRE",
				"RAGING_HOWL",
				"WAR_CRY"
			];

		//========//
		//VIRIDIAN//
		//========//
		case "VIRIDIAN":
			return [
				"BIOSTORM",
				"HONEYED_SCENT",
				"PACK_INSTINCT",
				"SEED_BARRAGE",
				"SEED_THE_FIELD",
				"STAMPEDE",
				"THORN_STORM",
				"TOXIC_ERUPTION",
				"VERDANT_EMBRACE",
				"VIRAL_SURGE",
				"WILDWARD"
			];
	}

	#endregion

	return [];
}
