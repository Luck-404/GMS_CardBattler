//===============================================================================//
//
// SCRIPT: SCR_REWARD_GET_GLOBAL_CARD_POOL
// FUNCTION: Returns the game's global Card ID array for one rarity.
//
// ARGUMENTS: _str_rarity - I / II / III / IV.
// RETURNS: Card ID array. Empty when no valid pool exists.
//
//===============================================================================//

function scr_reward_get_global_card_pool(_str_rarity){

	_str_rarity =
		string_upper(
			string(
				_str_rarity
			)
		);

	switch (_str_rarity){

		case "I":
			if (
				variable_global_exists("arr_pool_cards_rarity_I") &&
				is_array(global.arr_pool_cards_rarity_I)
			){
				return global.arr_pool_cards_rarity_I;
			}
		break;

		case "II":
			if (
				variable_global_exists("arr_pool_cards_rarity_II") &&
				is_array(global.arr_pool_cards_rarity_II)
			){
				return global.arr_pool_cards_rarity_II;
			}
		break;

		case "III":
			if (
				variable_global_exists("arr_pool_cards_rarity_III") &&
				is_array(global.arr_pool_cards_rarity_III)
			){
				return global.arr_pool_cards_rarity_III;
			}
		break;

		case "IV":
			if (
				variable_global_exists("arr_pool_cards_rarity_IV") &&
				is_array(global.arr_pool_cards_rarity_IV)
			){
				return global.arr_pool_cards_rarity_IV;
			}
		break;
	}

	return [];
}