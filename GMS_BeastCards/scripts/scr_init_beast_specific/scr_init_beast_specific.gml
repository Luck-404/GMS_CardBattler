//
//
// SCRIPT: SCR_INIT_BEAST_SPECIFIC | TAKE A BASE BEAST, SET ITS COLOR TYPE, ABILITY, BREED, AND UPDATE ITS HP VALUES AFTER | RETURNS MAP OF NEW BEAST
//
//
function scr_init_beast_specific(_beast_name,_specific_data){
	//GET A BASE BEAST
	var _new_beast = scr_get_beast_info(_beast_name);
	
	//SET THE COLOR TYPE
	#region COLOR TYPE
	ds_map_replace(_new_beast,"beast_color_type",_specific_data[0]);
	#endregion
	
	//SET THE ABILITY
	#region ABILITY
	ds_map_replace(_new_beast,"beast_ability",_specific_data[1]);
	#endregion
	
	//SET THE BREED
	#region BREED
	ds_map_replace(_new_beast,"beast_breed",_specific_data[2]);
	#endregion
	
	//SET UP CUR AND MAX HP VALUES
	#region HP VALUES
	var _hp_stat = _new_beast[?"beast_hp_stat"];
	var _hp_modifier = scr_get_beast_grade_modifier(_hp_stat);
	var _hp_calculated = ceil(10 + ((_hp_modifier*10)*1)/4);
	ds_map_replace(_new_beast,"beast_hp_cur",_hp_calculated);
	ds_map_replace(_new_beast,"beast_hp_max",_hp_calculated);
	#endregion
	
	//UID
	var _uid = global.beast_uid;
	ds_map_add(_new_beast,"beast_uid",_uid);
	global.beast_uid = global.beast_uid+1;	
}