function scr_init_new_player(_player,_patron,_blessing){
	switch(_patron){
		case "Lucky":
			//gold based on patron
			global.gold = irandom_range(30,50);
			//player's team setup
			var _new_creature = scr_load_creature("Bush Monkey");
			ds_list_add(global.player_team, _new_creature);
			////blessing setup
			//var _new_bless = scr_load_blessing(_blessing[?"Name"]);
			//ds_list_add(global.blessings_list, _new_bless);
			//player's deck setup
			var _arr = ["Strike","Block","Inspiration","Thorny Whip","Thorny Whip","Poison Ivy"];
			for (var _i = 0; _i < array_length(_arr); _i++){
				var _new_card = scr_load_card(_arr[_i]);		
				ds_list_add(global.card_inventory, _new_card);
			}
			//gear (WIP)
		break;
	}

}