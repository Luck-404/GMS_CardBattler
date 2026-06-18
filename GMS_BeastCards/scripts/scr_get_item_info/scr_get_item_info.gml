//
//
// SCRIPT: SCR_GET_ITEM_INFO | GET THE INFO OF AN INPUT ITEM | RETURNS NEW DSMAP OF A ITEM
//
//

function scr_get_item_info(_item_name){
	// NAME				- string
	// SPRITE			- sprite index
	// TYPE				- QUEST, CONSUMABLE, PRISM, HELD, EGG
	// SCRIPT			- script index
	// DESC				- string
	// STACKABLE		- TRUE OR FALSE
	// AMOUNT			- COUNT IN STACK
	// MAX AMOUNT		- MAX AMOUNT IN STACK	
	
	//INIT NEW CARD MAP
	var _return_item = ds_map_create();
	
	//POPULATE WITH INFO GIVEN ITS NAME
	switch(_item_name){
		#region QUEST
		case "QUEST_IMPORTANT_NOTEBOOK":
			ds_map_add(_return_item,"item_name","IMPORTANT NOTEBOOK"); //NAME
			ds_map_add(_return_item,"item_sprite",spr_item_quest_important_notebook); //SPRITE					
			ds_map_add(_return_item,"item_type","QUEST"); //TYPE
			ds_map_add(_return_item,"item_script",undefined); //SCRIPT
			ds_map_add(_return_item,"item_desc","An important notebook used for completing a quest."); //DESC
			ds_map_add(_return_item,"item_stackable",false); //STACKABLE
			ds_map_add(_return_item,"item_amount",1); //AMOUNT
			ds_map_add(_return_item,"item_max_amount",1); //MAX AMOUNT				
		break;
		#endregion
		
		#region CONSUMABLE
		case "CONSUMABLE_HEALING_SALVE":
			ds_map_add(_return_item,"item_name","HEALING SALVE"); //NAME
			ds_map_add(_return_item,"item_sprite",spr_item_consumable_healing_salve); //SPRITE					
			ds_map_add(_return_item,"item_type","CONSUMABLE"); //TYPE
			ds_map_add(_return_item,"item_script",undefined); //SCRIPT
			ds_map_add(_return_item,"item_desc","A healing balm that can be used to heal beasts."); //DESC
			ds_map_add(_return_item,"item_stackable",true); //STACKABLE
			ds_map_add(_return_item,"item_amount",1); //AMOUNT
			ds_map_add(_return_item,"item_max_amount",10); //MAX AMOUNT			
		break;
		#endregion
		
		#region PRISM
		case "PRISM_BASIC_PRISM":
			ds_map_add(_return_item,"item_name","BASIC PRISM"); //NAME
			ds_map_add(_return_item,"item_sprite",spr_item_prism_basic); //SPRITE					
			ds_map_add(_return_item,"item_type","PRISM"); //TYPE
			ds_map_add(_return_item,"item_script",undefined); //SCRIPT
			ds_map_add(_return_item,"item_desc","Used to capture beasts."); //DESC
			ds_map_add(_return_item,"item_stackable",true); //STACKABLE
			ds_map_add(_return_item,"item_amount",1); //AMOUNT
			ds_map_add(_return_item,"item_max_amount",10); //MAX AMOUNT				
		break;
		#endregion
		
		#region HELD
		case "HELD_POWERFUL_STONE":
			ds_map_add(_return_item,"item_name","POWERFUL STONE"); //NAME
			ds_map_add(_return_item,"item_sprite",spr_item_held_powerful_stone); //SPRITE					
			ds_map_add(_return_item,"item_type","HELD"); //TYPE
			ds_map_add(_return_item,"item_script",undefined); //SCRIPT
			ds_map_add(_return_item,"item_desc","Can be given to a beast to increase their power"); //DESC
			ds_map_add(_return_item,"item_stackable",false); //STACKABLE
			ds_map_add(_return_item,"item_amount",1); //AMOUNT
			ds_map_add(_return_item,"item_max_amount",1); //MAX AMOUNT					
		break;
		#endregion
		
		#region EGG
		case "EGG_ARBRAWN":
			ds_map_add(_return_item,"item_name","ARBRAWN EGG"); //NAME
			ds_map_add(_return_item,"item_sprite",spr_item_egg_arbrawn); //SPRITE					
			ds_map_add(_return_item,"item_type","EGG"); //TYPE
			ds_map_add(_return_item,"item_script",undefined); //SCRIPT
			ds_map_add(_return_item,"item_desc","An egg of the beast arbrawn."); //DESC
			ds_map_add(_return_item,"item_stackable",false); //STACKABLE
			ds_map_add(_return_item,"item_amount",1); //AMOUNT
			ds_map_add(_return_item,"item_max_amount",1); //MAX AMOUNT					
		break;
		#endregion
		
		default:
			ds_map_add(_return_item,"item_name","DEFAULT"); //NAME
			ds_map_add(_return_item,"item_sprite",spr_item_egg_arbrawn); //SPRITE					
			ds_map_add(_return_item,"item_type",undefined); //TYPE
			ds_map_add(_return_item,"item_script",undefined); //SCRIPT
			ds_map_add(_return_item,"item_desc","DEFAULT"); //DESC
			ds_map_add(_return_item,"item_stackable",false); //STACKABLE
			ds_map_add(_return_item,"item_amount",1); //AMOUNT
			ds_map_add(_return_item,"item_max_amount",1); //MAX AMOUNT		
		break;
		
	}
	
	//ADD UID
	ds_map_add(_return_item,"item_uid",global.item_uid);
	global.item_uid++;
	
	//RETURN NEW CARD MAP
	return _return_item;
}