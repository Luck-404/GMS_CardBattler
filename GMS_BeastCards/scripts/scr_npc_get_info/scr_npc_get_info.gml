//===============================================================================//
//
// SCRIPT: SCR_NPC_GET_INFO
// FUNCTION: Returns base NPC information from an input NPC id.
//           Stores identity, visuals, dialogue, interactions, pathing,
//           vendor stock, quest references, and battle data in a struct.
//
// ARGUMENTS: _str_npc_id is the NPC id to resolve.
// RETURNS: NPC information struct, or undefined when the id is unrecognized.
//
//===============================================================================//

function scr_npc_get_info(_str_npc_id){

	//================//
	//INITIALIZE NPC//
	//================//
	var _stct_npc = undefined;

	//================//
	//RESOLVE NPC//
	//================//
	switch (_str_npc_id){

		//=======================================================================//
		// TEST NPC
		//=======================================================================//
		#region TEST NPC

		case "NPC_TEST":

			_stct_npc = {

				//----------------//
				//IDENTITY//
				//----------------//
				_str_npc_id : _str_npc_id,
				_str_npc_name : "OLD MARTEN",
				_str_npc_title : "TRAVELING MERCHANT",
				_str_npc_type : "VENDOR",

				//----------------//
				//VISUALS//
				//----------------//
				_spr_npc : spr_npc_test,
				_spr_npc_portrait : undefined,
				_snd_npc_voice : undefined,

				//----------------//
				//INTERACTION//
				//----------------//
				_flag_interactable : true,

				_flag_can_talk : true,
				_flag_can_quest : false,
				_flag_can_trade : true,
				_flag_can_fight : false,

				//----------------//
				//DIALOGUE//
				//----------------//
				_arr_npc_dialogue : [
					"Fine weather we're having.",
					"Beasts have been restless along the road.",
					"Keep your Prisms close and your gold closer."
				],

				//----------------//
				//QUESTS//
				//----------------//
				_arr_quest_ids : [],

				//----------------//
				//TRADE//
				//----------------//
				_arr_trade_stock : [

					{
						_str_item_id : "CONSUMABLE_HEALING_SALVE",
						_val_gold_cost : 50,
						_ct_stock : 3,
						_flag_infinite : false
					},

					{
						_str_item_id : "PRISM_COMMON",
						_val_gold_cost : 100,
						_ct_stock : 5,
						_flag_infinite : false
					}
				],

				//----------------//
				//BATTLE//
				//----------------//
				_arr_npc_beasts : [],
				_arr_npc_cards : [],

				//----------------//
				//PATHING//
				//----------------//
				_str_path_type : "PATH",
				_path_npc : path_npc_test,

				_arr_path_coordinates : [],

				_val_move_speed : 1,

				//----------------//
				//FLAVOR//
				//----------------//
				_str_npc_desc : "An aging merchant who travels between settlements."
			};

		break;

		#endregion


		//=======================================================================//
		// WANDERING MERCHANT — WORLD EVENT
		//=======================================================================//
		#region WANDERING MERCHANT

		case "NPC_WANDERING_MERCHANT":

			_stct_npc = {

				//----------------//
				//IDENTITY//
				//----------------//
				_str_npc_id : _str_npc_id,
				_str_npc_name : "MERRICK",
				_str_npc_title : "ROADBOUND PEDDLER",
				_str_npc_type : "VENDOR",

				//----------------//
				//VISUALS//
				//----------------//
				_spr_npc : spr_npc_wandering_merchant,
				_spr_npc_portrait : undefined,
				_snd_npc_voice : undefined,

				//----------------//
				//INTERACTION//
				//----------------//
				_flag_interactable : true,
				_flag_can_talk : true,
				_flag_can_quest : false,
				_flag_can_trade : true,
				_flag_can_fight : false,
				_flag_can_send_away : true,
				_flag_random_dialogue : true,

				//----------------//
				//DIALOGUE / RUMORS//
				//----------------//
				_arr_npc_dialogue : [
					"The shrine stones in the central square? Older than the streets around them. Much older, if you believe the masons.",
					"Where the green wetlands meet blue water, the Beasts get strange. Half the tracks point into the reeds and half simply vanish.",
					"I've seen Viridian Beasts follow storms for miles. Not flee them—follow them. Make of that what you will.",
					"Old trail markers east of town keep turning up inside tree trunks. Either the forest is moving or someone has a very patient joke.",
					"Travelers talk about a brute deep in the woods whose fists sound like thunder. Travelers also exaggerate. Usually.",
					"If a road looks too quiet, check the brush. If the brush looks too quiet, check your coin purse.",
					"Some collectors swear a Beast's temperament changes what treasures it guards. I swear collectors will say anything after three ales.",
					"There's a place where red heat creeps into green country. Plants there grow mean, fast, and with very little respect for boots.",
					"I passed scholars hauling instruments toward a collapsed old route. They wouldn't say what they heard beneath the stone.",
					"A good Prism is cheaper than chasing the same Beast twice. A bad Prism is cheaper still, which is why I sell both philosophies.",
					"The road teaches one lesson better than any academy: if three different people warn you about the same cave, charge admission before going in.",
					"I've traded with farmers, hunters, scholars, and one fellow who claimed to be a wizard's accountant. He was the most dangerous of the lot.",
					"Rain brings Cerulean Beasts closer to the roads. Heat does the same for Vermilion. Me? I bring an umbrella and raise my prices.",
					"Keep an eye on old runestones. People decorate around things they don't understand; it makes them feel less ancient."
				],

				//----------------//
				//QUESTS//
				//----------------//
				_arr_quest_ids : [],

				//----------------//
				//TRADE//
				//----------------//
				// World Event generation replaces this fallback stock with one persistent
				// event-specific roll before the player can interact.
				_arr_trade_stock : [
					{
						_str_item_id : "PRISM_RARE",
						_val_gold_cost : 350,
						_ct_stock : 3,
						_flag_infinite : false
					},
					{
						_str_item_id : "PRISM_EPIC",
						_val_gold_cost : 800,
						_ct_stock : 1,
						_flag_infinite : false
					}
				],

				//----------------//
				//BATTLE//
				//----------------//
				_arr_npc_beasts : [],
				_arr_npc_cards : [],

				//----------------//
				//PATHING//
				//----------------//
				_str_path_type : "NONE",
				_path_npc : undefined,
				_arr_path_coordinates : [],
				_val_move_speed : 0,

				//----------------//
				//FLAVOR//
				//----------------//
				_str_npc_desc : "A road-worn peddler who appears without warning, sells unusual stock, and always seems to know one rumor too many."
			};

		break;

		#endregion

		//=======================================================================//
		// UNKNOWN NPC
		//=======================================================================//
		default:

			scr_debug_log(
				"NPC",
				"GET_INFO",
				undefined,
				"NPC DATA NOT FOUND" +
				" | ID: " +
				string_upper(_str_npc_id),
				"ERROR",
				"SCR_NPC_GET_INFO"
			);

			_stct_npc = undefined;

		break;
	}

	return _stct_npc;
}
