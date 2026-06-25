//===============================================================================//
//
// SCRIPT: SCR_GET_ITEM_INFO
// FUNCTION: Creates a new item struct from an item id.
//           Populates item display data, behavior data, and stack data.
//           Assigns a unique item uid before returning the item.
//
//===============================================================================//

function scr_get_item_info(_str_item_id){
	var _stct_return_item = {
		_str_item_id : _str_item_id,
		_str_item_name : "DEFAULT",
		_spr_item : spr_item_egg_arbrawn,
		_str_item_type : undefined,
		_scr_item : undefined,
		_str_item_desc : "DEFAULT",
		_flag_stackable : false,
		_ct_item_amount : 1,
		_ct_item_max_amount : 1,
		_uid_item : global.item_uid
	};

	switch(_str_item_id){

		#region QUEST
		case "QUEST_IMPORTANT_NOTEBOOK":
			_stct_return_item._str_item_name = "IMPORTANT NOTEBOOK";
			_stct_return_item._spr_item = spr_item_quest_important_notebook;
			_stct_return_item._str_item_type = "QUEST";
			_stct_return_item._scr_item = undefined;
			_stct_return_item._str_item_desc = "An important notebook used for completing a quest.";
			_stct_return_item._flag_stackable = false;
			_stct_return_item._ct_item_amount = 1;
			_stct_return_item._ct_item_max_amount = 1;
		break;
		#endregion

		#region CONSUMABLE
		case "CONSUMABLE_HEALING_SALVE":
			_stct_return_item._str_item_name = "HEALING SALVE";
			_stct_return_item._spr_item = spr_item_consumable_healing_salve;
			_stct_return_item._str_item_type = "CONSUMABLE";
			_stct_return_item._scr_item = undefined;
			_stct_return_item._str_item_desc = "A healing balm that can be used to heal beasts.";
			_stct_return_item._flag_stackable = true;
			_stct_return_item._ct_item_amount = 1;
			_stct_return_item._ct_item_max_amount = 10;
		break;
		#endregion

		#region PRISM
		case "PRISM_BASIC_PRISM":
			_stct_return_item._str_item_name = "BASIC PRISM";
			_stct_return_item._spr_item = spr_item_prism_basic;
			_stct_return_item._str_item_type = "PRISM";
			_stct_return_item._scr_item = undefined;
			_stct_return_item._str_item_desc = "Used to capture beasts.";
			_stct_return_item._flag_stackable = true;
			_stct_return_item._ct_item_amount = 1;
			_stct_return_item._ct_item_max_amount = 10;
		break;
		#endregion

		#region HELD
		case "HELD_POWERFUL_STONE":
			_stct_return_item._str_item_name = "POWERFUL STONE";
			_stct_return_item._spr_item = spr_item_held_powerful_stone;
			_stct_return_item._str_item_type = "HELD";
			_stct_return_item._scr_item = undefined;
			_stct_return_item._str_item_desc = "Can be given to a beast to increase their power.";
			_stct_return_item._flag_stackable = false;
			_stct_return_item._ct_item_amount = 1;
			_stct_return_item._ct_item_max_amount = 1;
		break;
		#endregion

		#region EGG
		case "EGG_ARBRAWN":
			_stct_return_item._str_item_name = "ARBRAWN EGG";
			_stct_return_item._spr_item = spr_item_egg_arbrawn;
			_stct_return_item._str_item_type = "EGG";
			_stct_return_item._scr_item = undefined;
			_stct_return_item._str_item_desc = "An egg of the beast Arbrawn.";
			_stct_return_item._flag_stackable = false;
			_stct_return_item._ct_item_amount = 1;
			_stct_return_item._ct_item_max_amount = 1;
		break;
		#endregion
	}

	global.item_uid++;

	return _stct_return_item;
}