function scr_init_loaded_player(_player,_file_path){
	if (file_exists(global.save_folder + _file_path)) {
	    ini_open(global.save_folder + _file_path);
		    //LOAD MAP
			global.saved_room = ini_read_string("Player", "Map","NONEFOUND");
			
			//LOAD PLAYER X
			global.player_xpos = ini_read_real("Player", "x_pos",0);		
			
			//LOAD PLAYER Y
			global.player_ypos = ini_read_real("Player", "y_pos",0);
			
			//load gold
			global.gold = ini_read_real("Gold", "gold_count", 0);
			
			//read all card values in
			for (var _cardindex = 0; _cardindex < 40; _cardindex++){
				var _ref_card_name = ini_read_string("Card_" + string(_cardindex), "card_name","Default");
				if (_ref_card_name == "Default"){
				 break;	
				} else {
					//basd on card name, spawn that card for the player
						var _new_card = scr_load_card(_ref_card_name);
						ds_list_add(global.card_inventory, _new_card);
				}
			}
			
			//read all blessing values in
			for (var _blessindex = 0; _blessindex < 100; _blessindex++){
				var _ref_bless_name = ini_read_string("Blessing_" + string(_blessindex), "bless_name","Default");
				if (_ref_bless_name == "Default"){
				 break;	
				} else {
					//basd on card name, spawn that card for the player
						var _new_bless = scr_load_blessing(_ref_bless_name);
						ds_list_add(global.blessings_list, _new_bless);
				}
			}
			
			
			//read all creatures in for team
			for (var _creatureindex = 0; _creatureindex < 5; _creatureindex++){
				var _ref_creature_name = ini_read_string("Creature_" + string(_creatureindex), "creature_name","Default");
				if (_ref_creature_name == "Default"){
				 break;	
				} else {
						var _new_creature = scr_load_creature(_ref_creature_name);
						_new_creature[?"hp"] = ini_read_real("Creature_" + string(_creatureindex), "creature_max_hp",1);
						_new_creature[?"curhp"] = ini_read_real("Creature_" + string(_creatureindex), "creature_cur_hp",1);
						ds_list_add(global.player_team, _new_creature);
				}
			}			
			
			//read all graveyard creatures
			for (var _deadindex = 0; _deadindex < 100; _deadindex++){
				var _ref_dead_name = ini_read_string("Graveyard_" + string(_deadindex), "creature_name","Default");
				if (_ref_dead_name == "Default"){
				 break;	
				} else {
						var _new_dead = scr_load_creature(_ref_dead_name);
						ds_list_add(global.graveyard, _new_dead);
				}
			}						
	    ini_close();

	}
}