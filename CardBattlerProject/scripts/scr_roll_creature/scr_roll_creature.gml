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
		_creature = scr_load_creature("Wraith");
	break;
	
	case 1: //monke
		_creature = scr_load_creature("Bush Monkey");
	break;
	
	case 2: //corpseflower
		_creature = scr_load_creature("Corpseflower");
	break;	
		
	case 3: //furn
		_creature = scr_load_creature("Furn");
	break;	
}

	// add a switch here to generate different units
    return _creature;
}