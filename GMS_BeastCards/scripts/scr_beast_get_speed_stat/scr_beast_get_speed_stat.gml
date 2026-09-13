//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_SPEED_STAT
// FUNCTION: Returns the base Speed stat assigned to a Beast species.
//           Speed ranges from 0 to 300 and is used for initiative and ordered
//           battle-trigger resolution.
//
// ARGUMENTS: _str_beast_name is the Beast species whose Speed should be returned.
// RETURNS: The Beast's base Speed stat, or 150 if the Beast name is unknown.
//
//===============================================================================//

function scr_beast_get_speed_stat(_str_beast_name){

	//================//
	//SPEED TABLE//
	//================//
	static _stct_beast_speeds = {

		#region VIRIDIAN
		ARBRAWN      : 55,
		ARGENTBUD    : 110,
		BEAVINE      : 145,
		BRYOBITE     : 35,
		CHITROOPER   : 170,
		CRUSABER     : 165,
		DRYADAE      : 130,
		FIGHTREE     : 25,
		FLITSAGE     : 260,
		FURN         : 245,
		LEPOROOT     : 220,
		LUMBUCK      : 115,
		MAMBARK      : 240,
		MORELUSH     : 90,
		SPOROSE      : 105,
		STRIGIBLOOM  : 230,
		TURFRANTULA  : 205,
		#endregion

		#region CERULEAN
		AMMOMARSH    : 130,
		BLIZZDRIFT   : 225,
		CAUDAQUA     : 255,
		CEPHARIME    : 185,
		CHELONSEA    : 40,
		CORALLIARC   : 95,
		FROSTUSK     : 100,
		GALENATRIUM  : 220,
		GLACIMIGHT   : 110,
		GULFLOW      : 165,
		ISTIRAIN     : 225,
		KELPLATANI   : 110,
		LONTRIVER    : 175,
		MARITIMICE   : 105,
		SALTWAGG     : 150,
		SPHENISKIP   : 160,
		#endregion

		#region VERMILION
		ASCHEMASS    : 55,
		CANIGNIS     : 205,
		DAIMONIS     : 125,
		DRAKOAL      : 180,
		EMBEROOST    : 190,
		HELLSHROOM   : 100,
		IMPARCH      : 275,
		INFERNUS     : 115,
		LAVAROWANA   : 160,
		PYREKNIGHT   : 80,
		PYROPLUME    : 220,
		SANGUINAUT   : 250,
		SLAGOLEM     : 25,
		SOLEMOLD     : 120,
		WRATHOOD     : 140,
		WYRMELTA     : 190
		#endregion
	};

	//================//
	//GET SPEED//
	//================//
	if (variable_struct_exists(_stct_beast_speeds,_str_beast_name)){
		return variable_struct_get(_stct_beast_speeds,_str_beast_name);
	}

	return 150;
}