//////////////////////////////////////////////////////////////////////
//						scr_load_passive							//
//																	//
// > RETURNS A CREATED passive										//
//////////////////////////////////////////////////////////////////////
function scr_load_passive(_passive_name,_unit){
	_loaded_passive = undefined;
	switch(_passive_name){
		case "Spiritborn":
			_loaded_passive = scr_create_passive("Spiritborn","Uncolored, does nothing special",undefined,_unit);
		break;
		
		case "Verdant":
		show_debug_message("loading passive verdant");
			_loaded_passive = scr_create_passive("Verdant","Green, 2x damage to Blue and 0.5x to Red. Casting a healing spell has a 10% chance to summon a Life Spirit, Casting a poison spell has a 10% chance to summon a wasp drone. Casting a venom spell has a 10% chance to summon a serpent.",undefined,_unit);
		break;	
		
	}
	return _loaded_passive;
}