//===============================================================================//
//
// SCR_INIT_MINION
// FUNCTION: Creates a battle minion from a minion ID.
//           Attaches it to the target beast.
//           Replaces the oldest minion if the target is already at capacity.
//
//===============================================================================//
function scr_init_minion(_str_id,_ref_card,_ref_caster,_ref_target){

	var _ref_new_minion = instance_create_layer(_ref_target.x,_ref_target.y,"ily_minions",obj_battle_minion);
	_ref_new_minion._str_minion_tag =
		scr_get_minion_tag(
			_str_id
		);
		
	switch(_str_id){

	//------------//
	//ANCHOR STONE//
	//------------//
	case "ANCHOR_STONE":

		_ref_new_minion._str_team =
			_ref_target._str_team;

		_ref_new_minion._str_name =
			"ANCHOR STONE";

		//------//
		//HP 3//
		//------//
		_ref_new_minion._val_cur_hp =
			3;

		_ref_new_minion._val_max_hp =
			3;

		//-----------//
		//MAGNITUDE 0//
		//-----------//
		_ref_new_minion._val_magnitude =
			0;

		_ref_new_minion._ref_host =
			_ref_target;

		_ref_new_minion._spr_minion =
			spr_minion_anchor_stone;

	break;

	//--------------//
	//CORAL GUARDIAN//
	//--------------//
	case "CORAL_GUARDIAN":

		_ref_new_minion._str_team =
			_ref_target._str_team;

		_ref_new_minion._str_name =
			"CORAL GUARDIAN";

		//------//
		//HP 4//
		//------//
		_ref_new_minion._val_cur_hp =
			4;

		_ref_new_minion._val_max_hp =
			4;

		//-----------//
		//MAGNITUDE 1//
		//-----------//
		_ref_new_minion._val_magnitude =
			1;

		_ref_new_minion._ref_host =
			_ref_target;

		_ref_new_minion._spr_minion =
			spr_minion_coral_guardian;

	break;

	//----------------//
	//ABYSSAL HARPOON//
	//----------------//
	case "ABYSSAL_HARPOON":

		_ref_new_minion._str_team =
			_ref_target._str_team;

		_ref_new_minion._str_name =
			"ABYSSAL HARPOON";

		//------//
		//HP 3//
		//------//
		_ref_new_minion._val_cur_hp =
			3;

		_ref_new_minion._val_max_hp =
			3;

		//-----------//
		//MAGNITUDE 1//
		//-----------//
		_ref_new_minion._val_magnitude =
			1;

		_ref_new_minion._ref_host =
			_ref_target;

		_ref_new_minion._spr_minion =
			spr_minion_abyssal_harpoon;

	break;

	//----------//
	//STORM WISP//
	//----------//
	case "STORM_WISP":

		_ref_new_minion._str_team =
			_ref_target._str_team;

		_ref_new_minion._str_name =
			"STORM WISP";

		//------//
		//HP 2//
		//------//
		_ref_new_minion._val_cur_hp =
			2;

		_ref_new_minion._val_max_hp =
			2;

		//-----------//
		//MAGNITUDE 1//
		//-----------//
		_ref_new_minion._val_magnitude =
			1;

		_ref_new_minion._ref_host =
			_ref_target;

		_ref_new_minion._spr_minion =
			spr_minion_storm_wisp;

	break;

	//----------------------//
	//RIMEFROST ELEMENTAL//
	//----------------------//
	case "RIMEFROST_ELEMENTAL":

		_ref_new_minion._str_team =
			_ref_target._str_team;

		_ref_new_minion._str_name =
			"RIMEFROST ELEMENTAL";

		//------//
		//HP 2//
		//------//
		_ref_new_minion._val_cur_hp =
			2;

		_ref_new_minion._val_max_hp =
			2;

		//-----------//
		//MAGNITUDE 1//
		//-----------//
		_ref_new_minion._val_magnitude =
			1;

		_ref_new_minion._ref_host =
			_ref_target;

		_ref_new_minion._spr_minion =
			spr_minion_rimefrost_elemental;

	break;


	//--------//
	//ICE WALL//
	//--------//
	case "ICE_WALL":

		_ref_new_minion._str_team =
			_ref_target._str_team;

		_ref_new_minion._str_name =
			"ICE WALL";

		//-------//
		//HP 10//
		//-------//
		_ref_new_minion._val_cur_hp =
			10;

		_ref_new_minion._val_max_hp =
			10;

		//-----------//
		//MAGNITUDE 0//
		//-----------//
		_ref_new_minion._val_magnitude =
			0;

		_ref_new_minion._ref_host =
			_ref_target;

		_ref_new_minion._spr_minion =
			spr_minion_ice_wall;

	break;

		case "FUNGI":

			_ref_new_minion._str_team =
				_ref_target._str_team;

			_ref_new_minion._str_name =
				"FUNGI";

			_ref_new_minion._val_cur_hp =
				1;

			_ref_new_minion._val_max_hp =
				1;

			_ref_new_minion._val_magnitude =
				1;

			_ref_new_minion._ref_host =
				_ref_target;

			_ref_new_minion._spr_minion =
				spr_minion_fungi;

		break;
		
		
		case "GROVE_SPIRIT":

			_ref_new_minion._str_team =
				_ref_target._str_team;

			_ref_new_minion._str_name =
				"GROVE SPIRIT";

			//------//
			//HP 5//
			//------//
			_ref_new_minion._val_cur_hp =
				5;

			_ref_new_minion._val_max_hp =
				5;

			//-----------//
			//MAGNITUDE 1//
			//-----------//
			_ref_new_minion._val_magnitude =
				1;

			_ref_new_minion._ref_host =
				_ref_target;

			_ref_new_minion._spr_minion =
				spr_minion_grove_spirit;

		break;
		
		case "WASP_DRONE":

			_ref_new_minion._str_team =
				_ref_target._str_team;

			_ref_new_minion._str_name =
				"WASP DRONE";

			_ref_new_minion._val_cur_hp =
				2;

			_ref_new_minion._val_max_hp =
				2;

			_ref_new_minion._val_magnitude =
				1;

			_ref_new_minion._ref_host =
				_ref_target;

			_ref_new_minion._spr_minion =
				spr_minion_wasp_drone;

		break;		
		
		case "SPORELING":

			_ref_new_minion._str_team =
				_ref_target._str_team;

			_ref_new_minion._str_name =
				"SPORELING";

			_ref_new_minion._val_cur_hp =
				1;

			_ref_new_minion._val_max_hp =
				1;

			_ref_new_minion._val_magnitude =
				1;

			_ref_new_minion._ref_host =
				_ref_target;

			_ref_new_minion._spr_minion =
				spr_minion_sporeling;

		break;	
		
		case "SERPENT":

			_ref_new_minion._str_team = _ref_target._str_team;
			_ref_new_minion._str_name = "SERPENT";

			_ref_new_minion._val_cur_hp = 3;
			_ref_new_minion._val_max_hp = 3;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._ref_host = _ref_target;
			_ref_new_minion._spr_minion = spr_minion_serpent;

		break;
		
		case "BLOOMING_SPRITE":

			_ref_new_minion._str_team = _ref_target._str_team;
			_ref_new_minion._str_name = "BLOOMING SPRITE";

			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._ref_host = _ref_target;
			_ref_new_minion._spr_minion = spr_minion_blooming_sprite;

		break;

//--------//
//TENTACLE//
//--------//
case "TENTACLE":

	_ref_new_minion._str_team =
		_ref_target._str_team;

	_ref_new_minion._str_name =
		"TENTACLE";

	//------//
	//HP 3//
	//------//
	_ref_new_minion._val_cur_hp =
		3;

	_ref_new_minion._val_max_hp =
		3;

	//-----------//
	//MAGNITUDE 1//
	//-----------//
	_ref_new_minion._val_magnitude =
		1;

	_ref_new_minion._ref_host =
		_ref_target;

	_ref_new_minion._spr_minion =
		spr_minion_tentacle;

break;

		case "DORMANT_SEED":

			_ref_new_minion._str_team = _ref_target._str_team;
			_ref_new_minion._str_name = "DORMANT SEED";

			_ref_new_minion._val_cur_hp = 1;
			_ref_new_minion._val_max_hp = 1;

			_ref_new_minion._val_magnitude = 0;
			_ref_new_minion._ct_age = 0;

			_ref_new_minion._ref_host = _ref_target;
			_ref_new_minion._spr_minion = spr_minion_dormant_seed;

		break;

		case "LIFE_SPIRIT":

			_ref_new_minion._str_team = _ref_target._str_team;
			_ref_new_minion._str_name = "LIFE SPIRIT";

			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._ref_host = _ref_target;
			_ref_new_minion._spr_minion = spr_minion_life_spirit;

		break;
		
		case "THORNLING":

			_ref_new_minion._str_team = _ref_target._str_team;
			_ref_new_minion._str_name = "THORNLING";

			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;

			_ref_new_minion._val_magnitude = 1;

			_ref_new_minion._ref_host = _ref_target;
			_ref_new_minion._spr_minion = spr_minion_thornling;

		break;	
	}
	
	//----------------//
	//STORE BASE STATS//
	//----------------//
	_ref_new_minion._val_base_max_hp =
		_ref_new_minion._val_max_hp;

	_ref_new_minion._val_base_magnitude =
		_ref_new_minion._val_magnitude;
	
	if (ds_list_size(_ref_target._list_minions) < _ref_target._ct_minions_max){

		ds_list_add(_ref_target._list_minions,_ref_new_minion);

		scr_spawn_popup_scrolling("TEXT","+ MINION",undefined,c_black,_ref_target.x + irandom_range(-32,32),_ref_target.y - 24 + irandom_range(-32,32));
	}
	else{

		var _ref_old_minion =
			ds_list_find_value(
				_ref_target._list_minions,
				0
			);

		if (instance_exists(_ref_old_minion)){
			scr_destroy_minion(_ref_old_minion,"REPLACE");
		}

		ds_list_add(
			_ref_target._list_minions,
			_ref_new_minion
		);

		scr_spawn_popup_scrolling(
			"TEXT",
			"+ MINION (REPLACED OLDEST)",
			undefined,
			c_black,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	//----------------------//
	//APPLY PASSIVE EFFECTS//
	//----------------------//

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

		scr_apply_anchor_stone_passive(
			_ref_new_minion
		);
	}

	//--------------------------//
	//TRIGGER MINION COUNT BUFFS//
	//--------------------------//
	scr_trigger_minion_count_buffs(
		_ref_target
	);

	//-------------------//
	//REPOSITION MINIONS//
	//-------------------//
	scr_reposition_minions(
		_ref_target
	);

	scr_reposition_statuses(
		_ref_target
	);

	//----------------//
	//SUMMON SPAWN VFX//
	//----------------//
	if (instance_exists(_ref_new_minion)){

		scr_battle_vfx(
			_ref_new_minion,
			spr_battle_vfx_summon_spawn,
			undefined,
			undefined,
			0,
			0,
			1,
			0,
			snd_battle_sfx_summon_spawn
		);
	}

	return _ref_new_minion;
}