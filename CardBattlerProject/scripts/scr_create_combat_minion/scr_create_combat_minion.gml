//////////////////////////////////////////////////////////////////////
//					SCR_CREATE_COMBAT_MINION						//
//																	//
// > CREATES A MINION ON THE TARGET	BASED ON NAME INPUT				//
//////////////////////////////////////////////////////////////////////
function scr_create_combat_minion(_card,_channel,_target,_minion_type,_notes){
	var _new_minion = undefined;
	if (_target == "Targetless"){
		_target = _channel;
	}
	///////////////////
	// CREATE MINION //
	///////////////////	
	switch(_minion_type){
		case "Life Spirit":
			_new_minion = scr_create_minion(7,0,"Green",_minion_type,_target._creature_team,["Minion Step","None","None"],spr_minion_life_spirit,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default,_target,scr_minion_life_spirit_tick,0,"Support",_notes);
		break;
		
		case "Bramblet":
			_new_minion = scr_create_minion(13,2,"Green","Bramblet",_target._creature_team,["Minion Step","Host Damage Taken","None"],spr_minion_bramblet,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default,_target,scr_minion_bramblet_tick,0,"Guardian",_notes);
		break;
		
		case "Bloodbeak":
			_new_minion = scr_create_minion(7,0,"Green","Bloodbeak",_target._creature_team,["None","None","Host Damage Dealt"],spr_minion_bloodbeak,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default,_target,undefined,0,"Vanguard",_notes);
		break;		

		case "Serpent":
			_new_minion = scr_create_minion(7,0,"Green","Serpent",_target._creature_team,["None","Host Damage Taken","Host Damage Dealt"],spr_minion_coiled_serpent,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default,_target,undefined,0,"Vanguard",_notes);
		break;		
		
		case "Spriggan":
			_new_minion = scr_create_minion(1,0,"Green","Spriggan",_target._creature_team,["Minion Step","None","None"],spr_minion_spriggan,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default,_target,scr_minion_spriggan_tick,1,"Support",_notes);
		break;		
		
		case "Wasp Drone":
			_new_minion = scr_create_minion(4,0,"Green","Wasp Drone",_target._creature_team,["Minion Step","None","None"],spr_minion_wasp_drone,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default,_target,scr_minion_wasp_drone_tick,0,"Vanguard",_notes);
		break;		
		
		case "Deadseed":
			_new_minion = scr_create_minion(4,0,"Green","Deadseed",_target._creature_team,["Minion Step","None","None"],spr_minion_deadseed,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default,_target,scr_minion_deadseed_tick,0,"Vanguard",_notes);
		break;				
	}
	///////////////////
	// ADD TO TARGET //
	///////////////////
		///////////////
		// OPEN SPOT //
		///////////////
		if (_target._creature_minion_count < _target._creature_minion_limit){ //if open spot
			//if open spot- play normally
			ds_list_add(_target._creature_minion_references,_new_minion);
			_new_minion._minion_position = _target._creature_minion_count;
			_target._creature_minion_count++;
		}
		//////////////////
		// NO OPEN SPOT //
		//////////////////
		else { //overwrite old
			//else overwrite oldest unit (delete oldest unit)
			var _removal_unit = ds_list_find_value(_target._creature_minion_references,0);
			ds_list_delete(_target._creature_minion_references,0);
			instance_destroy(_removal_unit);

			//add new to back of the list
			ds_list_add(_target._creature_minion_references,_new_minion);
			_new_minion._minion_position = _target._creature_minion_limit-1;
		}
		
	//////////////////////
	// UPDATE POSITIONS //
	//////////////////////
	//update positions of creatures
	for (var _i = 0; _i < ds_list_size(_target._creature_minion_references); _i++){
		var _minion = ds_list_find_value(_target._creature_minion_references,_i);
		_minion._minion_position = _i;
	}			
	
	return _new_minion;
}