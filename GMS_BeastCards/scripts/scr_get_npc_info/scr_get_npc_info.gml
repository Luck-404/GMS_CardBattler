//===============================================================================//
//
// SCRIPT: SCR_GET_NPC_INFO
// FUNCTION: Returns base NPC information from an input NPC ID.
//           Stores identity, visuals, dialogue, interactions, pathing,
//           vendor stock, quest references, and battle data in a struct.
//
//===============================================================================//

function scr_get_npc_info(_str_npc_id){

	var _stct_return_npc = undefined;

	switch(_str_npc_id){

		//=======================================================================//
		// TEST NPC
		//=======================================================================//
		#region TEST NPC

		case "NPC_TEST":

			_stct_return_npc = {

				//----------//
				// IDENTITY //
				//----------//
				_str_npc_id : _str_npc_id,
				_str_npc_name : "OLD MARTEN",
				_str_npc_title : "TRAVELING MERCHANT",
				_str_npc_type : "VENDOR",

				//---------//
				// VISUALS //
				//---------//
				_spr_npc : spr_npc_test,
				_spr_npc_portrait : undefined,
				_snd_npc_voice : undefined,

				//-------------//
				// INTERACTION //
				//-------------//
				_flag_interactable : true,

				_flag_can_talk : true,
				_flag_can_quest : false,
				_flag_can_trade : true,
				_flag_can_fight : false,

				//----------//
				// DIALOGUE //
				//----------//
				_arr_npc_dialogue : [
					"Fine weather we're having.",
					"Beasts have been restless along the road.",
					"Keep your Prisms close and your gold closer."
				],

				//--------//
				// QUESTS //
				//--------//
				_arr_quest_ids : [],

				//-------//
				// TRADE //
				//-------//
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

				//--------//
				// BATTLE //
				//--------//
				_arr_npc_beasts : [],
				_arr_npc_cards : [],

				//---------//
				// PATHING //
				//---------//
				_str_path_type : "PATH",
				_path_npc : path_npc_test,

				_arr_path_coordinates : [],

				_val_move_speed : 1,

				//--------//
				// FLAVOR //
				//--------//
				_str_npc_desc :
					"An aging merchant who travels between settlements."
			};

		break;

		#endregion


		//=======================================================================//
		// UNKNOWN NPC
		//=======================================================================//
		default:

			show_debug_message(
				"SCR_GET_NPC_INFO ERROR: UNKNOWN NPC ID | " +
				string(_str_npc_id)
			);

			_stct_return_npc = undefined;

		break;
	}

	return _stct_return_npc;
}