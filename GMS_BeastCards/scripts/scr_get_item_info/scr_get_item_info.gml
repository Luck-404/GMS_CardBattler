//===============================================================================//
//
// SCRIPT: SCR_GET_ITEM_INFO
// FUNCTION: Creates a new item struct from an item id.
//           Populates item display data, behavior data, and stack data.
//           Assigns a unique item uid before returning the item.
//
//===============================================================================//

function scr_get_item_info(_str_item_id){
	var _stct_return_item = {
		_str_item_id : _str_item_id,
		_str_item_name : "DEFAULT",
		_spr_item : spr_item_egg_arbrawn,
		_str_item_type : undefined,
		_scr_item : undefined,
		_str_item_desc : "DEFAULT",
		_flag_stackable : false,
		_ct_item_amount : 1,
		_ct_item_max_amount : 1,
		_uid_item : global.uid_next_item
	};

	switch(_str_item_id){

		#region QUEST
		case "QUEST_IMPORTANT_NOTEBOOK":
			_stct_return_item._str_item_name = "IMPORTANT NOTEBOOK";
			_stct_return_item._spr_item = spr_item_quest_important_notebook;
			_stct_return_item._str_item_type = "QUEST";
			_stct_return_item._scr_item = scr_item_quest_important_notebook;
			_stct_return_item._str_item_desc = "An important notebook used for completing a quest.";
			_stct_return_item._flag_stackable = false;
			_stct_return_item._ct_item_amount = 1;
			_stct_return_item._ct_item_max_amount = 1;
		break;
		#endregion

		#region CONSUMABLE
		case "CONSUMABLE_HEALING_SALVE":
			_stct_return_item._str_item_name = "HEALING SALVE";
			_stct_return_item._spr_item = spr_item_consumable_healing_salve;
			_stct_return_item._str_item_type = "CONSUMABLE";
			_stct_return_item._scr_item = scr_item_consumable_healing_salve;
			_stct_return_item._str_item_desc = "A healing balm that can be used to heal beasts.";
			_stct_return_item._flag_stackable = true;
			_stct_return_item._ct_item_amount = 1;
			_stct_return_item._ct_item_max_amount = 10;
		break;
		#endregion

		#region PRISM
		case "PRISM_BASIC_PRISM":
			_stct_return_item._str_item_name = "BASIC PRISM";
			_stct_return_item._spr_item = spr_item_prism_basic;
			_stct_return_item._str_item_type = "PRISM";
			_stct_return_item._scr_item = undefined;
			_stct_return_item._str_item_desc = "Used to capture beasts.";
			_stct_return_item._flag_stackable = true;
			_stct_return_item._ct_item_amount = 1;
			_stct_return_item._ct_item_max_amount = 10;
		break;
		#endregion

		#region HELD
		case "HELD_POWERFUL_STONE":
			_stct_return_item._str_item_name = "POWERFUL STONE";
			_stct_return_item._spr_item = spr_item_held_powerful_stone;
			_stct_return_item._str_item_type = "HELD";
			_stct_return_item._scr_item = scr_item_held_powerful_stone;
			_stct_return_item._str_item_desc = "Can be given to a beast to increase their power.";
			_stct_return_item._flag_stackable = false;
			_stct_return_item._ct_item_amount = 1;
			_stct_return_item._ct_item_max_amount = 1;
		break;
		#endregion

		#region EGG
			#region VIRIDIAN
				#region ARBRAWN
				case "EGG_ARBRAWN":
					_stct_return_item._str_item_name = "ARBRAWN EGG";
					_stct_return_item._spr_item = spr_item_egg_arbrawn;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Arbrawn.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;
				break;
				#endregion
			
				#region ARGENTBUD
				case "EGG_ARGENTBUD":				
					_stct_return_item._str_item_name = "ARGENTBUD EGG";
					_stct_return_item._spr_item = spr_item_egg_argentbud;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Argentbud.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region BEAVINE
				case "EGG_BEAVINE":				
					_stct_return_item._str_item_name = "BEAVINE EGG";
					_stct_return_item._spr_item = spr_item_egg_beavine;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Beavine.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region BRYOBITE
				case "EGG_BRYOBITE":				
					_stct_return_item._str_item_name = "BRYOBITE EGG";
					_stct_return_item._spr_item = spr_item_egg_bryobite;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Bryobite.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;				
				break;					
				#endregion
			
				#region CHITROOPER
				case "EGG_CHITROOPER":				
					_stct_return_item._str_item_name = "CHITROOPER EGG";
					_stct_return_item._spr_item = spr_item_egg_chitropper;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Chitrooper.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;						
				#endregion
			
				#region CRUSABER
				case "EGG_CRUSABER":				
					_stct_return_item._str_item_name = "CRUSABER EGG";
					_stct_return_item._spr_item = spr_item_egg_crusaber;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Crusaber.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;						
				#endregion
			
				#region DRYADAE
				case "EGG_DRYADAE":				
					_stct_return_item._str_item_name = "DRYADAE EGG";
					_stct_return_item._spr_item = spr_item_egg_dryadae;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Dryadae.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;
				break;						
				#endregion
			
				#region FIGHTREE
				case "EGG_FIGHTREE":				
					_stct_return_item._str_item_name = "FIGHTREE EGG";
					_stct_return_item._spr_item = spr_item_egg_fightree;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Fightree.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;						
				#endregion
			
				#region FLITSAGE
				case "EGG_FLITSAGE":				
					_stct_return_item._str_item_name = "FLITSAGE EGG";
					_stct_return_item._spr_item = spr_item_egg_flitsage;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Flitsage.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;						
				#endregion
			
				#region FURN
				case "EGG_FURN":				
					_stct_return_item._str_item_name = "FURN EGG";
					_stct_return_item._spr_item = spr_item_egg_furn;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Furn.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;						
				#endregion
			
				#region LEPOROOT
				case "EGG_LEPOROOT":				
					_stct_return_item._str_item_name = "LEPOROOT EGG";
					_stct_return_item._spr_item = spr_item_egg_leporoot;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Leporoot.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;						
				#endregion
			
				#region LUMBUCK
				case "EGG_LUMBUCK":				
					_stct_return_item._str_item_name = "LUMBUCK EGG";
					_stct_return_item._spr_item = spr_item_egg_lumbuck;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Lumbuck.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;	
				#endregion
			
				#region MAMBARK
				case "EGG_MAMBARK":				
					_stct_return_item._str_item_name = "MAMBARK EGG";
					_stct_return_item._spr_item = spr_item_egg_mambark;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Mambark.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;						
				#endregion
			
				#region MORELUSH
				case "EGG_MORELUSH":				
					_stct_return_item._str_item_name = "MORELUSH EGG";
					_stct_return_item._spr_item = spr_item_egg_morelush;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Morelush.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;						
				#endregion
			
				#region SPOROSE
				case "EGG_SPOROSE":				
					_stct_return_item._str_item_name = "SPOROSE EGG";
					_stct_return_item._spr_item = spr_item_egg_sporose;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Sporose.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;						
				#endregion
			
				#region STRIGIBLOOM
				case "EGG_STRIGIBLOOM":				
					_stct_return_item._str_item_name = "STRIGIBLOOM EGG";
					_stct_return_item._spr_item = spr_item_egg_strigibloom;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Strigibloom.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;						
				#endregion
			
				#region TURFRANTULA		
				case "EGG_TURFRANTULA":				
					_stct_return_item._str_item_name = "TURFRANTULA EGG";
					_stct_return_item._spr_item = spr_item_egg_turfrantula;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Turfrantula.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;		
				#endregion
			#endregion		
			#region CERULEAN
				#region AMMOMARSH
				case "EGG_AMMOMARSH":
					_stct_return_item._str_item_name = "AMMOMARSH EGG";
					_stct_return_item._spr_item = spr_item_egg_ammomarsh;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Ammomarsh.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;
				break;
				#endregion
			
				#region BLIZZDRIFT
				case "EGG_BLIZZDRIFT":				
					_stct_return_item._str_item_name = "BLIZZDRIFT EGG";
					_stct_return_item._spr_item = spr_item_egg_blizzdrift;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Blizzdrift.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region CAUDAQUA
				case "EGG_CAUDAQUA":					
					_stct_return_item._str_item_name = "CAUDAQUA EGG";
					_stct_return_item._spr_item = spr_item_egg_caudaqua;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Caudaqua.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;			
				break;
				#endregion
			
				#region CEPHARIME
				case "EGG_CEPHARIME":					
					_stct_return_item._str_item_name = "CEPHARIME EGG";
					_stct_return_item._spr_item = spr_item_egg_cepharime;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Cepharime.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region CHELONSEA
				case "EGG_CHELONSEA":					
					_stct_return_item._str_item_name = "CHELONSEA EGG";
					_stct_return_item._spr_item = spr_item_egg_chelonsea;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Chelonsea.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;				
				break;
				#endregion
			
				#region CORALLIARC
				case "EGG_CORALLIARC":					
					_stct_return_item._str_item_name = "CORALLIARC EGG";
					_stct_return_item._spr_item = spr_item_egg_coralliarc;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Coralliarc.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;
				break;					
				#endregion
			
				#region FROSTUSK
				case "EGG_FROSTUSK":					
					_stct_return_item._str_item_name = "FROSTUSK EGG";
					_stct_return_item._spr_item = spr_item_egg_frostusk;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Frostusk.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region GALENATRIUM
				case "EGG_GALENATRIUM":					
					_stct_return_item._str_item_name = "GALENATRIUM EGG";
					_stct_return_item._spr_item = spr_item_egg_galenatrium;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Galenatrium.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region GLACIMIGHT
				case "EGG_GLACIMIGHT":					
					_stct_return_item._str_item_name = "GLACIMIGHT EGG";
					_stct_return_item._spr_item = spr_item_egg_glacimight;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Glacimight.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region GULFLOW
				case "EGG_GULFLOW":			
					_stct_return_item._str_item_name = "GULFLOW EGG";
					_stct_return_item._spr_item = spr_item_egg_gulflow;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Gulflow.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region ISTIRAIN
				case "EGG_ISTIRAIN":					
					_stct_return_item._str_item_name = "ISTIRAIN EGG";
					_stct_return_item._spr_item = spr_item_egg_istirain;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Istirain.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region KELPLATANI
				case "EGG_KELPLATANI":					
					_stct_return_item._str_item_name = "KELPLATANI EGG";
					_stct_return_item._spr_item = spr_item_egg_kelplatani;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Kelplatani.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region LONTRIVER
				case "EGG_LONTRIVER":					
					_stct_return_item._str_item_name = "LONTRIVER EGG";
					_stct_return_item._spr_item = spr_item_egg_lontriver;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Lontriver.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region MARITIMICE
				case "EGG_MARITIMICE":					
					_stct_return_item._str_item_name = "MARITIMICE EGG";
					_stct_return_item._spr_item = spr_item_egg_maritimice;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Maritimice.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region SALTWAGG
				case "EGG_SALTWAGG":					
					_stct_return_item._str_item_name = "SALTWAGG EGG";
					_stct_return_item._spr_item = spr_item_egg_saltwagg;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Saltwagg.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region SPHENISKIP
				case "EGG_SPHENISKIP":					
					_stct_return_item._str_item_name = "SPHENISKIP EGG";
					_stct_return_item._spr_item = spr_item_egg_spheniskip;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Spheniskip.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			#endregion				
			#region VERMILION
				#region ASCHEMASS
				case "EGG_ASCHEMASS":
					_stct_return_item._str_item_name = "ASCHEMASS EGG";
					_stct_return_item._spr_item = spr_item_egg_achemass;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Aschemass.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;
				break;
				#endregion
			
				#region CANIGNIS
				case "EGG_CANIGNIS":				
					_stct_return_item._str_item_name = "CANIGNIS EGG";
					_stct_return_item._spr_item = spr_item_egg_canignis;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Canignis.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region DAIMONIS
				case "EGG_DAIMONIS":					
					_stct_return_item._str_item_name = "DAIMONIS EGG";
					_stct_return_item._spr_item = spr_item_egg_daimonis;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Daimonis.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;			
				break;
				#endregion
			
				#region DRAKOAL
				case "EGG_DRAKOAL":					
					_stct_return_item._str_item_name = "DRAKOAL EGG";
					_stct_return_item._spr_item = spr_item_egg_drakoal;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Drakoal.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region EMBEROOST
				case "EGG_EMBEROOST":					
					_stct_return_item._str_item_name = "EMBEROOST EGG";
					_stct_return_item._spr_item = spr_item_egg_emberoost;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Emberoost.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;				
				break;
				#endregion
			
				#region HELLSHROOM
				case "EGG_HELLSHROOM":					
					_stct_return_item._str_item_name = "HELLSHROOM EGG";
					_stct_return_item._spr_item = spr_item_egg_hellshroom;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Hellshroom.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;
				break;					
				#endregion
			
				#region IMPARCH
				case "EGG_IMPARCH":					
					_stct_return_item._str_item_name = "IMPARCH EGG";
					_stct_return_item._spr_item = spr_item_egg_imparch;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Imparch.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region INFERNUS
				case "EGG_INFERNUS":					
					_stct_return_item._str_item_name = "INFERNUS EGG";
					_stct_return_item._spr_item = spr_item_egg_infernus;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Infernus.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region LAVAROWANA
				case "EGG_LAVAROWANA":					
					_stct_return_item._str_item_name = "LAVAROWANA EGG";
					_stct_return_item._spr_item = spr_item_egg_lavarowana;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Lavarowana.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region PYREKNIGHT
				case "EGG_PYREKNIGHT":			
					_stct_return_item._str_item_name = "PYREKNIGHT EGG";
					_stct_return_item._spr_item = spr_item_egg_pyreknight;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Pyreknight.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region PYROPLUME
				case "EGG_PYROPLUME":					
					_stct_return_item._str_item_name = "PYROPLUME EGG";
					_stct_return_item._spr_item = spr_item_egg_pyroplume;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Pyroplume.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region SANGUINAUT
				case "EGG_SANGUINAUT":					
					_stct_return_item._str_item_name = "SANGUINAUT EGG";
					_stct_return_item._spr_item = spr_item_egg_sanginaut;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Sanguinaut.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			
				#region SLAGOLEM
				case "EGG_SLAGOLEM":					
					_stct_return_item._str_item_name = "SLAGOLEM EGG";
					_stct_return_item._spr_item = spr_item_egg_slagolem;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Slagolem.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region SOLEMOLD
				case "EGG_SOLEMOLD":					
					_stct_return_item._str_item_name = "SOLEMOLD EGG";
					_stct_return_item._spr_item = spr_item_egg_solemold;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Solemold.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region WRATHOOD
				case "EGG_WRATHOOD":					
					_stct_return_item._str_item_name = "WRATHOOD EGG";
					_stct_return_item._spr_item = spr_item_egg_wrathood;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Wrathood.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;		
				break;					
				#endregion
			
				#region WYRMELTA
				case "EGG_WYRMELTA":					
					_stct_return_item._str_item_name = "WYRMELTA EGG";
					_stct_return_item._spr_item = spr_item_egg_wyrmelta;
					_stct_return_item._str_item_type = "EGG";
					_stct_return_item._scr_item = undefined;
					_stct_return_item._str_item_desc = "An egg of the beast Wyrmelta.";
					_stct_return_item._flag_stackable = false;
					_stct_return_item._ct_item_amount = 1;
					_stct_return_item._ct_item_max_amount = 1;	
				break;					
				#endregion
			#endregion				
		#endregion
	}

	global.uid_next_item++;

	return _stct_return_item;
}