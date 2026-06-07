//
//
// SCRIPT: SCR_INIT_BEAST_CUSTOM | MAKE A NEW BEAST FROM SCRATCH IN ONE COMMAND | RETURNS MAP OF NEW BEAST
//
//
function scr_init_beast_custom(_beast_data){
	#region KEY
	// 0 - SPRITE			- spr id
	// 1 - NAME				- string
	// 2 - HP STAT			- int
	// 3 - CON STAT			- int
	// 4 - PPOW STAT		- int
	// 5 - MPOW STAT		- int
	// 6 - PDEF STAT		- int
	// 7 - MDEF STAT		- int
	// 8 - CRIT STAT		- int
	// 9 - DOD STAT			- int
	// 10 - MINIONS STAT	- int
	// 11 - COLOR(S)		- ["COLOR1","COLOR2"] or ["COLOR1",undefined]
	// 12 - COLOR TYPE		- string
	// 13 - ARCHETYPE		- string
	// 14 - CLASS			- string
	// 15 - TALENT TREES	- ["TREE1","TREE2"]
	// 16 - ABILITIY		- string
	// 17 - BREEED			- string
	// 18 - PRESTIGE		- string
	// 19 - FEEDING			- array (size 3)
	// 20 - HELD ITEM		- string
	// 21 - MARKINGS		- ds_list
	// 22 - SCARS			- ds_list
	// 23 - LORE DESC		- string
	// 24 - ROLE DESC		- string
	// 25 - LEVEL			- int	
	// 26 - EXP				- int
	#endregion
	
	//SET UP A NEW BEAST
	var _new_beast = ds_map_create();

	//INIT VARIABLES
	//SPRITE
	ds_map_add(_new_beast,"beast_sprite",_beast_data[0]);
	
	//NAME
	ds_map_add(_new_beast,"beast_name",_beast_data[1]); 
				
	#region STATS
	//HP STAT
	ds_map_add(_new_beast,"beast_hp_stat",_beast_data[2]); 
	
	//CON STAT
	ds_map_add(_new_beast,"beast_con_stat",_beast_data[3]); 
	
	//PPOW STAT
	ds_map_add(_new_beast,"beast_ppow_stat",_beast_data[4]); 
	
	//MPOW STAT
	ds_map_add(_new_beast,"beast_mpow_stat",_beast_data[5]);
	
	//PDEF STAT
	ds_map_add(_new_beast,"beast_pdef_stat",_beast_data[6]);
	
	//MDEF STAT
	ds_map_add(_new_beast,"beast_mdef_stat",_beast_data[7]);
	
	//CRIT STAT			
	ds_map_add(_new_beast,"beast_crit_stat",_beast_data[8]); 
	
	//DOD STAT
	ds_map_add(_new_beast,"beast_dod_stat",_beast_data[9]); 
	
	//MINIONS STAT
	ds_map_add(_new_beast,"beast_min_stat",_beast_data[10]);
	#endregion			
	
	//COLOR(S)
	ds_map_add(_new_beast,"beast_colors",_beast_data[11]); 
	
	//COLOR TYPES
	ds_map_add(_new_beast,"beast_color_type",_beast_data[12]); 
				
	//ARCHETYPE
	ds_map_add(_new_beast,"beast_archetype",_beast_data[13]); 
	
	//CLASS
	ds_map_add(_new_beast,"beast_class",_beast_data[14]);
				
	//TALENT TREES
	ds_map_add(_new_beast,"beast_talent_trees",_beast_data[15]); 

	//ABILITY
	ds_map_add(_new_beast,"beast_ability",_beast_data[16]); 
				
	//BREED	
	ds_map_add(_new_beast,"beast_breed",_beast_data[17]);
				
	//PRESTIGE
	ds_map_add(_new_beast,"beast_prestige_stat",_beast_data[18]);
				
	//FEEDING
	ds_map_add(_new_beast,"beast_feed_list",_beast_data[19]); 
				
	//HELD ITEM				
	ds_map_add(_new_beast,"beast_held_item",_beast_data[20]); 
				
	//MARKINGS				
	ds_map_add(_new_beast,"beast_markings",_beast_data[21]); 
	
	//SCARS			
	ds_map_add(_new_beast,"beast_scars",_beast_data[22]); 
	
	//LORE DESC
	ds_map_add(_new_beast,"beast_lore",_beast_data[23]); 
	
	//ROLE DESC
	ds_map_add(_new_beast,"beast_role",_beast_data[24]); 
	
	//LEVEL
	ds_map_add(_new_beast,"beast_level",_beast_data[25]); 
	
	//EXP VALUE
	ds_map_add(_new_beast,"beast_exp",_beast_data[26]);

	//SET UP CUR AND MAX HP VALUES
	#region HP VALUES
	ds_map_add(_new_beast,"beast_hp_cur",1); //CUR HP VALUE
	ds_map_add(_new_beast,"beast_hp_max",1); //MAX HP VALUE

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
	
	//RETURN THE NEW BEAST
	return _new_beast;
}