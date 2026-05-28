//
//
// SCRIPT: SCR_GET_BEAST_INFO | BASED ON THE PASSED BEAST NAME, RETRIEVE A DSMAP WITH BASE BEAST INFORMATION | RETURNS MAP OF BEAST
//
//
function scr_get_beast_info(_beast_name){
	
	//INIT RETURN DSMAP
	var _return_beast = ds_map_create();
	
	//
	// SWITCH BASED ON BEAST NAME
	//
	switch (_beast_name){
	
		#region CERULEAN

		#endregion

		#region VERMILION

		#endregion

		#region VIRIDIAN
			#region ARBRAWN
			case "ARBRAWN":
				//INIT VARIABLESs
				ds_map_add(_return_beast,"beast_sprite",spr_beast_viridian_arbrawn);//SPRITE
				ds_map_add(_return_beast,"beast_name","ARBRAWN"); //NAME
				
				ds_map_add(_return_beast,"beast_hp_stat",140); //HP STAT
				ds_map_add(_return_beast,"beast_con_stat",70); //CON STAT
				ds_map_add(_return_beast,"beast_ppow_stat",80); //PPOW STAT
				ds_map_add(_return_beast,"beast_mpow_stat",30); //MPOW STAT 
				ds_map_add(_return_beast,"beast_pdef_stat",100); //PDEF STAT
				ds_map_add(_return_beast,"beast_mdef_stat",40); //MDEF STAT
				
				ds_map_add(_return_beast,"beast_crit_stat",0); //CRIT STAT
				ds_map_add(_return_beast,"beast_dod_stat",10); //DOD STAT
				ds_map_add(_return_beast,"beast_min_stat",1); //MINIONS STAT
				
				ds_map_add(_return_beast,"beast_colors",["VIRIDIAN",undefined]); //COLOR(S)
				ds_map_add(_return_beast,"beast_color_type",["WILD","NATURAL","BOTANICAL"]); //COLOR TYPES
				
				ds_map_add(_return_beast,"beast_archetype","MARTIAL"); //ARCHETYPE
				ds_map_add(_return_beast,"beast_class","ADVENTURER");//CLASS
				
				ds_map_add(_return_beast,"beast_talent_trees",["JUGGERNAUT","WARDEN"]); //TALENT TREES
				
				ds_map_add(_return_beast,"beast_ability",["ANCHORED","FLANKER","INTIMIDATION"]); //ABILITIES LIST
				
				ds_map_add(_return_beast,"beast_breed",undefined);//BREED	
				
				ds_map_add(_return_beast,"beast_prestige_stat",undefined);//PRESTIGE	
				
				ds_map_add(_return_beast,"beast_level",1); //LEVEL	
				
				ds_map_add(_return_beast,"beast_feed_list",["EMPTY"]); //FEEDING
				
				ds_map_add(_return_beast,"beast_held_item","EMPTY"); //HELD ITEM
				
				ds_map_add(_return_beast,"beast_markings",undefined); //MARKINGS
				
				ds_map_add(_return_beast,"beast_scars",undefined); //SCARS
				

				//ACTUAL UNIT VALUES
				ds_map_add(_return_beast,"beast_hp_cur",5); //CUR HP VALUE
				ds_map_add(_return_beast,"beast_hp_max",5); //MAX HP VALUE
				ds_map_add(_return_beast,"beast_exp",0); //EXP VALUE	
				
				//DESCRIPTON
				ds_map_add(_return_beast,"beast_lore","Arbrawn are towering simian beasts woven from corded bark, thick vines, and dense living musclewood. Their fists strike with the force of falling trunks, yet they are known less for fury than resilience. Found deep within overgrown jungles and forgotten ruins, Arbrawn are natural trailblazers that clear paths through impossible wilderness. Adventuring bands prize them for their resourcefulness; they can fashion shelter, gather medicinal herbs, and defend allies with equal ease. When threatened, Arbrawn hardens its outer bark into a living bulwark before retaliating with crushing vine-laced blows."); //LORE DESC
				ds_map_add(_return_beast,"beast_role","FL, MF | Durable bruiser that soaks physical punishment while delivering reliable frontline physical pressure."); //INTENDED POSITION AND ROLE DESC
			break;
			#endregion
			
			#region ARGENTBUD
			case "ARGENTBUD":
				//INIT VARIABLESs
				ds_map_add(_return_beast,"beast_sprite",spr_beast_viridian_argentbud);//SPRITE
				ds_map_add(_return_beast,"beast_name","ARGENTBUD"); //NAME
				
				ds_map_add(_return_beast,"beast_hp_stat",40); //HP STAT
				ds_map_add(_return_beast,"beast_con_stat",60); //CON STAT
				ds_map_add(_return_beast,"beast_ppow_stat",80); //PPOW STAT
				ds_map_add(_return_beast,"beast_mpow_stat",80); //MPOW STAT 
				ds_map_add(_return_beast,"beast_pdef_stat",30); //PDEF STAT
				ds_map_add(_return_beast,"beast_mdef_stat",30); //MDEF STAT
				
				ds_map_add(_return_beast,"beast_crit_stat",0); //CRIT STAT
				ds_map_add(_return_beast,"beast_dod_stat",0); //DOD STAT
				ds_map_add(_return_beast,"beast_min_stat",4); //MINIONS STAT
				
				ds_map_add(_return_beast,"beast_colors",["VIRIDIAN",undefined]); //COLOR(S)
				ds_map_add(_return_beast,"beast_color_type",["WILD","NATURAL","BOTANICAL"]); //COLOR TYPES
				
				ds_map_add(_return_beast,"beast_archetype","TECHNICAL"); //ARCHETYPE
				ds_map_add(_return_beast,"beast_class","MERCHANT");//CLASS
				
				ds_map_add(_return_beast,"beast_talent_trees",["SHARPSHOOTER","BEASTMASTERY"]); //TALENT TREES
				
				ds_map_add(_return_beast,"beast_ability",["OBLIVIOUS","LAST GIFT","EASY PREY"]); //ABILITIES LIST
				
				ds_map_add(_return_beast,"beast_breed",undefined);//BREED	
				
				ds_map_add(_return_beast,"beast_prestige_stat",undefined);//PRESTIGE	
				
				ds_map_add(_return_beast,"beast_level",1); //LEVEL	
				
				ds_map_add(_return_beast,"beast_feed_list",["EMPTY"]); //FEEDING
				
				ds_map_add(_return_beast,"beast_held_item","EMPTY"); //HELD ITEM
				
				ds_map_add(_return_beast,"beast_markings",undefined); //MARKINGS
				
				ds_map_add(_return_beast,"beast_scars",undefined); //SCARS
				

				//ACTUAL UNIT VALUES
				ds_map_add(_return_beast,"beast_hp_cur",5); //CUR HP VALUE
				ds_map_add(_return_beast,"beast_hp_max",5); //MAX HP VALUE
				ds_map_add(_return_beast,"beast_exp",0); //EXP VALUE	
				
				//DESCRIPTON
				ds_map_add(_return_beast,"beast_lore","Argentbud resembles a silver-veined flowering stalk rooted atop nimble tendrils. Though delicate in appearance, it possesses a shrewd intelligence and uncanny instinct for valuable resources. These creatures thrive in secluded glades rich with minerals, where their roots draw trace metals from the soil to form their gleaming petals. Argentbuds are often encountered near treasure caches or hidden groves laden with rare herbs. Their presence is said to attract fortune, and many caravans seek them as companions. In battle, they scatter glittering spores that distract foes while quietly enriching their allies’ stores."); //LORE DESC
				ds_map_add(_return_beast,"beast_role","C | Fragile support economy unit focused on minion swarms, utility scaling, and resource generation over direct combat."); //INTENDED POSITION AND ROLE DESC
			break;
			#endregion
			
			#region BEAVINE
			case "BEAVINE":
				//INIT VARIABLESs
				ds_map_add(_return_beast,"beast_sprite",spr_beast_viridian_beavine);//SPRITE
				ds_map_add(_return_beast,"beast_name","BEAVINE"); //NAME
				
				ds_map_add(_return_beast,"beast_hp_stat",40); //HP STAT
				ds_map_add(_return_beast,"beast_con_stat",40); //CON STAT
				ds_map_add(_return_beast,"beast_ppow_stat",80); //PPOW STAT
				ds_map_add(_return_beast,"beast_mpow_stat",80); //MPOW STAT 
				ds_map_add(_return_beast,"beast_pdef_stat",30); //PDEF STAT
				ds_map_add(_return_beast,"beast_mdef_stat",30); //MDEF STAT
				
				ds_map_add(_return_beast,"beast_crit_stat",5); //CRIT STAT
				ds_map_add(_return_beast,"beast_dod_stat",5); //DOD STAT
				ds_map_add(_return_beast,"beast_min_stat",5); //MINIONS STAT
				
				ds_map_add(_return_beast,"beast_colors",["VIRIDIAN",undefined]); //COLOR(S)
				ds_map_add(_return_beast,"beast_color_type",["WILD","NATURAL","BOTANICAL"]); //COLOR TYPES
				
				ds_map_add(_return_beast,"beast_archetype","MARTIAL"); //ARCHETYPE
				ds_map_add(_return_beast,"beast_class","ADVENTURER");//CLASS
				
				ds_map_add(_return_beast,"beast_talent_trees",["BREAKER","CONTROLLER"]); //TALENT TREES
				
				ds_map_add(_return_beast,"beast_ability",["DISRUPTIVE","DEATH CRY","RECYCLING"]); //ABILITIES LIST
				
				ds_map_add(_return_beast,"beast_breed",undefined);//BREED	
				
				ds_map_add(_return_beast,"beast_prestige_stat",undefined);//PRESTIGE	
				
				ds_map_add(_return_beast,"beast_level",1); //LEVEL	
				
				ds_map_add(_return_beast,"beast_feed_list",["EMPTY"]); //FEEDING
				
				ds_map_add(_return_beast,"beast_held_item","EMPTY"); //HELD ITEM
				
				ds_map_add(_return_beast,"beast_markings",undefined); //MARKINGS
				
				ds_map_add(_return_beast,"beast_scars",undefined); //SCARS
				

				//ACTUAL UNIT VALUES
				ds_map_add(_return_beast,"beast_hp_cur",5); //CUR HP VALUE
				ds_map_add(_return_beast,"beast_hp_max",5); //MAX HP VALUE
				ds_map_add(_return_beast,"beast_exp",0); //EXP VALUE	
				
				//DESCRIPTON
				ds_map_add(_return_beast,"beast_lore","Beavines are broad-tailed woodland builders with mossy fur and branchlike incisors capable of shaping living timber. Tireless and inventive, they construct shelters, bridges, and defenses from surrounding flora in mere moments. They inhabit riverbanks thick with old growth, where their lodges become bustling hubs of natural activity. Adventurers value Beavines for their practical ingenuity and knack for uncovering hidden paths or buried supplies. In combat, they rapidly erect thorned barricades or lash foes with vine-wrapped tails, always adapting the terrain to their advantage."); //LORE DESC
				ds_map_add(_return_beast,"beast_role","BL | Backline utility hybrid with strong scaling summons and balanced physical/magical support output."); //INTENDED POSITION AND ROLE DESC
			break;
			#endregion
			
			#region BRYOBITE
			
			#endregion
			
			#region CHITROOPER
			
			#endregion
			
			#region CRUSABER
			
			#endregion
			
			#region DRYADAE
			
			#endregion
			
			#region FIGHTREE
			
			#endregion
			
			#region FLITSAGE
			case "FLITSAGE":
				//INIT VARIABLESs
				ds_map_add(_return_beast,"beast_sprite",spr_beast_viridian_flitsage);//SPRITE
				ds_map_add(_return_beast,"beast_name","FLITSAGE"); //NAME
				
				ds_map_add(_return_beast,"beast_hp_stat",10); //HP STAT
				ds_map_add(_return_beast,"beast_con_stat",20); //CON STAT
				ds_map_add(_return_beast,"beast_ppow_stat",40); //PPOW STAT
				ds_map_add(_return_beast,"beast_mpow_stat",180); //MPOW STAT 
				ds_map_add(_return_beast,"beast_pdef_stat",50); //PDEF STAT
				ds_map_add(_return_beast,"beast_mdef_stat",50); //MDEF STAT
				
				ds_map_add(_return_beast,"beast_crit_stat",0); //CRIT STAT
				ds_map_add(_return_beast,"beast_dod_stat",5); //DOD STAT
				ds_map_add(_return_beast,"beast_min_stat",2); //MINIONS STAT
				
				ds_map_add(_return_beast,"beast_colors",["VIRIDIAN",undefined]); //COLOR(S)
				ds_map_add(_return_beast,"beast_color_type",["WILD","NATURAL","BOTANICAL"]); //COLOR TYPES
				
				ds_map_add(_return_beast,"beast_archetype","MAGICAL"); //ARCHETYPE
				ds_map_add(_return_beast,"beast_class","MAGE");//CLASS
				
				ds_map_add(_return_beast,"beast_talent_trees",["BATTLEMAGE","ECHO"]); //TALENT TREES
				
				ds_map_add(_return_beast,"beast_ability",["NIMBLE","ELEMENTAL WARD: VIRIDIAN","ECHOING MIND"]); //ABILITIES LIST
				
				ds_map_add(_return_beast,"beast_breed",undefined);//BREED	
				
				ds_map_add(_return_beast,"beast_prestige_stat",undefined);//PRESTIGE	
				
				ds_map_add(_return_beast,"beast_level",1); //LEVEL	
				
				ds_map_add(_return_beast,"beast_feed_list",["EMPTY"]); //FEEDING
				
				ds_map_add(_return_beast,"beast_held_item","EMPTY"); //HELD ITEM
				
				ds_map_add(_return_beast,"beast_markings",undefined); //MARKINGS
				
				ds_map_add(_return_beast,"beast_scars",undefined); //SCARS
				

				//ACTUAL UNIT VALUES
				ds_map_add(_return_beast,"beast_hp_cur",5); //CUR HP VALUE
				ds_map_add(_return_beast,"beast_hp_max",5); //MAX HP VALUE
				ds_map_add(_return_beast,"beast_exp",0); //EXP VALUE	
				
				//DESCRIPTON
				ds_map_add(_return_beast,"beast_lore","Flitsage is a tiny hummingbird beast wreathed in petals and glimmering pollen dust. Though physically fragile, it channels potent viridian magic through rapid wingbeats that hum with arcane resonance. Found among flowering canopies and hidden nectar springs, Flitsages are keepers of natural ley currents. They dart between allies and enemies alike, weaving bursts of healing light or precise magical strikes. Their spells often chain unpredictably through nearby targets, as if carried on the same invisible currents that guide their flight."); //LORE DESC
				ds_map_add(_return_beast,"beast_role","MB | Glass cannon spellcaster specializing in explosive magical burst from protected midback positioning."); //INTENDED POSITION AND ROLE DESC
			break;	
			#endregion
			
			#region FURN
			case "FURN":
				//INIT VARIABLESs
				ds_map_add(_return_beast,"beast_sprite",spr_beast_viridian_furn);//SPRITE
				ds_map_add(_return_beast,"beast_name","FURN"); //NAME
				
				ds_map_add(_return_beast,"beast_hp_stat",70); //HP STAT
				ds_map_add(_return_beast,"beast_con_stat",40); //CON STAT
				ds_map_add(_return_beast,"beast_ppow_stat",140); //PPOW STAT
				ds_map_add(_return_beast,"beast_mpow_stat",60); //MPOW STAT 
				ds_map_add(_return_beast,"beast_pdef_stat",40); //PDEF STAT
				ds_map_add(_return_beast,"beast_mdef_stat",40); //MDEF STAT
				
				ds_map_add(_return_beast,"beast_crit_stat",5); //CRIT STAT
				ds_map_add(_return_beast,"beast_dod_stat",10); //DOD STAT
				ds_map_add(_return_beast,"beast_min_stat",2); //MINIONS STAT
				
				ds_map_add(_return_beast,"beast_colors",["VIRIDIAN",undefined]); //COLOR(S)
				ds_map_add(_return_beast,"beast_color_type",["WILD","NATURAL","BOTANICAL"]); //COLOR TYPES
				
				ds_map_add(_return_beast,"beast_archetype","TECHNICAL"); //ARCHETYPE
				ds_map_add(_return_beast,"beast_class","HUNTER");//CLASS
				
				ds_map_add(_return_beast,"beast_talent_trees",["SABOTEUR","WARDEN"]); //TALENT TREES
				
				ds_map_add(_return_beast,"beast_ability",["PACK TACTICS","FEROCITY","INFECTIOUS STRIKES"]); //ABILITIES LIST
				
				ds_map_add(_return_beast,"beast_breed",undefined);//BREED	
				
				ds_map_add(_return_beast,"beast_prestige_stat",undefined);//PRESTIGE	
				
				ds_map_add(_return_beast,"beast_level",1); //LEVEL	
				
				ds_map_add(_return_beast,"beast_feed_list",["EMPTY"]); //FEEDING
				
				ds_map_add(_return_beast,"beast_held_item","EMPTY"); //HELD ITEM
				
				ds_map_add(_return_beast,"beast_markings",undefined); //MARKINGS
				
				ds_map_add(_return_beast,"beast_scars",undefined); //SCARS
				

				//ACTUAL UNIT VALUES
				ds_map_add(_return_beast,"beast_hp_cur",5); //CUR HP VALUE
				ds_map_add(_return_beast,"beast_hp_max",5); //MAX HP VALUE
				ds_map_add(_return_beast,"beast_exp",0); //EXP VALUE	
				
				//DESCRIPTON
				ds_map_add(_return_beast,"beast_lore","Furn is a lean wolf beast with moss-dark fur and glowing green eyes that pierce even the thickest forest mist. Silent and relentless, it stalks prey across impossible distances without tiring. Furn hunts not through brute force but through precision, marking targets with subtle venomous scratches that worsen over time. Packs are rare, as most Furn roam alone through ancient woods. Hunters bond with them for their unmatched tracking instincts and ruthless efficiency in isolating and dismantling dangerous foes."); //LORE DESC
				ds_map_add(_return_beast,"beast_role","MB | Agile physical assassin that hunts marked targets with crit pressure and evasive repositioning."); //INTENDED POSITION AND ROLE DESC
			break;	
			#endregion			
		#endregion

	}
	
	//RETURN SELECTED BEAST
	return _return_beast;
}