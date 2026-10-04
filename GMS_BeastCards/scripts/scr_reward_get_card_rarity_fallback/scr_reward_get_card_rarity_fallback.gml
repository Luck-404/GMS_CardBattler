//===============================================================================//
//
// SCRIPT: SCR_REWARD_GET_CARD_RARITY_FALLBACK
// FUNCTION: Returns the downward rarity-search order for a requested Card rarity.
//
// ARGUMENTS: _str_rarity - Requested rarity.
// RETURNS: Ordered rarity array.
//
//===============================================================================//

function scr_reward_get_card_rarity_fallback(_str_rarity){

	_str_rarity =
		string_upper(
			string(
				_str_rarity
			)
		);

	switch (_str_rarity){

		case "IV":
			return ["IV","III","II","I"];

		case "III":
			return ["III","II","I"];

		case "II":
			return ["II","I"];

		default:
			return ["I"];
	}
}