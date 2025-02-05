//////////////////////////////////////////////////////////////////////
//					SCR_POPULATE_PATRONS							//
//																	//
// > CREATE A LIST THAT HOLDS ALL PATRONS, EACH PATRON IS A LIST	//
//   MAPPED VALUES WITH KEYS.										//
//////////////////////////////////////////////////////////////////////
function scr_populate_patrons(_output_list){
	//for each patron I want...
		//Green
			//Lucky
				//create a patron (script)
				var _new_patron = scr_create_patron("Lucky","God of Adventures","Bush Monkey", ["Strike","Block","Inspiration","Thorny Whip","Thorny Whip","Poison Ivy"],["Lucky Clover"],irandom_range(15,30),[scr_create_blessing("Lucky","Find items more often"),scr_create_blessing("Adventurer's Mark", "Encounters are skewed in your favor"),scr_create_blessing("Golden Idol","10% more gold from all sources")]);
				//add patron to the list
				ds_list_add(_output_list,_new_patron);				
			//Merlin (TESTER)
				//create a patron (script)
				_new_patron = scr_create_patron("Merlin","God of Druids","Corpseflower", ["Strike","Block","Life Spirit","Thorny Whip","Poison Ivy","Poison Ivy"],["Yew Tree Sprig"],irandom_range(5,15),[scr_create_blessing("Druid's Kiss","Casting a green spell has a chance to heal"),scr_create_blessing("Sprouts", "Minions may gain bonus health at spawn"),scr_create_blessing("Mulch","Every unit killed gives your units a permanent health buff")]);
				//add patron to the list
				ds_list_add(_output_list,_new_patron);			
			//Wolfman (TESTER)
				//create a patron (script)
				_new_patron = scr_create_patron("Wolfman","God of the Wilds","Furn", ["Strike","Block","Beastial Bash","Thorny Whip","Health Berry","Poison Ivy"],["Wolf Fang"],irandom_range(5,15),[scr_create_blessing("Howl","Sometimes stun all enemies at the beginning of the round"),scr_create_blessing("Woodsman", "Gain bonus to green damage"),scr_create_blessing("Carnivore","Heal on kills")]);
				//add patron to the list
				ds_list_add(_output_list,_new_patron);			
	return _output_list;
}