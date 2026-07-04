//===============================================================================//
//
// SCRIPT: SCR_GET_EGG_BEAST_ID
// FUNCTION: Returns the beast id associated with an egg item id.
//           Used by inventory egg-use behavior.
//           Returns undefined when the item is not a recognized egg.
//
//===============================================================================//
function scr_get_egg_beast_id(_str_item_id){

	switch(_str_item_id){

		#region VIRIDIAN
		case "EGG_ARBRAWN":
			return "ARBRAWN";
		break;

		case "EGG_ARGENTBUD":
			return "ARGENTBUD";
		break;

		case "EGG_BEAVINE":
			return "BEAVINE";
		break;

		case "EGG_BRYOBITE":
			return "BRYOBITE";
		break;

		case "EGG_CHITROOPER":
			return "CHITROOPER";
		break;

		case "EGG_CRUSABER":
			return "CRUSABER";
		break;

		case "EGG_DRYADAE":
			return "DRYADAE";
		break;

		case "EGG_FIGHTREE":
			return "FIGHTREE";
		break;

		case "EGG_FLITSAGE":
			return "FLITSAGE";
		break;

		case "EGG_FURN":
			return "FURN";
		break;

		case "EGG_LEPOROOT":
			return "LEPOROOT";
		break;

		case "EGG_LUMBUCK":
			return "LUMBUCK";
		break;

		case "EGG_MAMBARK":
			return "MAMBARK";
		break;

		case "EGG_MORELUSH":
			return "MORELUSH";
		break;

		case "EGG_SPOROSE":
			return "SPOROSE";
		break;

		case "EGG_STRIGIBLOOM":
			return "STRIGIBLOOM";
		break;

		case "EGG_TURFRANTULA":
			return "TURFRANTULA";
		break;
		#endregion

		#region CERULEAN
		case "EGG_AMMOMARSH":
			return "AMMOMARSH";
		break;

		case "EGG_BLIZZDRIFT":
			return "BLIZZDRIFT";
		break;

		case "EGG_CAUDAQUA":
			return "CAUDAQUA";
		break;

		case "EGG_CEPHARIME":
			return "CEPHARIME";
		break;

		case "EGG_CHELONSEA":
			return "CHELONSEA";
		break;

		case "EGG_CORALLIARC":
			return "CORALLIARC";
		break;

		case "EGG_FROSTUSK":
			return "FROSTUSK";
		break;

		case "EGG_GALENATRIUM":
			return "GALENATRIUM";
		break;

		case "EGG_GLACIMIGHT":
			return "GLACIMIGHT";
		break;

		case "EGG_GULFLOW":
			return "GULFLOW";
		break;

		case "EGG_ISTIRAIN":
			return "ISTIRAIN";
		break;

		case "EGG_KELPLATANI":
			return "KELPLATANI";
		break;

		case "EGG_LONTRIVER":
			return "LONTRIVER";
		break;

		case "EGG_MARITIMICE":
			return "MARITIMICE";
		break;

		case "EGG_SALTWAGG":
			return "SALTWAGG";
		break;

		case "EGG_SPHENISKIP":
			return "SPHENISKIP";
		break;
		#endregion

		#region VERMILION
		case "EGG_ASCHEMASS":
			return "ASCHEMASS";
		break;

		case "EGG_CANIGNIS":
			return "CANIGNIS";
		break;

		case "EGG_DAIMONIS":
			return "DAIMONIS";
		break;

		case "EGG_DRAKOAL":
			return "DRAKOAL";
		break;

		case "EGG_EMBEROOST":
			return "EMBEROOST";
		break;

		case "EGG_HELLSHROOM":
			return "HELLSHROOM";
		break;

		case "EGG_IMPARCH":
			return "IMPARCH";
		break;

		case "EGG_INFERNUS":
			return "INFERNUS";
		break;

		case "EGG_LAVAROWANA":
			return "LAVAROWANA";
		break;

		case "EGG_PYREKNIGHT":
			return "PYREKNIGHT";
		break;

		case "EGG_PYROPLUME":
			return "PYROPLUME";
		break;

		case "EGG_SANGUINAUT":
			return "SANGUINAUT";
		break;

		case "EGG_SLAGOLEM":
			return "SLAGOLEM";
		break;

		case "EGG_SOLEMOLD":
			return "SOLEMOLD";
		break;

		case "EGG_WRATHOOD":
			return "WRATHOOD";
		break;

		case "EGG_WYRMELTA":
			return "WYRMELTA";
		break;
		#endregion
	}

	return undefined;
}