//////////////////////////////////////////////////////////////////////
//						SCR_LOAD_BLESSING							//
//																	//
// > LOADS BLESSING BASED ON NAME OF BLESSING- LOAD AND SAVE		//
//////////////////////////////////////////////////////////////////////
function scr_load_blessing(_blessingname){
	_loadedblessing = undefined;
	switch(_blessingname){
		case "Lucky":
			_loadedblessing = scr_create_blessing("Lucky","Find items more often",spr_blessing_lucky);
		break;
		
		case "Golden Idol":
			_loadedblessing = scr_create_blessing("Golden Idol","10% more gold from all sources",spr_blessing_golden_idol);
		break;
		
		case "Adventurer's Mark":
			_loadedblessing = scr_create_blessing("Adventurer's Mark", "Encounters are skewed in your favor",spr_blessing_adventurers_mark);
		break;
	}
	return _loadedblessing;
}