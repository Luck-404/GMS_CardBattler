//===============================================================================//
//
// SCRIPT: SCR_REWARD_GET_BATTLE_ROLL_CONFIG
// FUNCTION: Returns centralized battle-reward frequency and scaling values.
//
//           Gold, EXP, and one Material are guaranteed by the resolver.
//           Optional normal rewards receive the Battle Score chance bonus.
//           Secret Items and the separate Global Bonus Card do not.
//
//===============================================================================//

function scr_reward_get_battle_roll_config(){

	return {

		//================//
		//GUARANTEED//
		//================//
		_ct_exp_base : 2,
		_ct_exp_per_level_band : 1,

		_val_gold_level_bonus_per_level : 0.05,

		//================//
		//COMMON OPTIONAL//
		//================//
		_val_zone_material_chance : 50,

		_val_beast_card_chance : 30,
		_val_zone_card_chance : 30,

		//===============//
		//RARER OPTIONAL//
		//===============//
		_val_egg_chance : 10,
		_val_bonus_item_chance : 10,

		//================//
		//SECRET REWARDS//
		//================//
		_val_secret_item_chance : 1,

		//================//
		//BATTLE SCORE//
		//================//
		_val_grade_chance_per_star : 2.5,
		_val_gold_bonus_per_star : 0.05
	};
}