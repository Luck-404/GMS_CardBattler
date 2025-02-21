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
	ini_write_string("Player", "Map", string(room));
	ini_write_real("Player", "x_pos", global.player_xpos);
	ini_write_real("Player", "y_pos", global.player_ypos);
	ini_write_real("Gold", "gold_count", global.gold);
	
	//for every card...
	for (var _cardindex = 0; _cardindex < ds_list_size(global.card_inventory); _cardindex++){
		var _ref_card = ds_list_find_value(global.card_inventory,_cardindex);
		ini_write_string("Card " + _ref_card[?"name"] + " " + _cardindex, "card_name", _ref_card[?"name"]);
		ini_write_string("Card " + _ref_card[?"name"] + " " + _cardindex, "card_desc", _ref_card[?"description"]);
		ini_write_real("Card " + _ref_card[?"name"] + " " + _cardindex, "card_cost", _ref_card[?"cost"]);
		ini_write_string("Card " + _ref_card[?"name"] + " " + _cardindex, "card_script", _ref_card[?"script"]);
		ini_write_string("Card " + _ref_card[?"name"] + " " + _cardindex, "card_sprite", _ref_card[?"sprite"]);
		ini_write_string("Card " + _ref_card[?"name"] + " " + _cardindex, "card_target", _ref_card[?"target"]);
		ini_write_string("Card " + _ref_card[?"name"] + " " + _cardindex, "card_color", _ref_card[?"color"]);
		ini_write_string("Card " + _ref_card[?"name"] + " " + _cardindex, "card_type", _ref_card[?"type"]);
		ini_write_string("Card " + _ref_card[?"name"] + " " + _cardindex, "card_archetype", _ref_card[?"archespec"]);
		ini_write_string("Card " + _ref_card[?"name"] + " " + _cardindex, "class_sepc", _ref_card[?"classspec"]);
		ini_write_real("Card " + _ref_card[?"name"] + " " + _cardindex, "goldcost", _ref_card[?"goldcost"]);
		ini_write_string("Card " + _ref_card[?"name"] + " " + _cardindex, "exhausts", _ref_card[?"exhausts"]);
	}
	
	//for every blessing...
	for (var _blessindex = 0; _blessindex < ds_list_size(global.blessings_list); _blessindex++){
		var _ref_bless = ds_list_find_value(global.blessings_list,_blessindex);
		ini_write_string("Blessing " + _ref_bless[?"name"] + " " + _blessindex, "bless_name", _ref_bless[?"Name"]);
		ini_write_string("Blessing " + _ref_bless[?"name"] + " " + _blessindex, "bless_desc", _ref_bless[?"Description"]);
		ini_write_real("Blessing " + _ref_bless[?"name"] + " " + _blessindex, "bless_sprite", _ref_bless[?"Sprite"]);
	}
	
	//for every creature in the party..
	for (var _partyindex = 0; _partyindex < ds_list_size(global.player_team); _partyindex++){
		var _ref_unit = ds_list_find_value(global.player_team,_partyindex);
		ini_write_string("Creature " + _ref_unit[?"name"] + " " + _blessindex, "bless_name", _ref_bless[?"Name"]);
		ini_write_string("Blessing " + _ref_unit[?"name"] + " " + _blessindex, "bless_desc", _ref_bless[?"Description"]);
		ini_write_real("Blessing " + _ref_unit[?"name"] + " " + _blessindex, "bless_sprite", _ref_bless[?"Sprite"]);
	}
	
	//for every creature in the graveyard...
	for (var _graveindex = 0; _blessindex < ds_list_size(global.blessings_list); _blessindex++){
		var _ref_bless = ds_list_find_value(global.blessings_list,_blessindex);
		ini_write_string("Blessing " + _ref_bless[?"name"] + " " + _blessindex, "bless_name", _ref_bless[?"Name"]);
		ini_write_string("Blessing " + _ref_bless[?"name"] + " " + _blessindex, "bless_desc", _ref_bless[?"Description"]);
		ini_write_real("Blessing " + _ref_bless[?"name"] + " " + _blessindex, "bless_sprite", _ref_bless[?"Sprite"]);
	}
	ini_close();

	show_message("Game saved: " + _save_path);
}