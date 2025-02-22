function scr_save(){
	// Generate timestamped filename
	var _date = date_current_datetime();
	var _save_name = string_format(date_get_day(_date), 2, 0) + "_" +
	                string_format(date_get_month(_date), 2, 0) + "_" +
	                string_format(date_get_year(_date), 4, 0) + "_" +
	                string_format(date_get_hour(_date), 2, 0) + "_" +
	                string_format(date_get_minute(_date), 2, 0);

	var _save_path = global.save_folder + "Save_" + _save_name + ".ini";

	// Create and write to the .ini file
	ini_open(_save_path);
	var _rmname = scr_save_room(global.saved_room);
	ini_write_string("Player", "Map", _rmname);
	ini_write_real("Player", "x_pos", global.player_xpos);
	ini_write_real("Player", "y_pos", global.player_ypos);
	ini_write_real("Gold", "gold_count", global.gold);
	
	//for every card...
	for (var _cardindex = 0; _cardindex < ds_list_size(global.card_inventory); _cardindex++){
		var _ref_card = ds_list_find_value(global.card_inventory,_cardindex);
		ini_write_string("Card_" + string(_cardindex), "card_name", _ref_card[?"name"]);
	}
	
	//for every blessing...
	for (var _blessindex = 0; _blessindex < ds_list_size(global.blessings_list); _blessindex++){
		var _ref_bless = ds_list_find_value(global.blessings_list,_blessindex);
		ini_write_string("Blessing_" + string(_blessindex), "bless_name", _ref_bless[?"Name"]);
	}
	
	//for every creature in the party..
	for (var _partyindex = 0; _partyindex < ds_list_size(global.player_team); _partyindex++){
		var _ref_unit = ds_list_find_value(global.player_team,_partyindex);
		ini_write_string("Creature_" + string(_partyindex), "creature_name", _ref_unit[?"name"]);
		//ini_write_string("Creature " + _ref_unit[?"name"] + " " + _partyindex, "creature_subtype", _ref_unit[?"subtype"]);
		//ini_write_string("Creature " + _ref_unit[?"name"] + " " + _partyindex, "creature_breed", _ref_unit[?"breed"]);
		ini_write_real("Creature_" + string(_partyindex), "creature_max_hp", _ref_unit[?"hp"]);
		ini_write_real("Creature_" + string(_partyindex), "creature_cur_hp", _ref_unit[?"curhp"]);
		//ini_write_real("Creature " + _ref_unit[?"name"] + " " + _partyindex, "creature_gold_cost", _ref_unit[?"goldcost"]);		
		
		//var _ref_markings_list = _ref_unit[?"markingslist"];
		//for (var _markindex = 0; _markindex < ds_list_size(_ref_markings_list); _markindex++){
		//	var _ref_marking = ds_list_find_value(global.player_team,_partyindex);
		//	ini_write_string("Creature " + _ref_unit[?"name"] + " " + _partyindex, "creature_markings", _ref_unit[?"markingslist"]);
		//}
	}
	
	//for every creature in the graveyard...
	for (var _graveindex = 0; _graveindex < ds_list_size(global.graveyard); _graveindex++){
		var _ref_unit = ds_list_find_value(global.graveyard,_graveindex);
		ini_write_string("Graveyard_" + string(_graveindex), "creature_name", _ref_unit[?"name"]);
	}
	ini_close();
}