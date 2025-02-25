//////////////////////////////////////////////////////////////////////
//						SCR_ROLL_CREATURE							//
//																	//
// > USED WHEN STOCKING THE MERC SHOPS. STOCK THE SHOPS WITH A		//
//   VARIETY OF MERCS. THE SHOP RESETS EVERY TIME 3 ENCOUNTERS HAVE //
//   BEEN COMPLETED.												//
//////////////////////////////////////////////////////////////////////
function scr_roll_creature() {
var _rand = irandom_range(1,3);
var _creature = undefined;
switch (_rand){
	case 0: //wraith
		_creature = scr_create_creature("Wraith", false, "Uncolored", "None", "None","Ally","Default",irandom_range(30,40),"All","All",undefined, undefined,spr_creature_uncolored_wraith,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default);	
	break;
	
	case 1: //monke
		_creature = scr_create_creature("Bush Monkey", false, "Green", "None", "None","Ally","Default",irandom_range(60,80),"All","All",undefined, undefined,spr_creature_green_bush_monkey,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default);		
	break;
	
	case 2: //corpseflower
		_creature = scr_create_creature("Corpseflower", false, "Green", "None", "None","Ally","Default",irandom_range(25,30),"All","All",undefined, undefined,spr_creature_green_corpseflower,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default);
	break;	
		
	case 3: //furn
		_creature = scr_create_creature("Furn", false, "Green", "None", "None","Ally","Default",irandom_range(40,50),"All","All",undefined, undefined,spr_creature_green_furn,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default);
	break;	
}

	// add a switch here to generate different units
    return _creature;
}