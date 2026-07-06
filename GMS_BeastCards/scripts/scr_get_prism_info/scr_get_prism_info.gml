//===============================================================================//
//
// SCRIPT: SCR_GET_PRISM_INFO
// FUNCTION: Returns prism tier data from a prism item id.
//           Stores tame bonus, vendor cost, mana cost, and guaranteed flag.
//           Supports old PRISM_BASIC_PRISM id as a common prism alias.
//
//===============================================================================//

function scr_get_prism_info(_str_item_id){

	switch(_str_item_id){

		case "PRISM_COMMON":
			return {
				_str_item_id : "PRISM_COMMON",
				_str_item_name : "COMMON PRISM",
				_spr_item : spr_item_prism_basic,
				_val_tame_bonus : 0,
				_val_base_cost : 50,
				_val_mana_cost : 2,
				_flag_guaranteed : false,
				_str_item_desc : "A basic prism used to capture weakened beasts."
			};
		break;

		case "PRISM_UNCOMMON":
			return {
				_str_item_id : "PRISM_UNCOMMON",
				_str_item_name : "UNCOMMON PRISM",
				_spr_item : spr_item_prism_uncommon,
				_val_tame_bonus : 5,
				_val_base_cost : 150,
				_val_mana_cost : 2,
				_flag_guaranteed : false,
				_str_item_desc : "A tuned prism with a modest capture bonus."
			};
		break;

		case "PRISM_RARE":
			return {
				_str_item_id : "PRISM_RARE",
				_str_item_name : "RARE PRISM",
				_spr_item : spr_item_prism_rare,
				_val_tame_bonus : 10,
				_val_base_cost : 400,
				_val_mana_cost : 2,
				_flag_guaranteed : false,
				_str_item_desc : "A reliable prism with a strong capture bonus."
			};
		break;

		case "PRISM_EPIC":
			return {
				_str_item_id : "PRISM_EPIC",
				_str_item_name : "EPIC PRISM",
				_spr_item : spr_item_prism_epic,
				_val_tame_bonus : 15,
				_val_base_cost : 900,
				_val_mana_cost : 2,
				_flag_guaranteed : false,
				_str_item_desc : "An advanced prism for difficult captures."
			};
		break;

		case "PRISM_LEGENDARY":
			return {
				_str_item_id : "PRISM_LEGENDARY",
				_str_item_name : "LEGENDARY PRISM",
				_spr_item : spr_item_prism_legendary,
				_val_tame_bonus : 20,
				_val_base_cost : 2000,
				_val_mana_cost : 2,
				_flag_guaranteed : false,
				_str_item_desc : "A powerful prism for rare and dangerous beasts."
			};
		break;

		case "PRISM_ARCWORK":
			return {
				_str_item_id : "PRISM_ARCWORK",
				_str_item_name : "ARCWORK PRISM",
				_spr_item : spr_item_prism_arcwork,
				_val_tame_bonus : 100,
				_val_base_cost : 9999,
				_val_mana_cost : 2,
				_flag_guaranteed : true,
				_str_item_desc : "A masterwork prism that guarantees capture."
			};
		break;
	}

	return undefined;
}