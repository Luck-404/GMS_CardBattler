//===============================================================================//
//
// SCRIPT: SCR_GET_BEAST_INFO
// FUNCTION: Returns base beast information from an input beast ID.
//           Stores base beast data as a struct instead of a ds_map.
//           Used by random, specific, and custom beast initialization.
//
//===============================================================================//

function scr_get_beast_info(_str_beast_name){

	var _stct_return_beast = undefined;

	switch (_str_beast_name){

		#region CERULEAN

		#endregion

		#region VERMILION

		#endregion

		#region VIRIDIAN
			#region ARBRAWN
			case "ARBRAWN":
				_stct_return_beast = {
					beast_sprite : spr_beast_viridian_arbrawn,
					beast_name : "ARBRAWN",

					beast_hp_stat : 140,
					beast_con_stat : 70,
					beast_ppow_stat : 80,
					beast_mpow_stat : 30,
					beast_pdef_stat : 100,
					beast_mdef_stat : 40,

					beast_crit_stat : 0,
					beast_dod_stat : 10,
					beast_min_stat : 1,

					beast_colors : ["VIRIDIAN",undefined],
					beast_color_type : ["WILD","NATURAL","BOTANICAL"],

					beast_archetype : "MARTIAL",
					beast_class : "ADVENTURER",

					beast_talent_trees : ["JUGGERNAUT","WARDEN"],
					beast_ability : ["ANCHORED","FLANKER","INTIMIDATION"],

					beast_breed : undefined,
					beast_prestige_stat : undefined,
					beast_level : 1,

					beast_feed_list : ["EMPTY"],
					beast_held_item : "EMPTY",

					beast_markings : undefined,
					beast_scars : undefined,

					beast_hp_cur : 5,
					beast_hp_max : 5,
					beast_exp : 0,

					beast_lore : "Arbrawn are towering simian beasts woven from corded bark, thick vines, and dense living musclewood. Their fists strike with the force of falling trunks, yet they are known less for fury than resilience. Found deep within overgrown jungles and forgotten ruins, Arbrawn are natural trailblazers that clear paths through impossible wilderness. Adventuring bands prize them for their resourcefulness; they can fashion shelter, gather medicinal herbs, and defend allies with equal ease. When threatened, Arbrawn hardens its outer bark into a living bulwark before retaliating with crushing vine-laced blows.",
					beast_role : "FL, MF | Durable bruiser that soaks physical punishment while delivering reliable frontline physical pressure."
				};
			break;
			#endregion

			#region ARGENTBUD
			case "ARGENTBUD":
				_stct_return_beast = {
					beast_sprite : spr_beast_viridian_argentbud,
					beast_name : "ARGENTBUD",

					beast_hp_stat : 40,
					beast_con_stat : 60,
					beast_ppow_stat : 80,
					beast_mpow_stat : 80,
					beast_pdef_stat : 30,
					beast_mdef_stat : 30,

					beast_crit_stat : 0,
					beast_dod_stat : 0,
					beast_min_stat : 4,

					beast_colors : ["VIRIDIAN",undefined],
					beast_color_type : ["WILD","NATURAL","BOTANICAL"],

					beast_archetype : "TECHNICAL",
					beast_class : "MERCHANT",

					beast_talent_trees : ["SHARPSHOOTER","BEASTMASTERY"],
					beast_ability : ["OBLIVIOUS","LAST GIFT","EASY PREY"],

					beast_breed : undefined,
					beast_prestige_stat : undefined,
					beast_level : 1,

					beast_feed_list : ["EMPTY"],
					beast_held_item : "EMPTY",

					beast_markings : undefined,
					beast_scars : undefined,

					beast_hp_cur : 5,
					beast_hp_max : 5,
					beast_exp : 0,

					beast_lore : "Argentbud resembles a silver-veined flowering stalk rooted atop nimble tendrils. Though delicate in appearance, it possesses a shrewd intelligence and uncanny instinct for valuable resources. These creatures thrive in secluded glades rich with minerals, where their roots draw trace metals from the soil to form their gleaming petals. Argentbuds are often encountered near treasure caches or hidden groves laden with rare herbs. Their presence is said to attract fortune, and many caravans seek them as companions. In battle, they scatter glittering spores that distract foes while quietly enriching their allies’ stores.",
					beast_role : "C | Fragile support economy unit focused on minion swarms, utility scaling, and resource generation over direct combat."
				};
			break;
			#endregion

			#region BEAVINE
			case "BEAVINE":
				_stct_return_beast = {
					beast_sprite : spr_beast_viridian_beavine,
					beast_name : "BEAVINE",

					beast_hp_stat : 40,
					beast_con_stat : 40,
					beast_ppow_stat : 80,
					beast_mpow_stat : 80,
					beast_pdef_stat : 30,
					beast_mdef_stat : 30,

					beast_crit_stat : 5,
					beast_dod_stat : 5,
					beast_min_stat : 5,

					beast_colors : ["VIRIDIAN",undefined],
					beast_color_type : ["WILD","NATURAL","BOTANICAL"],

					beast_archetype : "MARTIAL",
					beast_class : "ADVENTURER",

					beast_talent_trees : ["BREAKER","CONTROLLER"],
					beast_ability : ["DISRUPTIVE","DEATH CRY","RECYCLING"],

					beast_breed : undefined,
					beast_prestige_stat : undefined,
					beast_level : 1,

					beast_feed_list : ["EMPTY"],
					beast_held_item : "EMPTY",

					beast_markings : undefined,
					beast_scars : undefined,

					beast_hp_cur : 5,
					beast_hp_max : 5,
					beast_exp : 0,

					beast_lore : "Beavines are broad-tailed woodland builders with mossy fur and branchlike incisors capable of shaping living timber. Tireless and inventive, they construct shelters, bridges, and defenses from surrounding flora in mere moments. They inhabit riverbanks thick with old growth, where their lodges become bustling hubs of natural activity. Adventurers value Beavines for their practical ingenuity and knack for uncovering hidden paths or buried supplies. In combat, they rapidly erect thorned barricades or lash foes with vine-wrapped tails, always adapting the terrain to their advantage.",
					beast_role : "BL | Backline utility hybrid with strong scaling summons and balanced physical/magical support output."
				};
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
				_stct_return_beast = {
					beast_sprite : spr_beast_viridian_flitsage,
					beast_name : "FLITSAGE",

					beast_hp_stat : 10,
					beast_con_stat : 20,
					beast_ppow_stat : 40,
					beast_mpow_stat : 180,
					beast_pdef_stat : 50,
					beast_mdef_stat : 50,

					beast_crit_stat : 0,
					beast_dod_stat : 5,
					beast_min_stat : 2,

					beast_colors : ["VIRIDIAN",undefined],
					beast_color_type : ["WILD","NATURAL","BOTANICAL"],

					beast_archetype : "MAGICAL",
					beast_class : "MAGE",

					beast_talent_trees : ["BATTLEMAGE","ECHO"],
					beast_ability : ["NIMBLE","ELEMENTAL WARD: VIRIDIAN","ECHOING MIND"],

					beast_breed : undefined,
					beast_prestige_stat : undefined,
					beast_level : 1,

					beast_feed_list : ["EMPTY"],
					beast_held_item : "EMPTY",

					beast_markings : undefined,
					beast_scars : undefined,

					beast_hp_cur : 5,
					beast_hp_max : 5,
					beast_exp : 0,

					beast_lore : "Flitsage is a tiny hummingbird beast wreathed in petals and glimmering pollen dust. Though physically fragile, it channels potent viridian magic through rapid wingbeats that hum with arcane resonance. Found among flowering canopies and hidden nectar springs, Flitsages are keepers of natural ley currents. They dart between allies and enemies alike, weaving bursts of healing light or precise magical strikes. Their spells often chain unpredictably through nearby targets, as if carried on the same invisible currents that guide their flight.",
					beast_role : "MB | Glass cannon spellcaster specializing in explosive magical burst from protected midback positioning."
				};
			break;
			#endregion

			#region FURN
			case "FURN":
				_stct_return_beast = {
					beast_sprite : spr_beast_viridian_furn,
					beast_name : "FURN",

					beast_hp_stat : 70,
					beast_con_stat : 40,
					beast_ppow_stat : 140,
					beast_mpow_stat : 60,
					beast_pdef_stat : 40,
					beast_mdef_stat : 40,

					beast_crit_stat : 5,
					beast_dod_stat : 10,
					beast_min_stat : 2,

					beast_colors : ["VIRIDIAN",undefined],
					beast_color_type : ["WILD","NATURAL","BOTANICAL"],

					beast_archetype : "TECHNICAL",
					beast_class : "HUNTER",

					beast_talent_trees : ["SABOTEUR","WARDEN"],
					beast_ability : ["PACK TACTICS","FEROCITY","INFECTIOUS STRIKES"],

					beast_breed : undefined,
					beast_prestige_stat : undefined,
					beast_level : 1,

					beast_feed_list : ["EMPTY"],
					beast_held_item : "EMPTY",

					beast_markings : undefined,
					beast_scars : undefined,

					beast_hp_cur : 5,
					beast_hp_max : 5,
					beast_exp : 0,

					beast_lore : "Furn is a lean wolf beast with moss-dark fur and glowing green eyes that pierce even the thickest forest mist. Silent and relentless, it stalks prey across impossible distances without tiring. Furn hunts not through brute force but through precision, marking targets with subtle venomous scratches that worsen over time. Packs are rare, as most Furn roam alone through ancient woods. Hunters bond with them for their unmatched tracking instincts and ruthless efficiency in isolating and dismantling dangerous foes.",
					beast_role : "MB | Agile physical assassin that hunts marked targets with crit pressure and evasive repositioning."
				};
			break;
			#endregion
		#endregion
	}

	return _stct_return_beast;
}