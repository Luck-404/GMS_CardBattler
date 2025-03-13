//////////////////////////////////////////////////////////////////////
//						SCR_INIT_NEW_PLAYER							//
//																	//
// > CREATE A NEW PLAYER BASED ON THE SELECTED PATRON				//
//////////////////////////////////////////////////////////////////////
function scr_init_new_player(_player,_patron,_blessing){
	switch(_patron){
		case "Lucky":
			//gold based on patron
			global.gold = irandom_range(30,50);
			//player's team setup
			var _new_creature = scr_load_creature("Bush Monkey");
			ds_list_add(global.player_party, _new_creature);		
			
			_new_creature = scr_load_creature("Furn");
			ds_list_add(global.player_party, _new_creature);
			
			_new_creature = scr_load_creature("Corpseflower");
			ds_list_add(global.player_party, _new_creature);

			////blessing setup TODO
			//var _new_bless = scr_load_blessing(_blessing[?"Name"]);
			//ds_list_add(global.player_blessings_list, _new_bless);
			
			//player's deck setup
			//var _arr = ["Strike","Block","Inspiration","Thorny Whip","Thorny Whip","Poison Ivy","Bramblet","Bloodbeak","Serpent Summon","Life Spirit","Bulwark"];
			var _arr = ["Beastial Bash","Poison Ivy","Poison Ivy"];
				
		for (var _i = 0; _i < array_length(_arr); _i++){
				var _new_card = scr_load_card(_arr[_i]);		
				ds_list_add(global.player_deck, _new_card);
			}
			//gear (TODO)
		break;
		
		case "Merlin":
			//gold based on patron
			global.gold = irandom_range(10,20);
			//player's team setup
			_new_creature = scr_load_creature("Corpseflower");
			ds_list_add(global.player_party, _new_creature);
			////blessing setup (TODO)
			//var _new_bless = scr_load_blessing(_blessing[?"Name"]);
			//ds_list_add(global.player_blessings_list, _new_bless);
			//player's deck setup
			_arr = ["Fell","Thorny Whip","Fell","Thorny Whip","Fell"];
			for (var _i = 0; _i < array_length(_arr); _i++){
				var _new_card = scr_load_card(_arr[_i]);		
				ds_list_add(global.player_deck, _new_card);
			}
			//gear (TODO)
		break;
		
		case "Wolfman":
			//gold based on patron
			global.gold = irandom_range(10,20);
			//player's team setup
			_new_creature = scr_load_creature("Furn");
			ds_list_add(global.player_party, _new_creature);
			////blessing setup (TODO)
			//var _new_bless = scr_load_blessing(_blessing[?"Name"]);
			//ds_list_add(global.player_blessings_list, _new_bless);
			//player's deck setup
			_arr = ["Bulwark","Thorny Whip","Bulwark","Thorny Whip","Bulwark"];
			for (var _i = 0; _i < array_length(_arr); _i++){
				var _new_card = scr_load_card(_arr[_i]);		
				ds_list_add(global.player_deck, _new_card);
			}
			//gear (TODO)
		break;		
	}

}