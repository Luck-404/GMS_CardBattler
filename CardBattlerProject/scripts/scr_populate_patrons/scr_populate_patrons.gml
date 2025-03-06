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
				var _new_patron = scr_create_patron("Lucky","God of Adventures",spr_sigil_luck,"Bush Monkey", ["Strike","Block","Inspiration","Thorny Whip","Thorny Whip","Poison Ivy"],["Lucky Clover"],"30-50 Starting Gold",[scr_create_blessing("Lucky","Find items more often",spr_blessing_lucky),scr_create_blessing("Adventurer's Mark", "Encounters are skewed in your favor",spr_blessing_adventurers_mark),scr_create_blessing("Golden Idol","10% more gold from all sources",spr_blessing_golden_idol)]);
			//add patron to the list
				ds_list_add(_output_list,_new_patron);				
			//Merlin (TESTER)
				_new_patron = scr_create_patron("Merlin","God of Druids",spr_sigil_merlin,"Corpseflower", ["Fell","Thorny Whip","Fell","Thorny Whip","Fell"],["Yew Tree Sprig"],"10-20 Starting Gold",[scr_create_blessing("Druid's Kiss","Casting a green spell has a chance to heal",spr_blessing_druids_kiss),scr_create_blessing("Sprouts", "Minions may gain bonus health at spawn",spr_blessing_sprouts),scr_create_blessing("Mulch","Every unit killed gives your units a permanent health buff",spr_blessing_mulch)]);
				//add patron to the list
				ds_list_add(_output_list,_new_patron);			
			//Wolfman (TESTER)
				_new_patron = scr_create_patron("Wolfman","God of the Wilds",spr_sigil_wolfman,"Furn", ["Bulwark","Thorny Whip","Bulwark","Thorny Whip","Bulwark"],["Wolf Fang"],"10-20 Starting Gold",[scr_create_blessing("Howl","Sometimes stun all enemies at the beginning of the round",spr_blessing_howl),scr_create_blessing("Woodsman", "Gain bonus to green damage",spr_blessing_woodsman),scr_create_blessing("Carnivore","Heal on kills",spr_blessing_carnivore)]);
				//add patron to the list
				ds_list_add(_output_list,_new_patron);			
	return _output_list;
}