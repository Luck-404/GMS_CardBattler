//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_TREASURE_GET_CUSTOM_LOOT
// FUNCTION: Returns predefined rewards for a specified treasure chest.
//           Each reward stores its type, reward id, and quantity.
//
// ARGUMENTS: _str_chest_id is the custom treasure chest id to resolve.
// RETURNS: Array of reward structs, or an empty array when no table exists.
//
//===============================================================================//

function scr_overworld_treasure_get_custom_loot(_str_chest_id){

	//================//
	//INITIALIZE REWARDS//
	//================//
	var _arr_rewards = [];

	//================//
	//RESOLVE CHEST LOOT//
	//================//
	switch (_str_chest_id){

		//==============//
		//TESTER CHEST//
		//==============//
		case "TESTER_CHEST":

			_arr_rewards = [
				{
					_str_type: "CARD",
					_str_reward_id: "STRIKE",
					_ct_amount: 1
				},
				{
					_str_type: "CARD",
					_str_reward_id: "ECHO",
					_ct_amount: 1
				},
				{
					_str_type: "ITEM",
					_str_reward_id: "CONSUMABLE_HEALING_SALVE",
					_ct_amount: 3
				},
				{
					_str_type: "GOLD",
					_str_reward_id: "GOLD",
					_ct_amount: 250
				}
			];

		break;

		//===============//
		//UNKNOWN CHEST//
		//===============//
		default:

			scr_debug_log(
				"OVERWORLD",
				"TREASURE",
				undefined,
				"CUSTOM TREASURE LOOT TABLE NOT FOUND" +
				" | CHEST ID: " +
				string_upper(_str_chest_id),
				"WARNING",
				"SCR_OVERWORLD_TREASURE_GET_CUSTOM_LOOT"
			);

		break;
	}

	return _arr_rewards;
}