//===============================================================================//
//
// SCRIPT: SCR_REWARD_GET_CARD_RARITY_WEIGHTS
// FUNCTION: Returns the base rarity distribution used after a Card reward roll.
//           These are data only; Phase 3 performs the actual reward roll.
//
// CURRENT BASE DISTRIBUTION:
//           I   = 80%
//           II  = 15%
//           III = 4%
//           IV  = 1%
//
//===============================================================================//

function scr_reward_get_card_rarity_weights(){

	return {
		_val_rarity_I : 80,
		_val_rarity_II : 15,
		_val_rarity_III : 4,
		_val_rarity_IV : 1
	};
}
