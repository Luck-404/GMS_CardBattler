//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_GET_EGG_BEAST_ID
// FUNCTION: Returns the Beast id associated with an egg item id.
//           Used by inventory egg-use behavior.
//           Returns undefined when the item is not a recognized egg.
//
// ARGUMENTS: _str_item_id is the egg item id to resolve.
// RETURNS: The associated Beast id string, or undefined if unrecognized.
//
//===============================================================================//

function scr_inventory_get_egg_beast_id(_str_item_id){

	//================//
	//RESOLVE EGG ID//
	//================//
	switch (_str_item_id){

		#region VIRIDIAN

		case "EGG_ARBRAWN":
			return "ARBRAWN";

		case "EGG_ARGENTBUD":
			return "ARGENTBUD";

		case "EGG_BEAVINE":
			return "BEAVINE";

		case "EGG_BRYOBITE":
			return "BRYOBITE";

		case "EGG_CHITROOPER":
			return "CHITROOPER";

		case "EGG_CRUSABER":
			return "CRUSABER";

		case "EGG_DRYADAE":
			return "DRYADAE";

		case "EGG_FIGHTREE":
			return "FIGHTREE";

		case "EGG_FLITSAGE":
			return "FLITSAGE";

		case "EGG_FURN":
			return "FURN";

		case "EGG_LEPOROOT":
			return "LEPOROOT";

		case "EGG_LUMBUCK":
			return "LUMBUCK";

		case "EGG_MAMBARK":
			return "MAMBARK";

		case "EGG_MORELUSH":
			return "MORELUSH";

		case "EGG_SPOROSE":
			return "SPOROSE";

		case "EGG_STRIGIBLOOM":
			return "STRIGIBLOOM";

		case "EGG_TURFRANTULA":
			return "TURFRANTULA";

		#endregion

		#region CERULEAN

		case "EGG_AMMOMARSH":
			return "AMMOMARSH";

		case "EGG_BLIZZDRIFT":
			return "BLIZZDRIFT";

		case "EGG_CAUDAQUA":
			return "CAUDAQUA";

		case "EGG_CEPHARIME":
			return "CEPHARIME";

		case "EGG_CHELONSEA":
			return "CHELONSEA";

		case "EGG_CORALLIARC":
			return "CORALLIARC";

		case "EGG_FROSTUSK":
			return "FROSTUSK";

		case "EGG_GALENATRIUM":
			return "GALENATRIUM";

		case "EGG_GLACIMIGHT":
			return "GLACIMIGHT";

		case "EGG_GULFLOW":
			return "GULFLOW";

		case "EGG_ISTIRAIN":
			return "ISTIRAIN";

		case "EGG_KELPLATANI":
			return "KELPLATANI";

		case "EGG_LONTRIVER":
			return "LONTRIVER";

		case "EGG_MARITIMICE":
			return "MARITIMICE";

		case "EGG_SALTWAGG":
			return "SALTWAGG";

		case "EGG_SPHENISKIP":
			return "SPHENISKIP";

		#endregion

		#region VERMILION

		case "EGG_ASCHEMASS":
			return "ASCHEMASS";

		case "EGG_CANIGNIS":
			return "CANIGNIS";

		case "EGG_DAIMONIS":
			return "DAIMONIS";

		case "EGG_DRAKOAL":
			return "DRAKOAL";

		case "EGG_EMBEROOST":
			return "EMBEROOST";

		case "EGG_HELLSHROOM":
			return "HELLSHROOM";

		case "EGG_IMPARCH":
			return "IMPARCH";

		case "EGG_INFERNUS":
			return "INFERNUS";

		case "EGG_LAVAROWANA":
			return "LAVAROWANA";

		case "EGG_PYREKNIGHT":
			return "PYREKNIGHT";

		case "EGG_PYROPLUME":
			return "PYROPLUME";

		case "EGG_SANGUINAUT":
			return "SANGUINAUT";

		case "EGG_SLAGOLEM":
			return "SLAGOLEM";

		case "EGG_SOLEMOLD":
			return "SOLEMOLD";

		case "EGG_WRATHOOD":
			return "WRATHOOD";

		case "EGG_WYRMELTA":
			return "WYRMELTA";

		#endregion
	}

	return undefined;
}