//===============================================================================//
// SCRIPT: SCR_INVENTORY_GET_FOOD_INFO
// FUNCTION: Authoritative feed-item bonus catalog. Values affect Beast raw stats.
//           Recent-meal display text is sourced from this same catalog.
//===============================================================================//
function scr_inventory_get_food_info(_str_item_id){
	switch (string_upper(string(_str_item_id))){
		case "CONSUMABLE_FOOD_DRAGONFRUIT":
			return {
				_str_food_id : "CONSUMABLE_FOOD_DRAGONFRUIT",
				_str_food_name : "Dragonfruit",
				_spr_food : spr_item_consumable_food_dragonfruit,
				_str_bonus_text : "PHYDEF +20, MAGDEF +10",
				_stct_bonuses : {_val_beast_pdef_stat: 20, _val_beast_mdef_stat: 10}
			};
		case "CONSUMABLE_FOOD_HEARTPLUM":
			return {
				_str_food_id : "CONSUMABLE_FOOD_HEARTPLUM",
				_str_food_name : "Heartplum",
				_spr_food : spr_item_consumable_food_heartplum,
				_str_bonus_text : "HP Stat +10",
				_stct_bonuses : {_val_beast_hp_stat: 10}
			};
		case "CONSUMABLE_FOOD_HONEYCOMB":
			return {
				_str_food_id : "CONSUMABLE_FOOD_HONEYCOMB",
				_str_food_name : "Honeycomb",
				_spr_food : spr_item_consumable_food_honeycomb,
				_str_bonus_text : "Max Minions +1",
				_stct_bonuses : {_val_beast_min_stat: 1}
			};
		case "CONSUMABLE_FOOD_IRONROOT":
			return {
				_str_food_id : "CONSUMABLE_FOOD_IRONROOT",
				_str_food_name : "Ironroot",
				_spr_food : spr_item_consumable_food_ironroot,
				_str_bonus_text : "CON +10",
				_stct_bonuses : {_val_beast_con_stat: 10}
			};
		case "CONSUMABLE_FOOD_KEENPEPPER":
			return {
				_str_food_id : "CONSUMABLE_FOOD_KEENPEPPER",
				_str_food_name : "Keenpepper",
				_spr_food : spr_item_consumable_food_keenpepper,
				_str_bonus_text : "Crit Chance +3%",
				_stct_bonuses : {_val_beast_crit_stat: 3}
			};
		case "CONSUMABLE_FOOD_MISTGRAPE":
			return {
				_str_food_id : "CONSUMABLE_FOOD_MISTGRAPE",
				_str_food_name : "Mistgrape",
				_spr_food : spr_item_consumable_food_mistgrape,
				_str_bonus_text : "Dodge +3%",
				_stct_bonuses : {_val_beast_dod_stat: 3}
			};
		case "CONSUMABLE_FOOD_MOONPEAR":
			return {
				_str_food_id : "CONSUMABLE_FOOD_MOONPEAR",
				_str_food_name : "Moonpear",
				_spr_food : spr_item_consumable_food_moonpear,
				_str_bonus_text : "MAGDEF +10",
				_stct_bonuses : {_val_beast_mdef_stat: 10}
			};
		case "CONSUMABLE_FOOD_POPCORN":
			return {
				_str_food_id : "CONSUMABLE_FOOD_POPCORN",
				_str_food_name : "Popcorn",
				_spr_food : spr_item_consumable_food_popcorn,
				_str_bonus_text : "PHYPOW +5, Crit Chance +5%",
				_stct_bonuses : {_val_beast_ppow_stat: 5, _val_beast_crit_stat: 5}
			};
		case "CONSUMABLE_FOOD_STARFRUIT":
			return {
				_str_food_id : "CONSUMABLE_FOOD_STARFRUIT",
				_str_food_name : "Starfruit",
				_spr_food : spr_item_consumable_food_starfruit,
				_str_bonus_text : "MAGPOW +10",
				_stct_bonuses : {_val_beast_mpow_stat: 10}
			};
		case "CONSUMABLE_FOOD_SWIFTBERRY":
			return {
				_str_food_id : "CONSUMABLE_FOOD_SWIFTBERRY",
				_str_food_name : "Swiftberry",
				_spr_food : spr_item_consumable_food_swiftberry,
				_str_bonus_text : "SPEED +10",
				_stct_bonuses : {_val_beast_speed_stat: 10}
			};
		case "CONSUMABLE_FOOD_TIGERFIG":
			return {
				_str_food_id : "CONSUMABLE_FOOD_TIGERFIG",
				_str_food_name : "Tigerfig",
				_spr_food : spr_item_consumable_food_tigerfig,
				_str_bonus_text : "PHYPOW +10",
				_stct_bonuses : {_val_beast_ppow_stat: 10}
			};
		case "CONSUMABLE_FOOD_TITANBERRY":
			return {
				_str_food_id : "CONSUMABLE_FOOD_TITANBERRY",
				_str_food_name : "Titanberry",
				_spr_food : spr_item_consumable_food_titanberry,
				_str_bonus_text : "PHYDEF +10, MAGDEF +10, CON +10",
				_stct_bonuses : {_val_beast_pdef_stat: 10, _val_beast_mdef_stat: 10, _val_beast_con_stat: 10}
			};
		case "CONSUMABLE_FOOD_WALNUT":
			return {
				_str_food_id : "CONSUMABLE_FOOD_WALNUT",
				_str_food_name : "Walnut",
				_spr_food : spr_item_consumable_food_walnut,
				_str_bonus_text : "PHYDEF +10",
				_stct_bonuses : {_val_beast_pdef_stat: 10}
			};
		case "CONSUMABLE_FOOD_WATERMELON":
			return {
				_str_food_id : "CONSUMABLE_FOOD_WATERMELON",
				_str_food_name : "Watermelon",
				_spr_food : spr_item_consumable_food_watermelon,
				_str_bonus_text : "Max Minions +2",
				_stct_bonuses : {_val_beast_min_stat: 2}
			};
	}
	return undefined;
}
