//===============================================================================//
//
// SCRIPT: SCR_MINION_INIT
// FUNCTION: Creates and attaches a battle Minion to a target Beast.
//           Initializes Minion stats, handles slot replacement, applies passive
//           effects, refreshes Minion-count Buffs, and logs the summon.
//
// ARGUMENTS: _str_minion_id identifies the Minion.
//            _ref_card is the source Card struct or Card instance when available.
//            _ref_caster is the Beast responsible for the summon when available.
//            _ref_target is the Beast hosting the Minion.
// RETURNS: The created Minion instance, or undefined if creation fails.
//
//===============================================================================//

function scr_minion_init(_str_minion_id,_ref_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	if (!ds_exists(_ref_target._list_minions,ds_type_list)){
		return undefined;
	}

	if (_ref_target._ct_minions_max <= 0){
		return undefined;
	}

	//---------------//
	//CREATE MINION//
	//---------------//
	var _ref_new_minion = instance_create_layer(
		_ref_target.x,
		_ref_target.y,
		"ily_minions",
		obj_battle_minion
	);

	if (!instance_exists(_ref_new_minion)){
		return undefined;
	}

	//---------------//
	//COMMON SETUP//
	//---------------//
	_ref_new_minion._ref_host = _ref_target;
	_ref_new_minion._str_team = _ref_target._str_team;
	_ref_new_minion._str_minion_tag = scr_minion_get_tag(_str_minion_id);

	//================//
	//MINION DATA//
	//================//
	switch (_str_minion_id){

		//============//
		//ASH PHOENIX//
		//============//
		case "ASH_PHOENIX":

			_ref_new_minion._str_name = "ASH PHOENIX";

			_ref_new_minion._val_cur_hp = 4;
			_ref_new_minion._val_max_hp = 4;

			_ref_new_minion._val_magnitude = 4;

			_ref_new_minion._spr_minion = spr_minion_ash_phoenix;

		break;

		//----------//
		//CINDERLING//
		//----------//
		case "CINDERLING":

			_ref_new_minion._str_name = "CINDERLING";

			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_cinderling;

		break;

		//-------------//
		//EMBER TURRET//
		//-------------//
		case "EMBER_TURRET":

			_ref_new_minion._str_name = "EMBER TURRET";

			_ref_new_minion._val_cur_hp = 3;
			_ref_new_minion._val_max_hp = 3;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_ember_turret;

		break;

		//------------//
		//MAGMA CANNON//
		//------------//
		case "MAGMA_CANNON":

			_ref_new_minion._str_name = "MAGMA CANNON";

			_ref_new_minion._val_cur_hp = 3;
			_ref_new_minion._val_max_hp = 3;

			_ref_new_minion._val_magnitude = 3;

			_ref_new_minion._spr_minion = spr_minion_magma_cannon;

		break;

		//----------//
		//FLAMEGUARD//
		//----------//
		case "FLAMEGUARD":

			_ref_new_minion._str_name = "FLAMEGUARD";

			_ref_new_minion._val_cur_hp = 7;
			_ref_new_minion._val_max_hp = 7;

			_ref_new_minion._val_magnitude = 0;

			_ref_new_minion._spr_minion = spr_minion_flameguard;

		break;

		//-------------//
		//LIVING FLAME//
		//-------------//
		case "LIVING_FLAME":

			_ref_new_minion._str_name = "LIVING FLAME";

			_ref_new_minion._val_cur_hp = 3;
			_ref_new_minion._val_max_hp = 3;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_living_flame;

		break;

		//------------//
		//ANCHOR STONE//
		//------------//
		case "ANCHOR_STONE":

			_ref_new_minion._str_name = "ANCHOR STONE";

			_ref_new_minion._val_cur_hp = 3;
			_ref_new_minion._val_max_hp = 3;

			_ref_new_minion._val_magnitude = 0;

			_ref_new_minion._spr_minion = spr_minion_anchor_stone;

		break;

		//--------------//
		//CORAL GUARDIAN//
		//--------------//
		case "CORAL_GUARDIAN":

			_ref_new_minion._str_name = "CORAL GUARDIAN";

			_ref_new_minion._val_cur_hp = 4;
			_ref_new_minion._val_max_hp = 4;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_coral_guardian;

		break;

		//----------------//
		//ABYSSAL HARPOON//
		//----------------//
		case "ABYSSAL_HARPOON":

			_ref_new_minion._str_name = "ABYSSAL HARPOON";

			_ref_new_minion._val_cur_hp = 3;
			_ref_new_minion._val_max_hp = 3;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_abyssal_harpoon;

		break;

		//----------//
		//STORM WISP//
		//----------//
		case "STORM_WISP":

			_ref_new_minion._str_name = "STORM WISP";

			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_storm_wisp;

		break;

		//----------------------//
		//RIMEFROST ELEMENTAL//
		//----------------------//
		case "RIMEFROST_ELEMENTAL":

			_ref_new_minion._str_name = "RIMEFROST ELEMENTAL";

			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_rimefrost_elemental;

		break;

		//--------//
		//ICE WALL//
		//--------//
		case "ICE_WALL":

			_ref_new_minion._str_name = "ICE WALL";

			_ref_new_minion._val_cur_hp = 10;
			_ref_new_minion._val_max_hp = 10;

			_ref_new_minion._val_magnitude = 0;

			_ref_new_minion._spr_minion = spr_minion_ice_wall;

		break;

		//-----//
		//FUNGI//
		//-----//
		case "FUNGI":

			_ref_new_minion._str_name = "FUNGI";

			_ref_new_minion._val_cur_hp = 1;
			_ref_new_minion._val_max_hp = 1;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_fungi;

		break;

		//-------------//
		//GROVE SPIRIT//
		//-------------//
		case "GROVE_SPIRIT":

			_ref_new_minion._str_name = "GROVE SPIRIT";

			_ref_new_minion._val_cur_hp = 5;
			_ref_new_minion._val_max_hp = 5;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_grove_spirit;

		break;

		//------------//
		//WASP DRONE//
		//------------//
		case "WASP_DRONE":

			_ref_new_minion._str_name = "WASP DRONE";

			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_wasp_drone;

		break;

		//-----------//
		//SPORELING//
		//-----------//
		case "SPORELING":

			_ref_new_minion._str_name = "SPORELING";

			_ref_new_minion._val_cur_hp = 1;
			_ref_new_minion._val_max_hp = 1;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_sporeling;

		break;

		//--------//
		//SERPENT//
		//--------//
		case "SERPENT":

			_ref_new_minion._str_name = "SERPENT";

			_ref_new_minion._val_cur_hp = 3;
			_ref_new_minion._val_max_hp = 3;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_serpent;

		break;

		//----------------//
		//BLOOMING SPRITE//
		//----------------//
		case "BLOOMING_SPRITE":

			_ref_new_minion._str_name = "BLOOMING SPRITE";

			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_blooming_sprite;

		break;

		//--------//
		//TENTACLE//
		//--------//
		case "TENTACLE":

			_ref_new_minion._str_name = "TENTACLE";

			_ref_new_minion._val_cur_hp = 3;
			_ref_new_minion._val_max_hp = 3;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_tentacle;

		break;

		//--------------//
		//DORMANT SEED//
		//--------------//
		case "DORMANT_SEED":

			_ref_new_minion._str_name = "DORMANT SEED";

			_ref_new_minion._val_cur_hp = 1;
			_ref_new_minion._val_max_hp = 1;

			_ref_new_minion._val_magnitude = 0;
			_ref_new_minion._ct_age = 0;

			_ref_new_minion._spr_minion = spr_minion_dormant_seed;

		break;

		//-------------//
		//LIFE SPIRIT//
		//-------------//
		case "LIFE_SPIRIT":

			_ref_new_minion._str_name = "LIFE SPIRIT";

			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_life_spirit;

		break;

		//----------//
		//THORNLING//
		//----------//
		case "THORNLING":

			_ref_new_minion._str_name = "THORNLING";

			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._spr_minion = spr_minion_thornling;

		break;

		//----------------//
		//INVALID MINION//
		//----------------//
		default:

			instance_destroy(_ref_new_minion);

			return undefined;
	}

	//----------------//
	//STORE BASE STATS//
	//----------------//
	_ref_new_minion._val_base_max_hp = _ref_new_minion._val_max_hp;
	_ref_new_minion._val_base_magnitude = _ref_new_minion._val_magnitude;

	//----------------------//
	//TRACK REPLACEMENT DATA//
	//----------------------//
	var _flag_replaced_minion = false;
	var _str_replaced_minion = "";

	//================//
	//ATTACH MINION//
	//================//
	if (scr_minion_has_open_slot(_ref_target)){

		//----------------//
		//ADD OPEN SLOT//
		//----------------//
		ds_list_add(
			_ref_target._list_minions,
			_ref_new_minion
		);

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"+ MINION",
			undefined,
			c_black,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}
	else{

		//----------------------//
		//GET OLDEST MINION//
		//----------------------//
		var _ref_old_minion = ds_list_find_value(
			_ref_target._list_minions,
			0
		);

		if (instance_exists(_ref_old_minion)){

			_flag_replaced_minion = true;
			_str_replaced_minion = _ref_old_minion._str_name;

			scr_minion_destroy(
				_ref_old_minion,
				"REPLACE"
			);
		}

		//----------------//
		//ADD NEW MINION//
		//----------------//
		ds_list_add(
			_ref_target._list_minions,
			_ref_new_minion
		);

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"+ MINION (REPLACED OLDEST)",
			undefined,
			c_black,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	//======================//
	//APPLY PASSIVE EFFECTS//
	//======================//

	//============//
	//ASH PHOENIX//
	//============//
	if (_ref_new_minion._str_name == "ASH PHOENIX"){

		scr_status_buff_ash_phoenix(
			"APPLY",
			undefined,
			_ref_new_minion
		);
	}

	//==========//
	//FLAMEGUARD//
	//==========//
	if (_ref_new_minion._str_name == "FLAMEGUARD"){

		scr_status_buff_flameguard_taunt(
			"APPLY",
			undefined,
			_ref_new_minion
		);
	}


	//----------------//
	//BLOOMING SPRITE//
	//----------------//
	if (_ref_new_minion._str_name == "BLOOMING SPRITE"){

		scr_status_buff_blooming_sprite(
			"APPLY",
			undefined,
			_ref_new_minion
		);
	}

	//------------//
	//ANCHOR STONE//
	//------------//
	if (_ref_new_minion._str_name == "ANCHOR STONE"){
		scr_status_apply_anchor_stone_passive(_ref_new_minion);
	}

	//--------------------------//
	//REFRESH MINION-COUNT BUFFS//
	//--------------------------//
	scr_minion_trigger_count_buffs(_ref_target);

	//-------------------//
	//REPOSITION MINIONS//
	//-------------------//
	scr_minion_reposition(_ref_target);
	scr_status_reposition(_ref_target);

	//----------------//
	//SUMMON SPAWN VFX//
	//----------------//
	if (instance_exists(_ref_new_minion)){

		scr_battle_vfx(
			_ref_new_minion,
			spr_battle_vfx_minion_spawn,
			undefined,
			undefined,
			0,
			0,
			1,
			0,
			snd_battle_minion_spawn
		);
	}

	//================//
	//DEBUG SUMMON//
	//================//
	var _str_source = "SYSTEM";

	if (
		is_struct(_ref_card) &&
		variable_struct_exists(_ref_card,"_str_card_name")
	){
		_str_source = string_upper(_ref_card._str_card_name);
	}
	else if (
		instance_exists(_ref_card) &&
		variable_instance_exists(_ref_card,"_ref_card") &&
		is_struct(_ref_card._ref_card)
	){
		_str_source = string_upper(_ref_card._ref_card._str_card_name);
	}

	var _str_summoner = "SYSTEM";

	if (
		instance_exists(_ref_caster) &&
		is_struct(_ref_caster._ref_unit)
	){
		_str_summoner =
			string_upper(_ref_caster._str_team) + " " +
			string_upper(_ref_caster._ref_unit._str_beast_name);
	}

	var _str_summon_message =
		string_upper(_ref_new_minion._str_team) + " " +
		string_upper(_ref_new_minion._str_name) +
		" SUMMONED" +
		" | HOST: " +
		string_upper(_ref_target._ref_unit._str_beast_name) +
		" | HP: " +
		string(_ref_new_minion._val_cur_hp) +
		"/" +
		string(_ref_new_minion._val_max_hp) +
		" | MAGNITUDE: " +
		string(_ref_new_minion._val_magnitude) +
		" | TAG: " +
		string_upper(_ref_new_minion._str_minion_tag) +
		" | SUMMONER: " +
		_str_summoner +
		" | SOURCE: " +
		_str_source;

	if (_flag_replaced_minion){

		_str_summon_message +=
			" | REPLACED: " +
			string_upper(_str_replaced_minion);
	}

	scr_debug_log(
		"MINIONS",
		"SUMMON",
		_ref_new_minion,
		_str_summon_message,
		"BATTLE",
		"SCR_MINION_INIT"
	);

	return _ref_new_minion;
}