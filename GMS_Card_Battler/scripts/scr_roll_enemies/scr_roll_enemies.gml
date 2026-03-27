//////////////////////////////////////////////////////////////////////
//						SCR_ROLL_ENEMIES							//
//																	//
// > PICKS AND POPULATES 1-5 ENEMIES FROM THE DIFFERENT ROOM TYPES  //
//////////////////////////////////////////////////////////////////////
function scr_roll_enemies(_room_type, _num_enemies) {
	for (var _i = 0; _i < _num_enemies; _i++){
		//choose an enemy based on room type
		switch(_room_type){
			#region OW green
			case "ow_green":
				//randomly select a unit from the 3 possible
				var _unit_picked = irandom_range(1,3);
				switch(_unit_picked){
					case 1:
						//create a bush monkey
						_new_creature = scr_load_creature("Bush Monkey");
						//add them to enemy team
						ds_list_add(global.enemy_party, _new_creature);
					break;
					
					case 2:
						//create a corpseflower
						_new_creature = scr_load_creature("Corpseflower");
						ds_list_add(global.enemy_party, _new_creature);						
					break;
					
					case 3:
						//create a furn
						_new_creature = scr_load_creature("Furn");//add them to enemy team
						ds_list_add(global.enemy_party, _new_creature);						
					break;
				}
			break;
			#endregion
		
			#region Green Route 1
			case "green_1":
				//randomly select a unit from the 3 possible
				_unit_picked = irandom_range(1,3);
				switch(_unit_picked){
					case 1:
						//create a bush monkey
						_new_creature = scr_load_creature("Bush Monkey");
						//add them to enemy team
						ds_list_add(global.enemy_party, _new_creature);
					break;
					
					case 2:
						//create a corpseflower
						_new_creature = scr_load_creature("Corpseflower");
						ds_list_add(global.enemy_party, _new_creature);						
					break;
					
					case 3:
						//create a furn
						_new_creature = scr_load_creature("Furn");//add them to enemy team
						ds_list_add(global.enemy_party, _new_creature);						
					break;
				}
			break;
			#endregion
		
			#region Green Route 3
			case "green_3":
				//randomly select a unit from the 3 possible
				_unit_picked = irandom_range(1,3);
				switch(_unit_picked){
					case 1:
						//create a bush monkey
						_new_creature = scr_load_creature("Bush Monkey");
						//add them to enemy team
						ds_list_add(global.enemy_party, _new_creature);
					break;
					
					case 2:
						//create a corpseflower
						_new_creature = scr_load_creature("Corpseflower");
						ds_list_add(global.enemy_party, _new_creature);						
					break;
					
					case 3:
						//create a furn
						_new_creature = scr_load_creature("Furn");//add them to enemy team
						ds_list_add(global.enemy_party, _new_creature);						
					break;
				}
			break;
			#endregion
		}
	}
}