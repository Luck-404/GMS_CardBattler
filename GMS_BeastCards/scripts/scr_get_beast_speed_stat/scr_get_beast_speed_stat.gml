//===============================================================================//
//
// SCRIPT: SCR_GET_BEAST_SPEED_STAT
// FUNCTION: Returns the base Speed stat for a Beast species.
//           Speed ranges from 0 to 300.
//           Used for initiative and ordered battle-trigger resolution.
//
//===============================================================================//

function scr_get_beast_speed_stat(_str_beast_name){

	switch(_str_beast_name){

		//========//
		//VIRIDIAN//
		//========//
		#region VIRIDIAN

		case "ARBRAWN":       return 55;
		case "ARGENTBUD":     return 110;
		case "BEAVINE":       return 145;
		case "BRYOBITE":      return 35;
		case "CHITROOPER":    return 170;
		case "CRUSABER":      return 165;
		case "DRYADAE":       return 130;
		case "FIGHTREE":      return 25;
		case "FLITSAGE":      return 260;
		case "FURN":          return 245;
		case "LEPOROOT":      return 220;
		case "LUMBUCK":       return 115;
		case "MAMBARK":       return 240;
		case "MORELUSH":      return 90;
		case "SPOROSE":       return 105;
		case "STRIGIBLOOM":   return 230;
		case "TURFRANTULA":   return 205;

		#endregion


		//========//
		//CERULEAN//
		//========//
		#region CERULEAN

		case "AMMOMARSH":     return 130;
		case "BLIZZDRIFT":    return 225;
		case "CAUDAQUA":      return 255;
		case "CEPHARIME":     return 185;
		case "CHELONSEA":     return 40;
		case "CORALLIARC":    return 95;
		case "FROSTUSK":      return 100;
		case "GALENATRIUM":   return 220;
		case "GLACIMIGHT":    return 110;
		case "GULFLOW":       return 165;
		case "ISTIRAIN":      return 225;
		case "KELPLATANI":    return 110;
		case "LONTRIVER":     return 175;
		case "MARITIMICE":    return 105;
		case "SALTWAGG":      return 150;
		case "SPHENISKIP":    return 160;

		#endregion


		//=========//
		//VERMILION//
		//=========//
		#region VERMILION

		case "ASCHEMASS":     return 55;
		case "CANIGNIS":      return 205;
		case "DAIMONIS":      return 125;
		case "DRAKOAL":       return 180;
		case "EMBEROOST":     return 190;
		case "HELLSHROOM":    return 100;
		case "IMPARCH":       return 275;
		case "INFERNUS":      return 115;
		case "LAVAROWANA":    return 160;
		case "PYREKNIGHT":    return 80;
		case "PYROPLUME":     return 220;
		case "SANGUINAUT":    return 250;
		case "SLAGOLEM":      return 25;
		case "SOLEMOLD":      return 120;
		case "WRATHOOD":      return 140;
		case "WYRMELTA":      return 190;

		#endregion
	}

	show_debug_message(
		"BEAST SPEED ERROR | UNKNOWN BEAST: " +
		string(_str_beast_name)
	);

	return 150;
}