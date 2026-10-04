//===============================================================================//
//
// SCRIPT: SCR_REWARD_GET_GLOBAL_BONUS_INFO
// FUNCTION: Returns the global cross-pool Card bonus configuration.
//           Phase 3 will perform this roll after normal encounter rewards.
//
// CURRENT BASE CHANCE:
//           5% per completed battle.
//
//===============================================================================//

function scr_reward_get_global_bonus_info(){

	return {
		_val_card_bonus_chance : 5,
		_stct_card_rarity_weights : scr_reward_get_card_rarity_weights()
	};
}
