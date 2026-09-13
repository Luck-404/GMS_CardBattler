//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_THE_ABYSS_STARES_BACK
// FUNCTION: Resolves The Abyss Stares Back.
//           Every living Beast gains:
//             - 1 random Cerulean Buff.
//             - 1 random Cerulean Debuff.
//             - 1 random Cerulean Minion from the global Cerulean Minion pool.
//           Then applies 1 random CC to:
//             - 1 random allied Beast.
//             - 1 random enemy Beast.
//
// ARGUMENTS: _stct_card is The Abyss Stares Back card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_the_abyss_stares_back(_stct_card,_ref_caster,_ref_target){

	//================//
	//CERULEAN BUFFS//
	//================//
	var _arr_buffs = [
		{
			id : "SAILORS_RESOLVE",
			mag : 33,
			life : 3
		},
		{
			id : "ARCTIC_FOCUS",
			mag : 0,
			life : 2
		},
		{
			id : "FROST_WEAPON",
			mag : 1,
			life : 2
		},
		{
			id : "FROZEN_PRECISION",
			mag : 0,
			life : 2
		},
		{
			id : "DEEP_MOMENTUM",
			mag : 1,
			life : 2
		},
		{
			id : "ICEBOUND_INSTINCT",
			mag : 1,
			life : 4
		},
		{
			id : "FROZEN_ARMOR",
			mag : 1,
			life : 3
		},
		{
			id : "STATIC_BARRIER",
			mag : 1,
			life : 3
		},
		{
			id : "RAZOR_SHELL",
			mag : 3,
			life : 3
		},
		{
			id : "ICE_MIRROR",
			mag : 2,
			life : 3
		}
	];

	//==================//
	//CERULEAN DEBUFFS//
	//==================//
	var _arr_debuffs = [
		{
			id : "BRITTLE_CONSTITUTION",
			life : 3
		},
		{
			id : "WHITEOUT",
			life : 3
		},
		{
			id : "WEAKNESS",
			life : 3
		},
		{
			id : "FROZEN_CURSE",
			life : 3
		}
	];

	//================//
	//CC POOL//
	//================//
	var _arr_cc = [
		"STUN",
		"SLEEP",
		"FROZEN",
		"BLIND",
		"BANISH"
	];

	//================//
	//STORE TARGET//
	//================//
	var _ref_original_target = global.ref_target_beast;

	//===================//
	//AFFECT ALL BEASTS//
	//===================//
	var _arr_team_lists = [
		obj_battle_player_controller._list_beasts_alive,
		obj_battle_enemy_controller._list_beasts_alive
	];

	for (var _it_team = 0;_it_team < array_length(_arr_team_lists);_it_team++){

		var _list_team = _arr_team_lists[_it_team];

		for (var _it_beast = 0;_it_beast < ds_list_size(_list_team);_it_beast++){

			var _ref_beast = ds_list_find_value(_list_team,_it_beast);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (
				_ref_beast._str_list != "ALIVE" ||
				_ref_beast._val_cur_hp <= 0
			){
				continue;
			}

			global.ref_target_beast = _ref_beast;

			//----------------//
			//RANDOM BUFF//
			//----------------//
			var _stct_buff = _arr_buffs[irandom(array_length(_arr_buffs) - 1)];

			scr_status_apply_buff(
				_stct_buff.id,
				_stct_buff.mag,
				_stct_buff.life
			);

			//----------------//
			//RANDOM DEBUFF//
			//----------------//
			var _stct_debuff = _arr_debuffs[irandom(array_length(_arr_debuffs) - 1)];

			scr_status_apply_debuff(
				_stct_debuff.id,
				_stct_debuff.life
			);

			//------------------------//
			//RANDOM CERULEAN MINION//
			//------------------------//
			if (
				variable_global_exists("list_pool_cerulean_minions") &&
				ds_exists(global.list_pool_cerulean_minions,ds_type_list) &&
				ds_list_size(global.list_pool_cerulean_minions) > 0
			){
				var _it_minion = irandom(ds_list_size(global.list_pool_cerulean_minions) - 1);
				var _str_minion = ds_list_find_value(global.list_pool_cerulean_minions,_it_minion);

				scr_minion_init(
					_str_minion,
					_stct_card,
					_ref_caster,
					_ref_beast
				);
			}
		}
	}

	//================//
	//GET TEAM LISTS//
	//================//
	var _list_allies = undefined;
	var _list_enemies = undefined;

	if (_ref_caster._str_team == "PLAYER"){
		_list_allies = obj_battle_player_controller._list_beasts_alive;
		_list_enemies = obj_battle_enemy_controller._list_beasts_alive;
	}
	else{
		_list_allies = obj_battle_enemy_controller._list_beasts_alive;
		_list_enemies = obj_battle_player_controller._list_beasts_alive;
	}

	//==================//
	//RANDOM ALLIED CC//
	//==================//
	var _arr_valid_allies = [];

	for (var _it_beast = 0;_it_beast < ds_list_size(_list_allies);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_allies,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		array_push(_arr_valid_allies,_ref_beast);
	}

	if (array_length(_arr_valid_allies) > 0){

		var _ref_cc_target = _arr_valid_allies[irandom(array_length(_arr_valid_allies) - 1)];
		var _str_cc = _arr_cc[irandom(array_length(_arr_cc) - 1)];

		global.ref_target_beast = _ref_cc_target;

		scr_status_apply_cc(
			_str_cc
		);
	}

	//=================//
	//RANDOM ENEMY CC//
	//=================//
	var _arr_valid_enemies = [];

	for (var _it_beast = 0;_it_beast < ds_list_size(_list_enemies);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_enemies,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		array_push(_arr_valid_enemies,_ref_beast);
	}

	if (array_length(_arr_valid_enemies) > 0){

		var _ref_cc_target = _arr_valid_enemies[irandom(array_length(_arr_valid_enemies) - 1)];
		var _str_cc = _arr_cc[irandom(array_length(_arr_cc) - 1)];

		global.ref_target_beast = _ref_cc_target;

		scr_status_apply_cc(
			_str_cc
		);
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}