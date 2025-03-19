//////////////////////////////////////////////////////////////////////
//						SCR_LOAD_CREATURE							//
//																	//
// > RETURNS A CREATED CREATURE										//
//////////////////////////////////////////////////////////////////////
function scr_load_creature(_creaturename){
	_loadedcreature = undefined;
	switch(_creaturename){
		case "Wraith":
			_loadedcreature = scr_create_creature("Wraith", false, "Uncolored", "None", "None","Ally","Default",irandom_range(30,40),"Any","Any",undefined, undefined,spr_creature_uncolored_wraith,snd_creature_wraith_hurt,snd_creature_wraith_death,["Spiritborn"]);
		break;
		
		case "Bush Monkey":
			_loadedcreature = scr_create_creature("Bush Monkey", false, "Green", "None", "None","Ally","Default",irandom_range(60,80),"Martial","Adventurer",undefined, undefined,spr_creature_green_bush_monkey,snd_creature_wraith_hurt,snd_creature_wraith_death,["Verdant"]);
			//_loadedcreature = scr_create_creature("Bush Monkey", false, "Green", "None", "None","Ally","Default",5,"Martial","Adventurer",undefined, undefined,spr_creature_green_bush_monkey,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default);
		break;	
		
		case "Corpseflower":
			_loadedcreature = scr_create_creature("Corpseflower", false, "Green", "None", "None","Ally","Default",irandom_range(25,30),"Magical","Summoner",undefined, undefined,spr_creature_green_corpseflower,snd_creature_wraith_hurt,snd_creature_wraith_death,["Verdant"]);
		break;	
		
		case "Furn":
			_loadedcreature = scr_create_creature("Furn", false, "Green", "None", "None","Ally","Default",irandom_range(40,50),"Technical","Hunter",undefined, undefined,spr_creature_green_furn,snd_creature_wraith_hurt,snd_creature_wraith_death,["Verdant"]);
		break;			
	}
	return _loadedcreature;
}