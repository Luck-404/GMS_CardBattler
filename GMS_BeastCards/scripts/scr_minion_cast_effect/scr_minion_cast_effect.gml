//===============================================================================//
//
// SCRIPT: scr_minion_cast_effect
// FUNCTION: Casts the active effect of a battle Minion.
//           Determines friendly and enemy Beast lists from the Minion team.
//           Plays HOST or ENEMY Minion cast motion based on effect direction.
//           Executes the Minion's recurring behavior.
//
//===============================================================================//

function scr_minion_cast_effect(_ref_minion){

	//-----------------//
	//VALIDATE MINION//
	//-----------------//
	if (!instance_exists(_ref_minion)){
		return;
	}

	//---------------//
	//VALIDATE HOST//
	//---------------//
	if (!instance_exists(_ref_minion._ref_host)){
		return;
	}

	if (_ref_minion._ref_host._str_list != "ALIVE"){
		return;
	}

	//---------------//
	//GET MINION DATA//
	//---------------//
	var _str_minion_name =
		_ref_minion._str_name;

	var _str_minion_team =
		_ref_minion._str_team;

	var _list_enemy;
	var _list_friendly;

	//----------------//
	//GET TEAM LISTS//
	//----------------//
	if (_str_minion_team == "PLAYER"){

		_list_friendly =
			obj_battle_player_controller
				._list_beasts_alive;

		_list_enemy =
			obj_battle_enemy_controller
				._list_beasts_alive;
	}
	else{

		_list_enemy =
			obj_battle_player_controller
				._list_beasts_alive;

		_list_friendly =
			obj_battle_enemy_controller
				._list_beasts_alive;
	}

	//================//
	//MINION EFFECTS//
	//================//
	switch(_str_minion_name){

		//--------//
		//TENTACLE//
		//--------//
		case "TENTACLE":

			if (ds_list_size(_list_enemy) <= 0){
				break;
			}

			//----------------//
			//GET RANDOM ENEMY//
			//----------------//
			var _ref_target =
				scr_minion_get_target(
					_list_enemy
				);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage =
				_ref_minion._val_magnitude;

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_minion_damage_target(
				_val_damage,
				_ref_target
			);

		break;


		//----------------//
		//ABYSSAL HARPOON//
		//----------------//
		case "ABYSSAL HARPOON":

			if (ds_list_size(_list_enemy) <= 0){
				break;
			}

			//----------------------//
			//GET PREFERRED TARGET//
			//----------------------//
			var _ref_target =
				scr_minion_get_target(
					_list_enemy,
					undefined,
					"BACK_HALF"
				);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage =
				_ref_minion._val_magnitude *
				2;

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_minion_damage_target(
				_val_damage,
				_ref_target
			);

			//----------------//
			//PULL FORWARD 1//
			//----------------//
			if (
				instance_exists(_ref_target) &&
				_ref_target._str_list == "ALIVE" &&
				_ref_target._val_cur_hp > 0
			){

				scr_battle_reposition_beast(
					_ref_target,
					-1
				);
			}

		break;


		//--------------//
		//CORAL GUARDIAN//
		//--------------//
		case "CORAL GUARDIAN":

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"HOST"
			);

			//----------------//
			//CALCULATE ARMOR//
			//----------------//
			var _val_armor =
				_ref_minion._val_magnitude *
				2;

			//-----------//
			//GRANT ARMOR//
			//-----------//
			scr_battle_armor_target(
				_val_armor,
				_ref_minion._ref_host
			);

		break;


		//----------------------//
		//RIMEFROST ELEMENTAL//
		//----------------------//
		case "RIMEFROST ELEMENTAL":

			if (ds_list_size(_list_enemy) <= 0){
				break;
			}

			//------------------//
			//GET RANDOM ENEMY//
			//------------------//
			var _ref_frostbite_target =
				scr_minion_get_target(
					_list_enemy
				);

			if (!instance_exists(_ref_frostbite_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------------//
			//STORE ORIGINAL TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			global.ref_target_beast =
				_ref_frostbite_target;

			//----------------//
			//APPLY FROSTBITE//
			//----------------//
			repeat (_ref_minion._val_magnitude){

				scr_status_apply_dot(
					"FROSTBITE"
				);
			}

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast =
				_ref_original_target;

		break;


		//----------//
		//STORM WISP//
		//----------//
		case "STORM WISP":

			if (ds_list_size(_list_enemy) <= 0){
				break;
			}

			//----------------//
			//GET RANDOM ENEMY//
			//----------------//
			var _ref_target =
				scr_minion_get_target(
					_list_enemy
				);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage =
				_ref_minion._val_magnitude *
				3;

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_minion_damage_target(
				_val_damage,
				_ref_target
			);

		break;


		//-----//
		//FUNGI//
		//-----//
		case "FUNGI":

			if (_str_minion_team != "PLAYER"){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"HOST"
			);

			//----------------//
			//CALCULATE DRAW//
			//----------------//
			var _ct_draw =
				1 +
				floor(
					_ref_minion._val_max_hp /
						5
				);

			//-----------//
			//DRAW CARDS//
			//-----------//
			scr_battle_draw_cards(
				_ct_draw
			);

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"+" +
					string(_ct_draw) +
					" CARD DRAW",
				undefined,
				c_green,
				_ref_minion.x,
				_ref_minion.y - 24
			);

		break;


		//-------------//
		//GROVE SPIRIT//
		//-------------//
		case "GROVE SPIRIT":

			//---------------//
			//VALIDATE HOST//
			//---------------//
			if (!instance_exists(_ref_minion._ref_host)){
				break;
			}

			if (
				_ref_minion._ref_host._str_list != "ALIVE" ||
				_ref_minion._ref_host._val_cur_hp <= 0
			){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			if (
				_ref_minion._val_max_hp >= 10 &&
				ds_list_size(_list_enemy) > 0
			){

				scr_battle_vfx_minion_cast(
					_ref_minion,
					"ENEMY"
				);
			}
			else{

				scr_battle_vfx_minion_cast(
					_ref_minion,
					"HOST"
				);
			}

			//-------------------//
			//CALCULATE HEALING//
			//-------------------//
			/*
				Starts at 3 healing with Magnitude 1.
				Each +1 Magnitude adds +1 healing.
			*/
			var _val_healing =
				2 +
					_ref_minion._val_magnitude;

			//---------//
			//HEAL HOST//
			//---------//
			scr_battle_heal_target(
				_val_healing,
				_ref_minion._ref_host
			);

			//================================//
			//10 MAX HP — UNLOCK ATTACK//
			//================================//
			if (
				_ref_minion._val_max_hp >= 10 &&
				ds_list_size(_list_enemy) > 0
			){

				//----------------//
				//GET FRONT ENEMY//
				//----------------//
				var _ref_attack_target =
					ds_list_find_value(
						_list_enemy,
						0
					);

				if (
					instance_exists(_ref_attack_target) &&
					_ref_attack_target._str_list == "ALIVE" &&
					_ref_attack_target._val_cur_hp > 0
				){

					//----------------//
					//DEAL MAG DAMAGE//
					//----------------//
					var _val_damage =
						_ref_minion._val_magnitude;

					scr_minion_damage_target(
						_val_damage,
						_ref_attack_target
					);

					//============================//
					//20 MAX HP — UNLOCK STUN//
					//============================//
					if (
						_ref_minion._val_max_hp >= 20 &&
						instance_exists(_ref_attack_target) &&
						_ref_attack_target._val_cur_hp > 0
					){

						//----------------------//
						//STORE CURRENT TARGET//
						//----------------------//
						var _ref_original_target =
							global.ref_target_beast;

						//-----------//
						//APPLY STUN//
						//-----------//
						global.ref_target_beast =
							_ref_attack_target;

						scr_status_apply_cc(
							"STUN",
							1
						);

						//----------------//
						//RESTORE TARGET//
						//----------------//
						global.ref_target_beast =
							_ref_original_target;
					}
				}
			}
			else{

			}

		break;


		//------------//
		//WASP DRONE//
		//------------//
		case "WASP DRONE":

			if (ds_list_size(_list_enemy) <= 0){
				break;
			}

			//-------------------//
			//GET DAMAGE TARGET//
			//-------------------//
			var _ref_damage_target =
				scr_minion_get_target(
					_list_enemy
				);

			if (!instance_exists(_ref_damage_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage =
				_ref_minion._val_magnitude;

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_minion_damage_target(
				_val_damage,
				_ref_damage_target
			);

			//----------------------//
			//GET WEAKNESS TARGET//
			//----------------------//
			var _ref_weakness_target =
				scr_minion_get_target(
					_list_enemy,
					_ref_damage_target
				);

			//--------------------------------//
			//FALL BACK TO SAME ENEMY IF ALONE//
			//--------------------------------//
			if (
				!instance_exists(_ref_weakness_target) &&
				instance_exists(_ref_damage_target) &&
				_ref_damage_target._str_list == "ALIVE" &&
				_ref_damage_target._val_cur_hp > 0
			){

				_ref_weakness_target =
					_ref_damage_target;
			}

			//----------------//
			//APPLY WEAKNESS//
			//----------------//
			if (instance_exists(_ref_weakness_target)){

				var _ref_original_target =
					global.ref_target_beast;

				global.ref_target_beast =
					_ref_weakness_target;

				scr_status_apply_debuff(
					"WEAKNESS",
					1
				);

				global.ref_target_beast =
					_ref_original_target;
			}

		break;


		//-----------//
		//SPORELING//
		//-----------//
		case "SPORELING":

			if (!instance_exists(_ref_minion._ref_host)){
				break;
			}

			if (
				_ref_minion._ref_host._str_list != "ALIVE" ||
				_ref_minion._ref_host._val_cur_hp <= 0
			){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"HOST"
			);

			//----------------------//
			//STORE CURRENT TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			//--------------//
			//POISON HOST//
			//--------------//
			global.ref_target_beast =
				_ref_minion._ref_host;

			repeat (_ref_minion._val_magnitude){

				scr_status_apply_dot(
					"POISON"
				);
			}

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast =
				_ref_original_target;

		break;


		//--------//
		//SERPENT//
		//--------//
		case "SERPENT":

			if (ds_list_size(_list_enemy) <= 0){
				break;
			}

			//----------------//
			//GET ENEMY TARGET//
			//----------------//
			var _ref_target =
				scr_minion_get_target(
					_list_enemy
				);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------------//
			//STORE CURRENT TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			//-------------//
			//APPLY VENOM//
			//-------------//
			global.ref_target_beast =
				_ref_target;

			repeat (_ref_minion._val_magnitude){

				scr_status_apply_dot(
					"VENOM"
				);
			}

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast =
				_ref_original_target;

		break;


		//--------------//
		//DORMANT SEED//
		//--------------//
		case "DORMANT SEED":

			/*
				Dormant Seed intentionally has no cast motion.
				Its visible feedback comes from the Hatch/Spawn VFX
				when it transforms into another Minion.
			*/

			_ref_minion._ct_age++;

			if (_ref_minion._ct_age >= 2){

				scr_hatch_dormant_seed(
					_ref_minion
				);
			}

		break;


		//----------//
		//THORNLING//
		//----------//
		case "THORNLING":

			if (ds_list_size(_list_enemy) <= 0){
				break;
			}

			//----------------//
			//GET ENEMY TARGET//
			//----------------//
			var _ref_target =
				scr_minion_get_target(
					_list_enemy
				);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage =
				_ref_minion._val_magnitude *
					2;

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_minion_damage_target(
				_val_damage,
				_ref_target
			);

		break;


		//-------------//
		//LIFE SPIRIT//
		//-------------//
		case "LIFE SPIRIT":

			if (!instance_exists(_ref_minion._ref_host)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"HOST"
			);

			//-----------------//
			//CALCULATE HEALING//
			//-----------------//
			var _val_healing =
				_ref_minion._val_magnitude *
					2;

			//---------//
			//HEAL HOST//
			//---------//
			scr_battle_heal_target(
				_val_healing,
				_ref_minion._ref_host
			);

		break;
	}
}