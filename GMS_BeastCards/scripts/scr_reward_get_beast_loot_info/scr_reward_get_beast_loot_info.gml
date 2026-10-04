//===============================================================================//
//
// SCRIPT: SCR_REWARD_GET_BEAST_LOOT_INFO
// FUNCTION: Returns the non-Card reward pool assigned to one Beast species.
//           Card rewards are intentionally derived separately from the Beast's
//           actual active deck so a Beast can only drop Cards it can cast.
//
// ARGUMENTS: _str_beast_name - Beast species ID.
// RETURNS: Reward definition struct, or undefined when the Beast ID is invalid.
//
//===============================================================================//

function scr_reward_get_beast_loot_info(_str_beast_name){

	#region VARIABLES

	_str_beast_name =
		string_upper(
			string(
				_str_beast_name
			)
		);

	var _arr_material_pool = [];
	var _arr_bonus_item_pool = [];

	var _val_gold_min = 0;
	var _val_gold_max = 0;

	#endregion

	#region BEAST LOOT

	switch (_str_beast_name){

		#region CERULEAN
			case "AMMOMARSH":
				_arr_material_pool = ["MATERIAL_HARDSTONE", "MATERIAL_ROUGH_BONE"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

			case "BLIZZDRIFT":
				_arr_material_pool = ["MATERIAL_DAZZLING_HIDE", "MATERIAL_SOFTSTONE"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "CAUDAQUA":
				_arr_material_pool = ["MATERIAL_SIMPLE_HIDE", "MATERIAL_SOFTSTONE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "CEPHARIME":
				_arr_material_pool = ["MATERIAL_SIMPLE_HIDE", "MATERIAL_SILK"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "CHELONSEA":
				_arr_material_pool = ["MATERIAL_HARDSTONE", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

			case "CORALLIARC":
				_arr_material_pool = ["MATERIAL_HARDSTONE", "MATERIAL_SOFTSTONE"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "FROSTUSK":
				_arr_material_pool = ["MATERIAL_ROUGH_BONE", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

			case "GALENATRIUM":
				_arr_material_pool = ["MATERIAL_ROUGH_BONE", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "GLACIMIGHT":
				_arr_material_pool = ["MATERIAL_HARDSTONE", "MATERIAL_SOFTSTONE"];
				_val_gold_min = 20;
				_val_gold_max = 30;
			break;

			case "GULFLOW":
				_arr_material_pool = ["MATERIAL_SOFTSTONE", "MATERIAL_DAZZLING_HIDE"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "ISTIRAIN":
				_arr_material_pool = ["MATERIAL_ROUGH_BONE", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "KELPLATANI":
				_arr_material_pool = ["MATERIAL_SIMPLE_HIDE", "MATERIAL_VINES"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

			case "LONTRIVER":
				_arr_material_pool = ["MATERIAL_SIMPLE_HIDE", "MATERIAL_SOFTSTONE"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

			case "MARITIMICE":
				_arr_material_pool = ["MATERIAL_ROUGH_BONE", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

			case "SALTWAGG":
				_arr_material_pool = ["MATERIAL_SIMPLE_HIDE", "MATERIAL_SOFTSTONE"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "SPHENISKIP":
				_arr_material_pool = ["MATERIAL_DAZZLING_HIDE", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

		#endregion

		#region VERMILION
			case "ASCHEMASS":
				_arr_material_pool = ["MATERIAL_HARDSTONE", "MATERIAL_SOFTSTONE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "CANIGNIS":
				_arr_material_pool = ["MATERIAL_ROUGH_BONE", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "DAIMONIS":
				_arr_material_pool = ["MATERIAL_DAZZLING_HIDE", "MATERIAL_ROUGH_BONE"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "DRAKOAL":
				_arr_material_pool = ["MATERIAL_DAZZLING_HIDE", "MATERIAL_ROUGH_BONE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "EMBEROOST":
				_arr_material_pool = ["MATERIAL_DAZZLING_HIDE", "MATERIAL_SILK"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

			case "HELLSHROOM":
				_arr_material_pool = ["MATERIAL_LEAF_LITTER", "MATERIAL_SOFTSTONE"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "IMPARCH":
				_arr_material_pool = ["MATERIAL_IRON", "MATERIAL_CRIMSITE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "INFERNUS":
				_arr_material_pool = ["MATERIAL_CRIMSITE", "MATERIAL_HARDSTONE"];
				_val_gold_min = 20;
				_val_gold_max = 30;
			break;

			case "LAVAROWANA":
				_arr_material_pool = ["MATERIAL_DAZZLING_HIDE", "MATERIAL_CRIMSITE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "PYREKNIGHT":
				_arr_material_pool = ["MATERIAL_IRON", "MATERIAL_DAZZLING_HIDE", "MATERIAL_ROUGH_BONE"];
				_val_gold_min = 20;
				_val_gold_max = 30;
			break;

			case "PYROPLUME":
				_arr_material_pool = ["MATERIAL_DAZZLING_HIDE", "MATERIAL_SILK"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "SANGUINAUT":
				_arr_material_pool = ["MATERIAL_LINEN", "MATERIAL_IRON"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "SLAGOLEM":
				_arr_material_pool = ["MATERIAL_HARDSTONE", "MATERIAL_IRON", "MATERIAL_CRIMSITE"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "SOLEMOLD":
				_arr_material_pool = ["MATERIAL_IRON", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "WRATHOOD":
				_arr_material_pool = ["MATERIAL_LINEN", "MATERIAL_SILK"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "WYRMELTA":
				_arr_material_pool = ["MATERIAL_DAZZLING_HIDE", "MATERIAL_CRIMSITE"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

		#endregion

		#region VIRIDIAN
			case "ARBRAWN":
				_arr_material_pool = ["MATERIAL_DARKWOOD", "MATERIAL_VINES"];
				_val_gold_min = 20;
				_val_gold_max = 30;
			break;

			case "ARGENTBUD":
				_arr_material_pool = ["MATERIAL_LIFEPETAL", "MATERIAL_LIGHTWOOD"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "BEAVINE":
				_arr_material_pool = ["MATERIAL_LIGHTWOOD", "MATERIAL_VINES"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "BRYOBITE":
				_arr_material_pool = ["MATERIAL_LEAF_LITTER", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

			case "CHITROOPER":
				_arr_material_pool = ["MATERIAL_SIMPLE_HIDE", "MATERIAL_ROUGH_BONE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "CRUSABER":
				_arr_material_pool = ["MATERIAL_DAZZLING_HIDE", "MATERIAL_BLADE_GRASS"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

			case "DRYADAE":
				_arr_material_pool = ["MATERIAL_DARKWOOD", "MATERIAL_LIFEPETAL", "MATERIAL_VINES"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "FIGHTREE":
				_arr_material_pool = ["MATERIAL_DARKWOOD", "MATERIAL_LIGHTWOOD"];
				_val_gold_min = 20;
				_val_gold_max = 30;
			break;

			case "FLITSAGE":
				_arr_material_pool = ["MATERIAL_LIFEPETAL", "MATERIAL_DAZZLING_HIDE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "FURN":
				_arr_material_pool = ["MATERIAL_SIMPLE_HIDE", "MATERIAL_ROUGH_BONE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "LEPOROOT":
				_arr_material_pool = ["MATERIAL_LEAF_LITTER", "MATERIAL_LIGHTWOOD", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "LUMBUCK":
				_arr_material_pool = ["MATERIAL_DARKWOOD", "MATERIAL_SIMPLE_HIDE", "MATERIAL_ROUGH_BONE"];
				_val_gold_min = 12;
				_val_gold_max = 20;
			break;

			case "MAMBARK":
				_arr_material_pool = ["MATERIAL_DARKWOOD", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "MORELUSH":
				_arr_material_pool = ["MATERIAL_LEAF_LITTER", "MATERIAL_LIFEPETAL"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

			case "SPOROSE":
				_arr_material_pool = ["MATERIAL_LEAF_LITTER", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "STRIGIBLOOM":
				_arr_material_pool = ["MATERIAL_DAZZLING_HIDE", "MATERIAL_LIFEPETAL"];
				_val_gold_min = 8;
				_val_gold_max = 14;
			break;

			case "TURFRANTULA":
				_arr_material_pool = ["MATERIAL_SILK", "MATERIAL_SIMPLE_HIDE"];
				_val_gold_min = 6;
				_val_gold_max = 10;
			break;

		#endregion

		default:
			return undefined;
	}

	#endregion

	#region RESULT

	return {
		_str_beast_name : _str_beast_name,
		_str_egg_item_id : "EGG_" + _str_beast_name,
		_arr_material_pool : _arr_material_pool,
		_arr_bonus_item_pool : _arr_bonus_item_pool,
		_val_gold_min : _val_gold_min,
		_val_gold_max : _val_gold_max
	};

	#endregion
}
