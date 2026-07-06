//===============================================================================//
//
// SCRIPT: scr_init_item_pool
// FUNCTION: Initializes the global item pool.
//           Adds every obtainable item ID to the master item pool.
//           Used for random item generation and loot selection.
//
//===============================================================================//
function scr_init_item_pool(){

	#region QUEST
	ds_list_add(global.list_pool_items,"QUEST_IMPORTANT_NOTEBOOK");
	#endregion

	#region HELD
	ds_list_add(global.list_pool_items,"HELD_POWERFUL_STONE");
	#endregion

	#region CONSUMABLE
	ds_list_add(global.list_pool_items,"CONSUMABLE_HEALING_SALVE");
	#endregion

	#region PRISM
	ds_list_add(global.list_pool_items,"PRISM_COMMON");
	ds_list_add(global.list_pool_items,"PRISM_UNCOMMON");
	ds_list_add(global.list_pool_items,"PRISM_RARE");
	ds_list_add(global.list_pool_items,"PRISM_EPIC");
	ds_list_add(global.list_pool_items,"PRISM_LEGENDARY");
	ds_list_add(global.list_pool_items,"PRISM_ARCWORK");
	#endregion
	
	#region EGG

		#region VIRIDIAN
		ds_list_add(global.list_pool_items,"EGG_ARBRAWN");
		ds_list_add(global.list_pool_items,"EGG_ARGENTBUD");
		ds_list_add(global.list_pool_items,"EGG_BEAVINE");
		ds_list_add(global.list_pool_items,"EGG_BRYOBITE");
		ds_list_add(global.list_pool_items,"EGG_CHITROOPER");
		ds_list_add(global.list_pool_items,"EGG_CRUSABER");
		ds_list_add(global.list_pool_items,"EGG_DRYADAE");
		ds_list_add(global.list_pool_items,"EGG_FIGHTREE");
		ds_list_add(global.list_pool_items,"EGG_FLITSAGE");
		ds_list_add(global.list_pool_items,"EGG_FURN");
		ds_list_add(global.list_pool_items,"EGG_LEPOROOT");
		ds_list_add(global.list_pool_items,"EGG_LUMBUCK");
		ds_list_add(global.list_pool_items,"EGG_MAMBARK");
		ds_list_add(global.list_pool_items,"EGG_MORELUSH");
		ds_list_add(global.list_pool_items,"EGG_SPOROSE");
		ds_list_add(global.list_pool_items,"EGG_STRIGIBLOOM");
		ds_list_add(global.list_pool_items,"EGG_TURFRANTULA");
		#endregion

		#region CERULEAN
		ds_list_add(global.list_pool_items,"EGG_AMMOMARSH");
		ds_list_add(global.list_pool_items,"EGG_BLIZZDRIFT");
		ds_list_add(global.list_pool_items,"EGG_CAUDAQUA");
		ds_list_add(global.list_pool_items,"EGG_CEPHARIME");
		ds_list_add(global.list_pool_items,"EGG_CHELONSEA");
		ds_list_add(global.list_pool_items,"EGG_CORALLIARC");
		ds_list_add(global.list_pool_items,"EGG_FROSTUSK");
		ds_list_add(global.list_pool_items,"EGG_GALENATRIUM");
		ds_list_add(global.list_pool_items,"EGG_GLACIMIGHT");
		ds_list_add(global.list_pool_items,"EGG_GULFLOW");
		ds_list_add(global.list_pool_items,"EGG_ISTIRAIN");
		ds_list_add(global.list_pool_items,"EGG_KELPLATANI");
		ds_list_add(global.list_pool_items,"EGG_LONTRIVER");
		ds_list_add(global.list_pool_items,"EGG_MARITIMICE");
		ds_list_add(global.list_pool_items,"EGG_SALTWAGG");
		ds_list_add(global.list_pool_items,"EGG_SPHENISKIP");
		#endregion

		#region VERMILION
		ds_list_add(global.list_pool_items,"EGG_ASCHEMASS");
		ds_list_add(global.list_pool_items,"EGG_CANIGNIS");
		ds_list_add(global.list_pool_items,"EGG_DAIMONIS");
		ds_list_add(global.list_pool_items,"EGG_DRAKOAL");
		ds_list_add(global.list_pool_items,"EGG_EMBEROOST");
		ds_list_add(global.list_pool_items,"EGG_HELLSHROOM");
		ds_list_add(global.list_pool_items,"EGG_IMPARCH");
		ds_list_add(global.list_pool_items,"EGG_INFERNUS");
		ds_list_add(global.list_pool_items,"EGG_LAVAROWANA");
		ds_list_add(global.list_pool_items,"EGG_PYREKNIGHT");
		ds_list_add(global.list_pool_items,"EGG_PYROPLUME");
		ds_list_add(global.list_pool_items,"EGG_SANGUINAUT");
		ds_list_add(global.list_pool_items,"EGG_SLAGOLEM");
		ds_list_add(global.list_pool_items,"EGG_SOLEMOLD");
		ds_list_add(global.list_pool_items,"EGG_WRATHOOD");
		ds_list_add(global.list_pool_items,"EGG_WYRMELTA");
		#endregion

	#endregion
}