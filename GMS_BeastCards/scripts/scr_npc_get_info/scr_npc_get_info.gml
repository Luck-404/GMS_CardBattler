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