//
//
// SCRIPT: SCR_INIT_BEAST_RANDOM | TAKE A BASE BEAST MAP, INITIALIZE ITS COLOR TYPE, ABILITY, BREED, AND HP VALUES | RETURNS MAP OF UPDATED BEAST
//
//
function scr_init_beast_random(_beast_name){
	//SET UP RETURN BEAST
	var _new_beast = scr_get_beast_info(_beast_name);
	
	//ROLL A COLOR TYPE FROM THE BEAST'S TYPE LIST
	#region COLOR TYPE
	var _type_list = _new_beast[?"beast_color_type"]
	var _selected_type = _type_list[irandom_range(0,array_length(_type_list)-1)];
	ds_map_replace(_new_beast,"beast_color_type",_selected_type);
	#endregion
	
	//ROLL AN ABILITY FROM THE BEAST'S ABILITIES LIST
	#region ABILITY
	var _ability_list = _new_beast[?"beast_ability"]
	var _selected_ability = _ability_list[irandom_range(0,array_length(_ability_list)-1)];
	ds_map_replace(_new_beast,"beast_ability",_selected_ability);
	#endregion
	
	//ROLL A BREED FROM THE GLOBAL 
	#region BREED
	var _breeds_list = ["BULKY","HALE","STRONG","INTELLIGENT","STEADFAST","WARDED"] //+2 GRADE TO THESE STATS (FUTURE- DO A -2 OR TRADEOFF BREEDS)
	var _selected_breed = _breeds_list[irandom_range(0,array_length(_breeds_list)-1)];
	ds_map_replace(_new_beast,"beast_breed",_selected_breed);
	#endregion
	
	//SET UP CUR AND MAX HP VALUES
	#region HP VALUES
	var _hp_stat = _new_beast[?"beast_hp_stat"];
	var _hp_modifier = scr_get_beast_grade_modifier(_hp_stat);
	var _hp_calculated = 10 + ((_hp_modifier*10)*1)/4
	ds_map_replace(_new_beast,"beast_hp_cur",_hp_calculated);
	ds_map_replace(_new_beast,"beast_hp_max",_hp_calculated);
	#endregion
	
	//UID
	var _uid = global.beast_uid;
	ds_map_add(_new_beast,"beast_uid",_uid);
	global.beast_uid = global.beast_uid+1;
	
	//RETURN BEAST
	return _new_beast;
}