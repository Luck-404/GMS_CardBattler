//===============================================================================//
//
// SCRIPT: SCR_GET_BEAST_INFO
// FUNCTION: Returns base beast information from an input beast ID.
//           Stores base beast data as a struct instead of a ds_map.
//           Initializes color subtype and ability candidates as arrays.
//
//===============================================================================//

function scr_get_beast_info(_str_beast_name){

	var _stct_return_beast = undefined;

	switch (_str_beast_name){

		#region CERULEAN
			#region AMMOMARSH
			case "AMMOMARSH":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_ammomarsh,
					_snd_beast_cry : snd_beast_cerulean_ammomarsh_cry,
					_snd_beast_death : snd_beast_cerulean_ammomarsh_death,
					_str_beast_name : "AMMOMARSH",

					_val_beast_hp_stat : 96,
					_val_beast_con_stat : 58,
					_val_beast_ppow_stat : 28,
					_val_beast_mpow_stat : 126,
					_val_beast_pdef_stat : 230,
					_val_beast_mdef_stat : 74,

					_val_beast_crit_stat : 5,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 4,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "PRIEST",

					_arr_beast_talent_trees : ["INVOKER","WARDEN"],
					_str_beast_ability : ["OBLIVIOUS","BLOODLUST","WEATHER CLEANSE"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Ammomarsh are ammonite beasts with heavy spiral shells, slick marsh flesh, and ancient eyes set beneath ridges of blue stone. They live in cold wetlands and flooded ruins where old seabeds have risen back into the world. Their shells carry layers of mineral memory, each ring recording pressure, tide, and age. Though slow, Ammomarsh are difficult to break, advancing like a moving fortress while channeling restorative Cerulean magic through the water trapped inside their shells.",
					_str_beast_role : "C | Center fortress priest that combines heavy physical defense, healing magic, and steady control."
				};
			break;
			#endregion

			#region BLIZZDRIFT
			case "BLIZZDRIFT":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_blizzdrift,
					_snd_beast_cry : snd_beast_cerulean_blizzdrift_cry,
					_snd_beast_death : snd_beast_cerulean_blizzdrift_death,
					_str_beast_name : "BLIZZDRIFT",

					_val_beast_hp_stat : 68,
					_val_beast_con_stat : 52,
					_val_beast_ppow_stat : 18,
					_val_beast_mpow_stat : 210,
					_val_beast_pdef_stat : 44,
					_val_beast_mdef_stat : 168,

					_val_beast_crit_stat : 4,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 9,
					_val_beast_min_stat : 3,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "MAGE",

					_arr_beast_talent_trees : ["HEXWEAVER","AFFLICTOR"],
					_str_beast_ability : ["FINAL STRIKE","MANAFLOW","ECHOING MIND"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Blizzdrift are jellyfish beasts made from translucent bells, trailing frost-veins, and drifting curtains of cold light. They float through icy waters and snow-choked air with equal ease, pulsing quietly as if moved by invisible tides. Their bodies gather rime from the atmosphere, turning moisture into frost that burns exposed flesh. Sailors fear Blizzdrift swarms because they appear without warning in fogbanks, surrounding ships like silent lanterns before the temperature drops and ropes freeze solid.",
					_str_beast_role : "BL | Backline frost artillery mage that applies magical pressure, echo effects, and cold attrition."
				};
			break;
			#endregion

			#region CAUDAQUA
			case "CAUDAQUA":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_caudaqua,
					_snd_beast_cry : snd_beast_cerulean_caudaqua_cry,
					_snd_beast_death : snd_beast_cerulean_caudaqua_death,
					_str_beast_name : "CAUDAQUA",

					_val_beast_hp_stat : 102,
					_val_beast_con_stat : 44,
					_val_beast_ppow_stat : 42,
					_val_beast_mpow_stat : 154,
					_val_beast_pdef_stat : 56,
					_val_beast_mdef_stat : 52,

					_val_beast_crit_stat : 7,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 18,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "HUNTER",

					_arr_beast_talent_trees : ["SHARPSHOOTER","BEASTMASTERY"],
					_str_beast_ability : ["BREAKER","INFECTIOUS STRIKES","SECOND WIND"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Caudaqua are salamander beasts with wet blue skin, finned tails, and bright markings that shimmer like reflected water. They live along riverbanks, glacier melt streams, and flooded caves where stone remains slick year-round. Their bodies regenerate quickly in clean water, but their speed is their real defense, letting them dart between rocks before striking from unexpected angles. Many fishermen consider Caudaqua a sign of healthy waters, though trying to catch one often ends in frostbitten hands and shredded nets.",
					_str_beast_role : "MB | Agile midback hunter that blends dodge, infection pressure, and magical water strikes."
				};
			break;
			#endregion

			#region CEPHARIME
			case "CEPHARIME":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_cepharime,
					_snd_beast_cry : snd_beast_cerulean_cepharime_cry,
					_snd_beast_death : snd_beast_cerulean_cepharime_death,
					_str_beast_name : "CEPHARIME",

					_val_beast_hp_stat : 104,
					_val_beast_con_stat : 62,
					_val_beast_ppow_stat : 24,
					_val_beast_mpow_stat : 124,
					_val_beast_pdef_stat : 118,
					_val_beast_mdef_stat : 122,

					_val_beast_crit_stat : 2,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 12,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "ADVENTURER",

					_arr_beast_talent_trees : ["BERSERKER","BEASTMASTERY"],
					_str_beast_ability : ["RHYTHMIC STRIKES","INSPIRING PRESENCE","ECHOING MIND"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Cepharime are octopus beasts with pale sapphire flesh, clever eyes, and arms lined with glowing suction marks. They dwell in tide caves and abyssal ruins, manipulating shells, tools, and currents with unnerving intelligence. A Cepharime can solve locks, rearrange terrain, or mislead enemies by clouding water with illusion-like ink. They are prized by tactical crews because they understand battle as a puzzle, wrapping opponents in choices until every movement benefits the Cepharime’s plan.",
					_str_beast_role : "C | Center tactical hybrid that manipulates rhythm, positioning, and flexible magical pressure."
				};
			break;
			#endregion

			#region CHELONSEA
			case "CHELONSEA":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_chelonsea,
					_snd_beast_cry : snd_beast_cerulean_chelonsea_cry,
					_snd_beast_death : snd_beast_cerulean_chelonsea_death,
					_str_beast_name : "CHELONSEA",

					_val_beast_hp_stat : 212,
					_val_beast_con_stat : 92,
					_val_beast_ppow_stat : 116,
					_val_beast_mpow_stat : 28,
					_val_beast_pdef_stat : 188,
					_val_beast_mdef_stat : 36,

					_val_beast_crit_stat : 0,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 0,
					_val_beast_min_stat : 5,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "ENGINEER",

					_arr_beast_talent_trees : ["TACTICIAN","ARCANIST"],
					_str_beast_ability : ["PATIENT","FLANKER","BEASTLINK"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Chelonsea are turtle beasts with fortress shells, coral growths, and broad limbs adapted for both surf and stone. They inhabit reef walls, storm beaches, and old harbor defenses where waves constantly test the land. Their shells are living bastions, often hosting small fish, barnacles, and defensive growths that benefit from their protection. In battle, Chelonsea advance slowly but decisively, turning the space around them into a protected siege line that allies can operate behind.",
					_str_beast_role : "MB | Midback siege engineer that provides bulk, minion capacity, flanking value, and defensive setup."
				};
			break;
			#endregion

			#region CORALLIARC
			case "CORALLIARC":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_coralliarc,
					_snd_beast_cry : snd_beast_cerulean_coralliarc_cry,
					_snd_beast_death : snd_beast_cerulean_coralliarc_death,
					_str_beast_name : "CORALLIARC",

					_val_beast_hp_stat : 74,
					_val_beast_con_stat : 38,
					_val_beast_ppow_stat : 16,
					_val_beast_mpow_stat : 184,
					_val_beast_pdef_stat : 48,
					_val_beast_mdef_stat : 176,

					_val_beast_crit_stat : 1,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 2,
					_val_beast_min_stat : 4,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "ENGINEER",

					_arr_beast_talent_trees : ["SABOTEUR","ECHO"],
					_str_beast_ability : ["CULL POWER","SAPPHIRE SCALE","RECYCLING"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Coralliarc are coral beasts shaped like living reef towers, with branching limbs, mineral hearts, and polyps that glow in blue light. They grow in warm shallows and drowned cities where broken stone provides a skeleton for new reef life. Though rooted in appearance, they can crawl with unsettling slowness, placing defensive structures and magical growths wherever water can reach. Divers avoid damaging Coralliarc colonies, because a wounded reef remembers the attacker and may answer with piercing sapphire magic.",
					_str_beast_role : "C | Center turret engineer that builds magical pressure through summons, recycling, and defensive scaling."
				};
			break;
			#endregion

			#region FROSTUSK
			case "FROSTUSK":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_frostusk,
					_snd_beast_cry : snd_beast_cerulean_frostusk_cry,
					_snd_beast_death : snd_beast_cerulean_frostusk_death,
					_str_beast_name : "FROSTUSK",

					_val_beast_hp_stat : 156,
					_val_beast_con_stat : 88,
					_val_beast_ppow_stat : 138,
					_val_beast_mpow_stat : 34,
					_val_beast_pdef_stat : 126,
					_val_beast_mdef_stat : 122,

					_val_beast_crit_stat : 5,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 5,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "PRIEST",

					_arr_beast_talent_trees : ["HEXWEAVER","AFFLICTOR"],
					_str_beast_ability : ["ANCHORED","EMPOWER","PURIFIER"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Frostusk are yeti beasts with thick fur, tusked jaws, and ice crusting their shoulders like armor. They roam alpine coasts and frozen cliffs where sea wind meets permanent snow. Despite their brutal appearance, Frostusk often guard mountain passes and stranded travelers, judging whether a creature has the strength to continue or the humility to turn back. In combat, they mix priestly purification with raw physical violence, breaking enemies like ice under a heavy boot.",
					_str_beast_role : "BL | Backline battle priest that combines physical threat, purification, and frost-themed debuff pressure."
				};
			break;
			#endregion

			#region GALENATRIUM
			case "GALENATRIUM":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_galenatrium,
					_snd_beast_cry : snd_beast_cerulean_galenatrium_cry,
					_snd_beast_death : snd_beast_cerulean_galenatrium_death,
					_str_beast_name : "GALENATRIUM",

					_val_beast_hp_stat : 62,
					_val_beast_con_stat : 46,
					_val_beast_ppow_stat : 20,
					_val_beast_mpow_stat : 238,
					_val_beast_pdef_stat : 34,
					_val_beast_mdef_stat : 48,

					_val_beast_crit_stat : 12,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 10,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "MAGE",

					_arr_beast_talent_trees : ["BATTLEMAGE","ORACLE"],
					_str_beast_ability : ["OPPORTUNIST","MANAFLOW","WEATHERCALL: RAIN"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Galenatrium are shark beasts with sleek bodies, glassy eyes, and fins edged in dark Cerulean magic. They swim through deep trenches and flooded caverns where pressure alone can crush weaker creatures. Their hunting style is patient and mathematical, circling until panic, blood, or current reveals the perfect attack line. Some mages believe Galenatrium carry abyssal starlight in their bodies, explaining why their strikes feel less like bites and more like spells delivered at predator speed.",
					_str_beast_role : "MB | Midback arcane predator that uses magical burst, crit pressure, and rain synergy to finish targets."
				};
			break;
			#endregion

			#region GLACIMIGHT
			case "GLACIMIGHT":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_glacimight,
					_snd_beast_cry : snd_beast_cerulean_glacimight_cry,
					_snd_beast_death : snd_beast_cerulean_glacimight_death,
					_str_beast_name : "GLACIMIGHT",

					_val_beast_hp_stat : 118,
					_val_beast_con_stat : 152,
					_val_beast_ppow_stat : 46,
					_val_beast_mpow_stat : 172,
					_val_beast_pdef_stat : 86,
					_val_beast_mdef_stat : 182,

					_val_beast_crit_stat : 5,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 2,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "SAILOR",

					_arr_beast_talent_trees : ["BULWARK","CONTROLLER"],
					_str_beast_ability : ["UNBREAKABLE MIND","CHANNEL FROST","WEATHERCALL: SNOW"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Glacimight are frost elemental beasts built from layered ice, packed snow, and ancient blue magic under pressure. They appear where glaciers grind against stone or where blizzards persist long enough to develop a will. Their bodies crack and reform constantly, shedding shards that ring like glass when they strike the ground. Glacimight are not cruel, but they are vast and slow-minded, treating most living things as temporary heat sources moving across an endless frozen field.",
					_str_beast_role : "FL | Frontline frost titan that brings high magical defense, controller tools, and snow-based battlefield presence."
				};
			break;
			#endregion

			#region GULFLOW
			case "GULFLOW":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_gulflow,
					_snd_beast_cry : snd_beast_cerulean_gulflow_cry,
					_snd_beast_death : snd_beast_cerulean_gulflow_death,
					_str_beast_name : "GULFLOW",

					_val_beast_hp_stat : 88,
					_val_beast_con_stat : 106,
					_val_beast_ppow_stat : 34,
					_val_beast_mpow_stat : 122,
					_val_beast_pdef_stat : 164,
					_val_beast_mdef_stat : 58,

					_val_beast_crit_stat : 1,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 4,
					_val_beast_min_stat : 3,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "MERCHANT",

					_arr_beast_talent_trees : ["ALCHEMIST","SCHOLAR"],
					_str_beast_ability : ["ELEMENTAL WARD: CERULEAN","CHANNELER"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Gulflow are water elemental beasts shaped from rolling waves, foam crests, and suspended droplets of sapphire light. They form in river mouths, tide pools, and sacred springs where currents meet and refuse to settle. Gulflow rarely hold one shape for long, shifting from humanoid streams to surging masses of water depending on mood and threat. Communities near them often leave offerings at channels and wells, asking the flow to remain generous rather than sweep everything clean.",
					_str_beast_role : "C | Center tide support that stabilizes allies with Cerulean warding, channeling, and balanced utility."
				};
			break;
			#endregion

			#region ISTIRAIN
			case "ISTIRAIN":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_istirain,
					_snd_beast_cry : snd_beast_cerulean_istirain_cry,
					_snd_beast_death : snd_beast_cerulean_istirain_death,
					_str_beast_name : "ISTIRAIN",

					_val_beast_hp_stat : 84,
					_val_beast_con_stat : 54,
					_val_beast_ppow_stat : 228,
					_val_beast_mpow_stat : 12,
					_val_beast_pdef_stat : 94,
					_val_beast_mdef_stat : 42,

					_val_beast_crit_stat : 14,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 10,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "HUNTER",

					_arr_beast_talent_trees : ["ASSASSIN","ECHO"],
					_str_beast_ability : ["VIGILANT","RHYTHMIC STRIKES","WEATHERCALL: RAIN"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Istirain are fish beasts with blade-like fins, rain-slick scales, and bodies built for sudden acceleration. They swim in storm-fed rivers and open waters where rainfall blurs the surface into silver noise. When hunting, they launch from the water in quick arcs, striking before prey can distinguish fish from falling rain. Sailors track Istirain schools as omens of violent weather, because their feeding frenzies often begin just before the sky breaks open.",
					_str_beast_role : "MB | Midback glass assassin that uses high physical damage, crits, and rain synergy to pressure targets."
				};
			break;
			#endregion

			#region KELPLATANI
			case "KELPLATANI":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_kelplatani,
					_snd_beast_cry : snd_beast_cerulean_kelplatani_cry,
					_snd_beast_death : snd_beast_cerulean_kelplatani_death,
					_str_beast_name : "KELPLATANI",

					_val_beast_hp_stat : 182,
					_val_beast_con_stat : 170,
					_val_beast_ppow_stat : 76,
					_val_beast_mpow_stat : 78,
					_val_beast_pdef_stat : 62,
					_val_beast_mdef_stat : 66,

					_val_beast_crit_stat : 0,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 6,
					_val_beast_min_stat : 3,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "MERCHANT",

					_arr_beast_talent_trees : ["ASSASSIN","ORACLE"],
					_str_beast_ability : ["SECOND WIND","SPELLHIGH","DISRUPTIVE"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Kelplatani are dolphin beasts with kelp-fringed fins, bright eyes, and voices that carry through water like bells. They live in coastal pods, guiding lost swimmers, herding fish, and defending reef passages from predators. Their intelligence makes them natural traders among Cerulean beasts, exchanging safe routes, food sources, and warnings with coastal settlements. In battle, Kelplatani are social guardians, disrupting enemies with movement and sound while keeping allies coordinated in the shifting tide.",
					_str_beast_role : "C | Center merchant guardian that uses bulk, disruption, and spell support to protect team flow."
				};
			break;
			#endregion

			#region LONTRIVER
			case "LONTRIVER":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_lontriver,
					_snd_beast_cry : snd_beast_cerulean_lontriver_cry,
					_snd_beast_death : snd_beast_cerulean_lontriver_death,
					_str_beast_name : "LONTRIVER",

					_val_beast_hp_stat : 128,
					_val_beast_con_stat : 72,
					_val_beast_ppow_stat : 118,
					_val_beast_mpow_stat : 126,
					_val_beast_pdef_stat : 108,
					_val_beast_mdef_stat : 84,

					_val_beast_crit_stat : 10,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 6,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "MAGE",

					_arr_beast_talent_trees : ["BATTLEMAGE","ARCANIST"],
					_str_beast_ability : ["LEECHING FANGS","FURY","FOREWARN"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Lontriver are otter beasts with slick fur, bright claws, and playful movements hiding sharp predatory instincts. They inhabit fast rivers, icy streams, and lake edges where currents create constant tactical opportunities. Lontriver often appear harmless until they twist through the water, strike a weak point, and vanish behind stone or foam. Their magic is fluid and personal, blending fang, spell, and stolen momentum into a fighting style that feels improvised but rarely is.",
					_str_beast_role : "BL | Backline spellblade that mixes physical and magical pressure with leeching, fury, and foresight."
				};
			break;
			#endregion

			#region MARITIMICE
			case "MARITIMICE":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_maritimice,
					_snd_beast_cry : snd_beast_cerulean_maritimice_cry,
					_snd_beast_death : snd_beast_cerulean_maritimice_death,
					_str_beast_name : "MARITIMICE",

					_val_beast_hp_stat : 162,
					_val_beast_con_stat : 126,
					_val_beast_ppow_stat : 168,
					_val_beast_mpow_stat : 24,
					_val_beast_pdef_stat : 132,
					_val_beast_mdef_stat : 56,

					_val_beast_crit_stat : 2,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 2,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "ADVENTURER",

					_arr_beast_talent_trees : ["JUGGERNAUT","SCHOLAR"],
					_str_beast_ability : ["TENACIOUS","OVERWHELM","INTIMIDATION"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Maritimice are polar bear beasts with sea-ice fur, heavy paws, and breath that fogs even in mild air. They patrol frozen coasts where ice sheets fracture and seals gather near dark water. Though solitary, they are respected as guardians of harsh places, surviving where hunger, cold, and pressure remove anything weak. In combat, Maritimice advance directly, using intimidation and overwhelming strength to force enemies into bad trades they cannot endure.",
					_str_beast_role : "FL | Frontline polar vanguard that delivers heavy physical pressure with strong bulk and intimidation."
				};
			break;
			#endregion

			#region SALTWAGG
			case "SALTWAGG":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_saltwagg,
					_snd_beast_cry : snd_beast_cerulean_saltwagg_cry,
					_snd_beast_death : snd_beast_cerulean_saltwagg_death,
					_str_beast_name : "SALTWAGG",

					_val_beast_hp_stat : 148,
					_val_beast_con_stat : 104,
					_val_beast_ppow_stat : 172,
					_val_beast_mpow_stat : 16,
					_val_beast_pdef_stat : 108,
					_val_beast_mdef_stat : 48,

					_val_beast_crit_stat : 12,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 2,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "SAILOR",

					_arr_beast_talent_trees : ["BREAKER","BEASTMASTERY"],
					_str_beast_ability : ["EXECUTIONER","THORNHIDE","FRISK"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Saltwagg are seal beasts with rounded bodies, slick coats, and surprising strength beneath their playful movements. They gather on ice shelves, rocky beaches, and storm-lashed docks, barking loudly when weather begins to change. Their charm is deceptive; Saltwagg can slam into enemies with brutal force and endure conditions that would exhaust land beasts. Sailors treat them as companions of rough seas, creatures that laugh at cold spray and turn violence into a rolling, slippery brawl.",
					_str_beast_role : "MF | Midfront weather brawler that uses physical damage, crits, and beast support to keep pressure active."
				};
			break;
			#endregion

			#region SPHENISKIP
			case "SPHENISKIP":
				_stct_return_beast = {
					_spr_beast : spr_beast_cerulean_spheniskip,
					_snd_beast_cry : snd_beast_cerulean_spheniskip_cry,
					_snd_beast_death : snd_beast_cerulean_spheniskip_death,
					_str_beast_name : "SPHENISKIP",

					_val_beast_hp_stat : 134,
					_val_beast_con_stat : 96,
					_val_beast_ppow_stat : 18,
					_val_beast_mpow_stat : 136,
					_val_beast_pdef_stat : 78,
					_val_beast_mdef_stat : 112,

					_val_beast_crit_stat : 6,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 7,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["CERULEAN",undefined],
					_str_beast_color_type : ["ABYSS","FROST","WAVE"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "SAILOR",

					_arr_beast_talent_trees : ["VANGUARD","WARDEN"],
					_str_beast_ability : ["MOMENTUM","MAGIC MIRROR","QUICKDRAW"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Spheniskip are penguin beasts with icy crests, compact bodies, and quick sliding footwork across frozen ground. They live in dense colonies along glacier shores, where coordination and timing matter more than size. In battle, they dart between allies, redirect momentum, and use cold magic with surprising elegance. Their small stature makes enemies underestimate them, but Spheniskip survive by never standing where the next blow expects them to be.",
					_str_beast_role : "MF | Midfront ice skirmisher that uses momentum, warding, and quickdraw utility to control tempo."
				};
			break;
			#endregion
		#endregion

		#region VERMILION
			#region ASCHEMASS
			case "ASCHEMASS":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_aschemass,
					_snd_beast_cry : snd_beast_vermilion_aschemass_cry,
					_snd_beast_death : snd_beast_vermilion_aschemass_death,
					_str_beast_name : "ASCHEMASS",

					_val_beast_hp_stat : 188,
					_val_beast_con_stat : 74,
					_val_beast_ppow_stat : 18,
					_val_beast_mpow_stat : 26,
					_val_beast_pdef_stat : 62,
					_val_beast_mdef_stat : 56,

					_val_beast_crit_stat : 0,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 0,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "PRIEST",

					_arr_beast_talent_trees : ["LIFEBINDER","GOURMAND"],
					_str_beast_ability : ["MOMENTUM","RESOLVE","WEATHERCALL: HELLSTORM"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Aschemass are ash golem beasts formed from compacted cinder, charcoal stone, and faintly glowing embers buried under gray crust. They rise from burned forests, ruined forges, and battlefields where heat has long since faded but memory remains hot. Their bodies shed soot with every movement, leaving dark prints that mark places of destruction and renewal. Though not fast or elegant, Aschemass endure like the last coal in a dead fire, waiting for one more spark to give them purpose.",
					_str_beast_role : "MF | Midfront ash guardian that provides sturdy presence, resolve, and weather-based hellstorm setup."
				};
			break;
			#endregion

			#region CANIGNIS
			case "CANIGNIS":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_canignis,
					_snd_beast_cry : snd_beast_vermilion_canignis_cry,
					_snd_beast_death : snd_beast_vermilion_canignis_death,
					_str_beast_name : "CANIGNIS",

					_val_beast_hp_stat : 118,
					_val_beast_con_stat : 48,
					_val_beast_ppow_stat : 196,
					_val_beast_mpow_stat : 18,
					_val_beast_pdef_stat : 52,
					_val_beast_mdef_stat : 38,

					_val_beast_crit_stat : 12,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 8,
					_val_beast_min_stat : 3,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "HUNTER",

					_arr_beast_talent_trees : ["ASSASSIN","AFFLICTOR"],
					_str_beast_ability : ["FEROCITY","RUBY SCALE","PACK TACTICS"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Canignis are hellhound beasts with blackened fur, ember eyes, and jaws that drip smoke instead of saliva. They run across scorched plains and volcanic foothills in hunting packs, following heat trails rather than scent alone. A Canignis pack is loud, violent, and loyal to strength, testing prey and rivals with sudden bursts of flame-lit aggression. Their bites often leave wounds that smolder after the flesh is torn, making even escape feel temporary.",
					_str_beast_role : "MB | Midback critical predator that uses pack tactics, ferocity, and burn-like pressure to finish weakened targets."
				};
			break;
			#endregion

			#region DAIMONIS
			case "DAIMONIS":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_daimonis,
					_snd_beast_cry : snd_beast_vermilion_daimonis_cry,
					_snd_beast_death : snd_beast_vermilion_daimonis_death,
					_str_beast_name : "DAIMONIS",

					_val_beast_hp_stat : 74,
					_val_beast_con_stat : 56,
					_val_beast_ppow_stat : 42,
					_val_beast_mpow_stat : 152,
					_val_beast_pdef_stat : 72,
					_val_beast_mdef_stat : 118,

					_val_beast_crit_stat : 1,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 2,
					_val_beast_min_stat : 6,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "SUMMONER",

					_arr_beast_talent_trees : ["REAPER","ECHO"],
					_str_beast_ability : ["CULL POWER","SPITEFUL END","ECHOING MIND"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Daimonis are demonic caller beasts wrapped in ritual horns, ember-lit markings, and shadows that move too late. They gather around volcanic shrines, ruined summoning circles, and places where desperation has burned into faith. Rather than fighting alone, Daimonis call lesser forces from smoke, blood, and echoing flame, treating battle as a ceremony of escalation. Their presence makes the air feel crowded, as if unseen things are pressing against the world and waiting to be invited in.",
					_str_beast_role : "MB | Midback infernal summoner that overwhelms with minions, sacrifice effects, and echo-driven magic."
				};
			break;
			#endregion

			#region DRAKOAL
			case "DRAKOAL":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_drakoal,
					_snd_beast_cry : snd_beast_vermilion_drakoal_cry,
					_snd_beast_death : snd_beast_vermilion_drakoal_death,
					_str_beast_name : "DRAKOAL",

					_val_beast_hp_stat : 62,
					_val_beast_con_stat : 42,
					_val_beast_ppow_stat : 36,
					_val_beast_mpow_stat : 214,
					_val_beast_pdef_stat : 54,
					_val_beast_mdef_stat : 48,

					_val_beast_crit_stat : 8,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 6,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "HUNTER",

					_arr_beast_talent_trees : ["ALCHEMIST","ARCANIST"],
					_str_beast_ability : ["BREAKER","SYMBIOSIS","CHANNEL FLAME"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Drakoal are young drake beasts with coal-dark scales, glowing throat vents, and wings dusted in soot. They nest in warm cliffs, furnace caverns, and forests recovering from wildfire. Unlike grand dragons, Drakoal are restless and experimental, testing their flame against stone, prey, and rival beasts to learn what burns best. Their magic grows hotter under pressure, and many evolve from scavengers of ash into dangerous arcane hunters once they taste true battle.",
					_str_beast_role : "MB | Midback arcane hunter that blends magical burst, flame channeling, and adaptive offensive tools."
				};
			break;
			#endregion

			#region EMBEROOST
			case "EMBEROOST":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_emberoost,
					_snd_beast_cry : snd_beast_vermilion_emberoost_cry,
					_snd_beast_death : snd_beast_vermilion_emberoost_death,
					_str_beast_name : "EMBEROOST",

					_val_beast_hp_stat : 128,
					_val_beast_con_stat : 96,
					_val_beast_ppow_stat : 48,
					_val_beast_mpow_stat : 178,
					_val_beast_pdef_stat : 84,
					_val_beast_mdef_stat : 152,

					_val_beast_crit_stat : 6,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 8,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "ADVENTURER",

					_arr_beast_talent_trees : ["DUELIST","ORACLE"],
					_str_beast_ability : ["KEEN EYE","LAST GIFT","WEATHERCALL: HEATWAVE"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Emberoost are phoenix-like beasts with radiant feathers, ember tails, and eyes like sunrise through smoke. They appear after wildfires, volcanic eruptions, and battles where destruction leaves enough heat for rebirth. Their bodies constantly shed glowing down that becomes ash before touching the ground, symbolizing renewal through loss. Many cultures see Emberoost as sacred but dangerous, because their healing and hope arrive only after something has already burned.",
					_str_beast_role : "MF | Midfront phoenix battlemage that combines magical pressure, rebirth themes, and weather-based heatwave support."
				};
			break;
			#endregion

			#region HELLSHROOM
			case "HELLSHROOM":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_hellshroom,
					_snd_beast_cry : snd_beast_vermilion_hellshroom_cry,
					_snd_beast_death : snd_beast_vermilion_hellshroom_death,
					_str_beast_name : "HELLSHROOM",

					_val_beast_hp_stat : 116,
					_val_beast_con_stat : 72,
					_val_beast_ppow_stat : 14,
					_val_beast_mpow_stat : 186,
					_val_beast_pdef_stat : 86,
					_val_beast_mdef_stat : 54,

					_val_beast_crit_stat : 8,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 2,
					_val_beast_min_stat : 5,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "SUMMONER",

					_arr_beast_talent_trees : ["LIFEBINDER","CONTROLLER"],
					_str_beast_ability : ["THORNHIDE","SYMBIOSIS","WEATHER CLEANSE"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Hellshroom are infernal mushroom beasts with red caps, smoking gills, and mycelium that thrives in burned soil. They spread through ash fields and volcanic forests, feeding on ruin and converting it into explosive fungal growth. Their spores glow like sparks in the dark, beautiful until inhaled or ignited. Hellshroom colonies are difficult to destroy, because fire only scatters their spores farther, turning attempts at cleansing into the start of a wider infestation.",
					_str_beast_role : "BL | Backline explosive hive unit that uses summons, symbiosis, and magical burn pressure over time."
				};
			break;
			#endregion

			#region IMPARCH
			case "IMPARCH":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_imparch,
					_snd_beast_cry : snd_beast_vermilion_imparch_cry,
					_snd_beast_death : snd_beast_vermilion_imparch_death,
					_str_beast_name : "IMPARCH",

					_val_beast_hp_stat : 58,
					_val_beast_con_stat : 34,
					_val_beast_ppow_stat : 12,
					_val_beast_mpow_stat : 16,
					_val_beast_pdef_stat : 28,
					_val_beast_mdef_stat : 22,

					_val_beast_crit_stat : 6,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 22,
					_val_beast_min_stat : 5,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "ENGINEER",

					_arr_beast_talent_trees : ["GAMBLER","MEDIC"],
					_str_beast_ability : ["NIMBLE","EMPOWER","QUICKDRAW"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Imparch are imp engineer beasts with sharp grins, soot-stained hands, and pockets full of unstable devices. They infest ruined workshops, demon markets, and abandoned siege camps where dangerous tools can be rebuilt badly but quickly. Imparch are physically weak, magically weak, and almost impossible to ignore because they survive by cheating distance, timing, and common sense. Their creations explode, misfire, overperform, or all three, making them liabilities to everyone except the side currently benefiting from the chaos.",
					_str_beast_role : "C | Center mad engineer that relies on extreme dodge, quick utility, empowerment, and disruptive gimmicks."
				};
			break;
			#endregion

			#region INFERNUS
			case "INFERNUS":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_infernus,
					_snd_beast_cry : snd_beast_vermilion_infernus_cry,
					_snd_beast_death : snd_beast_vermilion_infernus_death,
					_str_beast_name : "INFERNUS",

					_val_beast_hp_stat : 164,
					_val_beast_con_stat : 118,
					_val_beast_ppow_stat : 42,
					_val_beast_mpow_stat : 162,
					_val_beast_pdef_stat : 46,
					_val_beast_mdef_stat : 196,

					_val_beast_crit_stat : 3,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 4,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "SOLDIER",

					_arr_beast_talent_trees : ["VANGUARD","GOURMAND"],
					_str_beast_ability : ["STEELBLOOD","CHANNEL FLAME","INSPIRING PRESENCE"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Infernus are fire elemental beasts made from living flame, molten cores, and a faint humanoid outline that never fully stabilizes. They are born in volcanic vents, burning temples, and storms where lightning strikes dry ground repeatedly. Infernus do not understand stillness; their bodies demand motion, consumption, and expansion. When controlled, they are radiant engines of war, but when left unchecked they become walking disasters that turn battlefields into furnaces.",
					_str_beast_role : "FL | Frontline living inferno that provides magical power, weather pressure, and aggressive team inspiration."
				};
			break;
			#endregion

			#region LAVAROWANA
			case "LAVAROWANA":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_lavarowana,
					_snd_beast_cry : snd_beast_vermilion_lavarowana_cry,
					_snd_beast_death : snd_beast_vermilion_lavarowana_death,
					_str_beast_name : "LAVAROWANA",

					_val_beast_hp_stat : 142,
					_val_beast_con_stat : 56,
					_val_beast_ppow_stat : 156,
					_val_beast_mpow_stat : 24,
					_val_beast_pdef_stat : 62,
					_val_beast_mdef_stat : 40,

					_val_beast_crit_stat : 10,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 5,
					_val_beast_min_stat : 4,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "SUMMONER",

					_arr_beast_talent_trees : ["PLANESCALLER","ORACLE"],
					_str_beast_ability : ["FEROCITY","FURY","NIMBLE"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Lavarowana are fire fish beasts with molten scales, glowing fins, and bodies that swim through lava as easily as water. They gather in volcanic rivers and magma pools, leaping from the surface in arcs of orange light. Their eggs hatch in blistering heat, and young Lavarowana survive by devouring weaker spawn before predators can reach them. In battle, they move with predatory rhythm, striking repeatedly and feeding on the panic caused by sudden flame from below.",
					_str_beast_role : "BL | Backline spawn predator that uses physical pressure, fury, nimble movement, and minion-oriented play."
				};
			break;
			#endregion

			#region PYREKNIGHT
			case "PYREKNIGHT":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_pyreknight,
					_snd_beast_cry : snd_beast_vermilion_pyreknight_cry,
					_snd_beast_death : snd_beast_vermilion_pyreknight_death,
					_str_beast_name : "PYREKNIGHT",

					_val_beast_hp_stat : 96,
					_val_beast_con_stat : 84,
					_val_beast_ppow_stat : 194,
					_val_beast_mpow_stat : 22,
					_val_beast_pdef_stat : 228,
					_val_beast_mdef_stat : 94,

					_val_beast_crit_stat : 12,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 0,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "SOLDIER",

					_arr_beast_talent_trees : ["DUELIST","MEDIC"],
					_str_beast_ability : ["STEELBLOOD","EXECUTIONER","GUARDIAN BOND"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Pyreknight are dragon knight beasts encased in scorched armor, horned helms, and scales hardened by furnace heat. They serve no ordinary kingdom, but many ruined empires claimed them as symbols of conquest, execution, and divine flame. Pyreknight fight with brutal clarity, advancing through danger to deliver decisive physical punishment. Their code is harsh: weakness is burned away, enemies are cut down, and anything that survives the pyre is considered worthy of respect.",
					_str_beast_role : "FL | Frontline executioner that delivers heavy physical damage, strong defense, and decisive finishing pressure."
				};
			break;
			#endregion

			#region PYROPLUME
			case "PYROPLUME":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_pyroplume,
					_snd_beast_cry : snd_beast_vermilion_pyroplume_cry,
					_snd_beast_death : snd_beast_vermilion_pyroplume_death,
					_str_beast_name : "PYROPLUME",

					_val_beast_hp_stat : 64,
					_val_beast_con_stat : 56,
					_val_beast_ppow_stat : 18,
					_val_beast_mpow_stat : 242,
					_val_beast_pdef_stat : 42,
					_val_beast_mdef_stat : 104,

					_val_beast_crit_stat : 10,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 8,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "PRIEST",

					_arr_beast_talent_trees : ["BATTLEMAGE","ARCANIST"],
					_str_beast_ability : ["OPPORTUNIST","KEEN EYE","CHANNELER"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Pyroplume are winged fire humanoid beasts with ember feathers, glowing masks, and long limbs wreathed in ceremonial flame. They descend from sunlit cliffs, burning towers, and desert thermals where heat rises like prayer. Pyroplume are not merely destructive; they treat flame as revelation, stripping away lies, weakness, and hesitation through overwhelming radiance. Their magic strikes from above with terrifying precision, turning the sky itself into a source of judgment.",
					_str_beast_role : "MB | Midback divine artillery unit that uses high magical burst, crit pressure, and flame channeling."
				};
			break;
			#endregion

			#region SANGUINAUT
			case "SANGUINAUT":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_sanguinaut,
					_snd_beast_cry : snd_beast_vermilion_sanguinaut_cry,
					_snd_beast_death : snd_beast_vermilion_sanguinaut_death,
					_str_beast_name : "SANGUINAUT",

					_val_beast_hp_stat : 82,
					_val_beast_con_stat : 38,
					_val_beast_ppow_stat : 122,
					_val_beast_mpow_stat : 198,
					_val_beast_pdef_stat : 34,
					_val_beast_mdef_stat : 48,

					_val_beast_crit_stat : 12,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 18,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "SAILOR",

					_arr_beast_talent_trees : ["BERSERKER","ORACLE"],
					_str_beast_ability : ["OPPORTUNIST","CULL POWER","FRISK"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Sanguinaut are vampire beasts with pale armor, red-lit eyes, and movements that resemble a noble duel performed in a burning hall. They haunt ruined keeps, blood-warmed caverns, and old battlefields where rage and hunger have soaked into the stone. Their Vermilion magic is not simple fire, but heat carried through blood, ambition, and predatory will. A Sanguinaut rarely wastes a strike, preferring to bleed enemies slowly before ending the duel with a sudden flash of crimson force.",
					_str_beast_role : "MF | Midfront blood duelist that blends physical and magical burst with dodge, crits, and opportunistic pressure."
				};
			break;
			#endregion

			#region SLAGOLEM
			case "SLAGOLEM":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_slagolem,
					_snd_beast_cry : snd_beast_vermilion_slagolem_cry,
					_snd_beast_death : snd_beast_vermilion_slagolem_death,
					_str_beast_name : "SLAGOLEM",

					_val_beast_hp_stat : 272,
					_val_beast_con_stat : 68,
					_val_beast_ppow_stat : 16,
					_val_beast_mpow_stat : 10,
					_val_beast_pdef_stat : 74,
					_val_beast_mdef_stat : 64,

					_val_beast_crit_stat : 0,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 0,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "SOLDIER",

					_arr_beast_talent_trees : ["BULWARK","SCHOLAR"],
					_str_beast_ability : ["FORTIFIED","OBLIVIOUS","BEASTLINK"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Slagolem are magma golem beasts built from cooled lava plates, molten seams, and a heavy core that pulses like a buried furnace. They crawl from volcanic mines, slag heaps, and ruined foundries where discarded metal and stone fuse under impossible heat. Their outer shells look dull and dead until cracked, revealing the burning mass beneath. Slagolem are slow, blunt, and nearly fearless, advancing like industrial disaster given legs and a target.",
					_str_beast_role : "MF | Midfront molten bulwark that absorbs punishment through huge health, fortification, and stubborn presence."
				};
			break;
			#endregion

			#region SOLEMOLD
			case "SOLEMOLD":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_solemold,
					_snd_beast_cry : snd_beast_vermilion_solemold_cry,
					_snd_beast_death : snd_beast_vermilion_solemold_death,
					_str_beast_name : "SOLEMOLD",

					_val_beast_hp_stat : 86,
					_val_beast_con_stat : 58,
					_val_beast_ppow_stat : 158,
					_val_beast_mpow_stat : 28,
					_val_beast_pdef_stat : 88,
					_val_beast_mdef_stat : 76,

					_val_beast_crit_stat : 2,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 4,
					_val_beast_min_stat : 5,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "ENGINEER",

					_arr_beast_talent_trees : ["SHARPSHOOTER","AFFLICTOR"],
					_str_beast_ability : ["LEECHING FANGS","FLANKER","RECYCLING"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Solemold are demonic ant-builder beasts with furnace-red eyes, metal-edged mandibles, and a talent for constructing brutal hiveworks. They infest volcanic tunnels and abandoned forges, carving chambers where larvae, scrap, and heat are managed with military precision. Unlike wild ants, Solemold colonies understand tools, traps, and production, turning raw material into weapons or brood infrastructure. Their presence usually means the ground below is no longer natural, but part of a growing infernal factory.",
					_str_beast_role : "C | Center forge architect that uses minion capacity, flanking, recycling, and physical support pressure."
				};
			break;
			#endregion

			#region WRATHOOD
			case "WRATHOOD":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_wrathood,
					_snd_beast_cry : snd_beast_vermilion_wrathood_cry,
					_snd_beast_death : snd_beast_vermilion_wrathood_death,
					_str_beast_name : "WRATHOOD",

					_val_beast_hp_stat : 82,
					_val_beast_con_stat : 52,
					_val_beast_ppow_stat : 152,
					_val_beast_mpow_stat : 42,
					_val_beast_pdef_stat : 48,
					_val_beast_mdef_stat : 44,

					_val_beast_crit_stat : 6,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 2,
					_val_beast_min_stat : 3,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "PRIEST",

					_arr_beast_talent_trees : ["REAPER","MEDIC"],
					_str_beast_ability : ["PATIENT","SPELLHIGH","LAST GIFT"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Wrathood are robed demon beasts with hidden faces, ember-scripted cloth, and hands that tremble with contained fury. They gather in burned chapels, execution grounds, and places where devotion curdled into violence. Their power comes from patient hatred rather than wild rage, building pressure through chants, curses, and sudden acts of brutal conviction. Those who hear a Wrathood praying often mistake it for mourning until the spell ignites and the ground answers in flame.",
					_str_beast_role : "C | Center fanatic crusader that mixes physical pressure, spell support, patience, and reaper-style finishing tools."
				};
			break;
			#endregion

			#region WYRMELTA
			case "WYRMELTA":
				_stct_return_beast = {
					_spr_beast : spr_beast_vermilion_wyrmelta,
					_snd_beast_cry : snd_beast_vermilion_wyrmelta_cry,
					_snd_beast_death : snd_beast_vermilion_wyrmelta_death,
					_str_beast_name : "WYRMELTA",

					_val_beast_hp_stat : 94,
					_val_beast_con_stat : 46,
					_val_beast_ppow_stat : 12,
					_val_beast_mpow_stat : 236,
					_val_beast_pdef_stat : 62,
					_val_beast_mdef_stat : 168,

					_val_beast_crit_stat : 7,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 6,
					_val_beast_min_stat : 3,

					_arr_beast_colors : ["VERMILION",undefined],
					_str_beast_color_type : ["ASH","MAGMA","PYRE"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "HUNTER",

					_arr_beast_talent_trees : ["TACTICIAN","SCHOLAR"],
					_str_beast_ability : ["ELEMENTAL WARD: CRIMSON","OVERWHELM"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Wyrmelta are fire worm beasts with segmented magma bodies, dark armor plates, and jaws that glow from internal heat. They burrow through volcanic soil, slag fields, and deep tunnels where stone softens around their passing. Wyrmelta rarely surface unless drawn by vibration, blood, or a sudden drop in temperature that suggests prey above. Their attacks are ambushes of molten force, erupting from beneath and leaving tunnels of charred glass where the battlefield used to be stable.",
					_str_beast_role : "MB | Midback magma ambusher that delivers extreme magical burst, pressure spikes, and scholar-like tactical support."
				};
			break;
			#endregion
	#endregion

		#region VIRIDIAN
			#region ARBRAWN
			case "ARBRAWN":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_arbrawn,
					_snd_beast_cry : snd_beast_viridian_arbrawn_cry,
					_snd_beast_death : snd_beast_viridian_arbrawn_death,
					_str_beast_name : "ARBRAWN",

					_val_beast_hp_stat : 240,
					_val_beast_con_stat : 155,
					_val_beast_ppow_stat : 145,
					_val_beast_mpow_stat : 18,
					_val_beast_pdef_stat : 180,
					_val_beast_mdef_stat : 52,

					_val_beast_crit_stat : 1,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 3,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "ADVENTURER",

					_arr_beast_talent_trees : ["JUGGERNAUT","WARDEN"],
					_str_beast_ability : ["ANCHORED","FLANKER","INTIMIDATION"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Arbrawn are massive gorilla-like beasts grown from corded bark, knotted musclewood, and thick emerald vines. They wander old forests and ruin-choked valleys, clearing paths through bramble walls with their fists and marking safe routes for smaller creatures. Their temperament is slow to anger, but once threatened they root themselves into the earth and become nearly impossible to move. Arbrawn are often seen as living trailbreakers, guardians of wild passages, and protectors of deep green territories where civilization has failed to reach.",
					_str_beast_role : "FL, MF | Durable frontline bruiser that anchors the team, absorbs pressure, and punishes enemies with steady physical force."
				};
			break;
			#endregion

			#region ARGENTBUD
			case "ARGENTBUD":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_argentbud,
					_snd_beast_cry : snd_beast_viridian_argentbud_cry,
					_snd_beast_death : snd_beast_viridian_argentbud_death,					
					_str_beast_name : "ARGENTBUD",

					_val_beast_hp_stat : 54,
					_val_beast_con_stat : 95,
					_val_beast_ppow_stat : 22,
					_val_beast_mpow_stat : 38,
					_val_beast_pdef_stat : 42,
					_val_beast_mdef_stat : 68,

					_val_beast_crit_stat : 0,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 1,
					_val_beast_min_stat : 5,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "MERCHANT",

					_arr_beast_talent_trees : ["SHARPSHOOTER","BEASTMASTERY"],
					_str_beast_ability : ["OBLIVIOUS","LAST GIFT","EASY PREY"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Argentbud are delicate plant beasts with silver-veined petals, pale stems, and roots that curl like searching fingers. They grow in mineral-rich glades where old magic seeps through the soil, drawing trace metals into their petals until they shine like coin or moonlit glass. Merchants and wanderers consider them lucky, not because they create wealth outright, but because they reveal hidden resources others overlook. In the wild, an Argentbud colony often marks a place where life, treasure, and danger are tangled together.",
					_str_beast_role : "C | Fragile support economy unit focused on swarms, utility, and long-term value instead of direct combat."
				};
			break;
			#endregion

			#region BEAVINE
			case "BEAVINE":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_beavine,
					_snd_beast_cry : snd_beast_viridian_beavine_cry,
					_snd_beast_death : snd_beast_viridian_beavine_death,							
					_str_beast_name : "BEAVINE",

					_val_beast_hp_stat : 88,
					_val_beast_con_stat : 82,
					_val_beast_ppow_stat : 104,
					_val_beast_mpow_stat : 96,
					_val_beast_pdef_stat : 64,
					_val_beast_mdef_stat : 60,

					_val_beast_crit_stat : 2,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 4,
					_val_beast_min_stat : 5,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "ADVENTURER",

					_arr_beast_talent_trees : ["BREAKER","CONTROLLER"],
					_str_beast_ability : ["DISRUPTIVE","DEATH CRY","RECYCLING"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Beavine are moss-backed beaver beasts that shape living timber with branchlike teeth and vine-wrapped paws. They build lodges, bridges, dams, and defensive walls from wood that continues to grow after being placed, turning quiet riverbanks into fortified green workshops. Forest settlements tolerate them because their construction stabilizes wetlands, but careless travelers sometimes find entire paths redirected by Beavine engineering overnight. They are practical, tireless, and communal, treating every battlefield like terrain waiting to be improved.",
					_str_beast_role : "BL | Backline utility hybrid that builds advantage through summons, disruption, and flexible physical or magical support."
				};
			break;
			#endregion

			#region BRYOBITE
			case "BRYOBITE":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_bryobite,
					_snd_beast_cry : snd_beast_viridian_bryobite_cry,
					_snd_beast_death : snd_beast_viridian_bryobite_death,	
					_str_beast_name : "BRYOBITE",

					_val_beast_hp_stat : 280,
					_val_beast_con_stat : 110,
					_val_beast_ppow_stat : 8,
					_val_beast_mpow_stat : 6,
					_val_beast_pdef_stat : 125,
					_val_beast_mdef_stat : 120,

					_val_beast_crit_stat : 0,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 0,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "HUNTER",

					_arr_beast_talent_trees : ["ALCHEMIST","SCHOLAR"],
					_str_beast_ability : ["SECOND WIND","BLOODLUST","BEASTLINK"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Bryobite are heavy frog beasts covered in wet moss, lichen plates, and thick layers of living bog growth. They dwell in old marshes where stagnant pools hide medicinal fungi, venomous insects, and half-sunken ruins. Despite their awkward shape, Bryobite are patient survivors, absorbing punishment while their bodies slowly repair through stored moisture and symbiotic plant matter. Local shamans claim that a sleeping Bryobite can be mistaken for an island until it opens its eyes beneath the reeds.",
					_str_beast_role : "FL | Immense living fortress that survives through raw health, recovery, and stubborn frontline presence."
				};
			break;
			#endregion

			#region CHITROOPER
			case "CHITROOPER":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_chitrooper,
					_snd_beast_cry : snd_beast_viridian_chitrooper_cry,
					_snd_beast_death : snd_beast_viridian_chitrooper_death,						
					_str_beast_name : "CHITROOPER",

					_val_beast_hp_stat : 74,
					_val_beast_con_stat : 60,
					_val_beast_ppow_stat : 192,
					_val_beast_mpow_stat : 22,
					_val_beast_pdef_stat : 52,
					_val_beast_mdef_stat : 44,

					_val_beast_crit_stat : 14,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 2,
					_val_beast_min_stat : 3,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "SOLDIER",

					_arr_beast_talent_trees : ["BREAKER","AFFLICTOR"],
					_str_beast_ability : ["EXECUTIONER","BREAKER","WEATHERPROOF"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Chitrooper are ant-soldier beasts with thorned mandibles, leaflike armor, and rigid emerald chitin. They travel in disciplined columns through root tunnels and forest floors, breaking down carcasses, fallen wood, and hostile intruders with the same cold efficiency. A lone Chitrooper is dangerous, but a swarm becomes a moving weapon system directed by scent, vibration, and instinct. Their colonies are not evil, merely absolute; anything judged useful is harvested, and anything judged threatening is dismantled.",
					_str_beast_role : "MF | Aggressive midfront striker that relies on execution pressure, swarm support, and high physical damage."
				};
			break;
			#endregion

			#region CRUSABER
			case "CRUSABER":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_crusaber,
					_snd_beast_cry : snd_beast_viridian_crusaber_cry,
					_snd_beast_death : snd_beast_viridian_crusaber_death,							
					_str_beast_name : "CRUSABER",

					_val_beast_hp_stat : 102,
					_val_beast_con_stat : 82,
					_val_beast_ppow_stat : 132,
					_val_beast_mpow_stat : 126,
					_val_beast_pdef_stat : 96,
					_val_beast_mdef_stat : 82,

					_val_beast_crit_stat : 7,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 5,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "ADVENTURER",

					_arr_beast_talent_trees : ["BULWARK","GOURMAND"],
					_str_beast_ability : ["STEADFAST","UNBREAKABLE MIND","GUARDIAN BOND"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Crusaber are mantis beasts with blade-shaped forearms, thorn-edged carapaces, and a posture that resembles a duelist at prayer. They haunt vine-covered shrines and quiet forest arenas where sunlight filters through the canopy in thin green lines. Unlike many Viridian beasts, Crusaber do not fight wildly; they study movement, wait for weakness, and strike with ritual precision. Some forest clans treat them as sacred challengers, believing that surviving a Crusaber duel proves discipline over instinct.",
					_str_beast_role : "MF, C | Balanced duelist that mixes offense, guard pressure, and controlled frontline or center positioning."
				};
			break;
			#endregion

			#region DRYADAE
			case "DRYADAE":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_dryadae,
					_snd_beast_cry : snd_beast_viridian_dryadae_cry,
					_snd_beast_death : snd_beast_viridian_dryadae_death,		
					_str_beast_name : "DRYADAE",

					_val_beast_hp_stat : 114,
					_val_beast_con_stat : 104,
					_val_beast_ppow_stat : 20,
					_val_beast_mpow_stat : 176,
					_val_beast_pdef_stat : 48,
					_val_beast_mdef_stat : 72,

					_val_beast_crit_stat : 1,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 4,
					_val_beast_min_stat : 4,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "SUMMONER",

					_arr_beast_talent_trees : ["PLANESCALLER","BEASTMASTERY"],
					_str_beast_ability : ["WEATHERPROOF","CHANNEL POISON","ILLUSION"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Dryadae are tree-women beasts formed from living wood, hanging moss, flowering antlers, and a face half-hidden by leaves. They are usually found in old-growth groves where the boundary between beast, spirit, and plant becomes difficult to define. Dryadae rarely move quickly, but entire patches of forest respond to their presence, bending vines aside or raising roots in defense. They are not rulers of the wild so much as its memory, carrying the shape of every season inside their wooden bodies.",
					_str_beast_role : "MB | Nature summoner that supports from the midback with poison channels, illusions, and summoned pressure."
				};
			break;
			#endregion

			#region FIGHTREE
			case "FIGHTREE":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_fightree,
					_snd_beast_cry : snd_beast_viridian_fightree_cry,
					_snd_beast_death : snd_beast_viridian_fightree_death,	
					_str_beast_name : "FIGHTREE",

					_val_beast_hp_stat : 255,
					_val_beast_con_stat : 182,
					_val_beast_ppow_stat : 30,
					_val_beast_mpow_stat : 18,
					_val_beast_pdef_stat : 215,
					_val_beast_mdef_stat : 110,

					_val_beast_crit_stat : 0,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 0,
					_val_beast_min_stat : 1,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MARTIAL",
					_str_beast_class : "SOLDIER",

					_arr_beast_talent_trees : ["JUGGERNAUT","ECHO"],
					_str_beast_ability : ["STEELBLOOD","EMERALD SCALE","WEATHERCALL: SEEDFALL"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Fightree are ancient tree beasts whose trunks are split by scars, knuckle-like roots, and hardened bark plates. They are believed to awaken only when forests suffer repeated violence, rising from groves that have absorbed too much blood, ash, or iron. Their movement is slow but catastrophic, each step cracking stone and each swing carrying the weight of an old forest defending itself. Smaller Viridian creatures gather near Fightree during disasters, treating them as walking shelters against fire, blades, and storms.",
					_str_beast_role : "FL | Huge frontline guardian that trades speed for extreme bulk, defense, and immovable pressure."
				};
			break;
			#endregion

			#region FLITSAGE
			case "FLITSAGE":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_flitsage,
					_snd_beast_cry : snd_beast_viridian_flitsage_cry,
					_snd_beast_death : snd_beast_viridian_flitsage_death,	
					_str_beast_name : "FLITSAGE",

					_val_beast_hp_stat : 42,
					_val_beast_con_stat : 44,
					_val_beast_ppow_stat : 8,
					_val_beast_mpow_stat : 245,
					_val_beast_pdef_stat : 24,
					_val_beast_mdef_stat : 28,

					_val_beast_crit_stat : 4,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 16,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "MAGE",

					_arr_beast_talent_trees : ["BATTLEMAGE","ECHO"],
					_str_beast_ability : ["NIMBLE","ELEMENTAL WARD: VIRIDIAN","ECHOING MIND"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Flitsage are tiny hummingbird beasts surrounded by petals, pollen sparks, and quick flashes of Viridian magic. They live among flowering canopies and hidden nectar springs, feeding on both sweet sap and raw arcane residue. Though physically fragile, they move with impossible speed, tracing healing patterns or destructive sigils through the air with their wingbeats. A grove with many Flitsage often hums faintly at dawn, as if the flowers themselves are chanting under the sound of wings.",
					_str_beast_role : "MB | Glass cannon spellcaster that attacks from protected midback positioning with explosive magical output."
				};
			break;
			#endregion

			#region FURN
			case "FURN":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_furn,
					_snd_beast_cry : snd_beast_viridian_furn_cry,
					_snd_beast_death : snd_beast_viridian_furn_death,	
					_str_beast_name : "FURN",

					_val_beast_hp_stat : 82,
					_val_beast_con_stat : 60,
					_val_beast_ppow_stat : 205,
					_val_beast_mpow_stat : 16,
					_val_beast_pdef_stat : 48,
					_val_beast_mdef_stat : 34,

					_val_beast_crit_stat : 11,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 18,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "HUNTER",

					_arr_beast_talent_trees : ["SABOTEUR","WARDEN"],
					_str_beast_ability : ["PACK TACTICS","FEROCITY","INFECTIOUS STRIKES"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Furn are wolf beasts with moss-dark fur, thornlike claws, and eyes that glow through forest mist. They hunt alone more often than in packs, following scent trails across root, stone, and running water without losing focus. Their bites and scratches carry subtle infections from the deep wild, weakening prey long before the final chase. Hunters respect Furn because it does not waste energy; it marks, stalks, isolates, and ends the fight only when the outcome is already decided.",
					_str_beast_role : "MB | Agile predator that pressures marked targets with physical burst, bleed, poison, and evasive movement."
				};
			break;
			#endregion

			#region LEPOROOT
			case "LEPOROOT":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_leporoot,
					_snd_beast_cry : snd_beast_viridian_leporoot_cry,
					_snd_beast_death : snd_beast_viridian_leporoot_death,	
					_str_beast_name : "LEPOROOT",

					_val_beast_hp_stat : 48,
					_val_beast_con_stat : 52,
					_val_beast_ppow_stat : 72,
					_val_beast_mpow_stat : 64,
					_val_beast_pdef_stat : 36,
					_val_beast_mdef_stat : 42,

					_val_beast_crit_stat : 1,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 10,
					_val_beast_min_stat : 3,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "MERCHANT",

					_arr_beast_talent_trees : ["SABOTEUR","CONTROLLER"],
					_str_beast_ability : ["NIMBLE","RHYTHMIC STRIKES","QUICKDRAW"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Leporoot are rabbit beasts with rootlike legs, leafy ears, and restless instincts for finding edible shoots, herbs, and hidden burrows. They thrive in meadow edges and young forests where growth is fast, messy, and full of opportunity. Though timid at first glance, Leporoot survive by reacting faster than danger can settle, striking suddenly before vanishing through tangled roots. Rural communities sometimes follow Leporoot tracks after storms, knowing they often lead toward safe ground, fresh water, or newly uncovered supplies.",
					_str_beast_role : "MB | Fast gatherer-skirmisher that uses mobility, quick strikes, and utility to exploit openings."
				};
			break;
			#endregion

			#region LUMBUCK
			case "LUMBUCK":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_lumbuck,
					_snd_beast_cry : snd_beast_viridian_lumbuck_cry,
					_snd_beast_death : snd_beast_viridian_lumbuck_death,	
					_str_beast_name : "LUMBUCK",

					_val_beast_hp_stat : 108,
					_val_beast_con_stat : 126,
					_val_beast_ppow_stat : 94,
					_val_beast_mpow_stat : 96,
					_val_beast_pdef_stat : 92,
					_val_beast_mdef_stat : 102,

					_val_beast_crit_stat : 2,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 3,
					_val_beast_min_stat : 4,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "MAGE",

					_arr_beast_talent_trees : ["LIFEBINDER","GOURMAND"],
					_str_beast_ability : ["MOMENTUM","SPELLHIGH","MANAFLOW"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Lumbuck are deer beasts with branchlike antlers, glowing moss along their backs, and calm eyes that suggest old intelligence. They appear in quiet woodland clearings at dusk, especially where ancient stones or forgotten shrines have been overtaken by grass. Lumbuck are not aggressive, but they command deep natural magic through rhythm, movement, and breath, causing nearby plants to bloom or wither according to need. Many travelers believe following a Lumbuck means being judged by the forest itself.",
					_str_beast_role : "MB | Sage-like magical support that builds momentum, improves mana flow, and sustains allies from midback."
				};
			break;
			#endregion

			#region MAMBARK
			case "MAMBARK":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_mambark,
					_snd_beast_cry : snd_beast_viridian_mambark_cry,
					_snd_beast_death : snd_beast_viridian_mambark_death,	
					_str_beast_name : "MAMBARK",

					_val_beast_hp_stat : 52,
					_val_beast_con_stat : 54,
					_val_beast_ppow_stat : 18,
					_val_beast_mpow_stat : 198,
					_val_beast_pdef_stat : 32,
					_val_beast_mdef_stat : 82,

					_val_beast_crit_stat : 16,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 14,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "HUNTER",

					_arr_beast_talent_trees : ["ASSASSIN","ORACLE"],
					_str_beast_ability : ["OPPORTUNIST","FOREWARN","KEEN EYE"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Mambark are snake beasts with bark-patterned scales, venomous fangs, and bodies that vanish easily among roots and fallen branches. They inhabit shaded forests where rot, fungus, and new life exist side by side. Their venom is not merely toxic; it carries mutating Viridian energy that weakens the body while feeding surrounding plant life. Mambark rarely chase prey openly, preferring to wait beneath leaves until a single strike is enough to decide the encounter.",
					_str_beast_role : "BL | Backline venom assassin that uses magic damage, crits, foresight, and opportunistic finishing pressure."
				};
			break;
			#endregion

			#region MORELUSH
			case "MORELUSH":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_morelush,
					_snd_beast_cry : snd_beast_viridian_morelush_cry,
					_snd_beast_death : snd_beast_viridian_morelush_death,	
					_str_beast_name : "MORELUSH",

					_val_beast_hp_stat : 72,
					_val_beast_con_stat : 90,
					_val_beast_ppow_stat : 12,
					_val_beast_mpow_stat : 28,
					_val_beast_pdef_stat : 56,
					_val_beast_mdef_stat : 74,

					_val_beast_crit_stat : 0,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 1,
					_val_beast_min_stat : 6,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "SUMMONER",

					_arr_beast_talent_trees : ["HEXWEAVER","WARDEN"],
					_str_beast_ability : ["CULL POWER","SPOREBURST","SYMBIOSIS"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Morelush are morel mushroom beasts with swollen caps, pale stalks, and clouds of spores that drift like dusty lantern light. They grow in damp hollows, corpse-rich soil, and places where decay has become fertile rather than dead. A Morelush colony is a living network, sharing nutrients, warnings, and strange dreams through underground fungal threads. Their bodies seem fragile, but destroying one often releases spores that feed the next generation or bind nearby creatures into the colony’s slow intelligence.",
					_str_beast_role : "C | Center summoner queen that overwhelms with minion capacity, spores, symbiosis, and attrition."
				};
			break;
			#endregion

			#region SPOROSE
			case "SPOROSE":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_sporose,
					_snd_beast_cry : snd_beast_viridian_sporose_cry,
					_snd_beast_death : snd_beast_viridian_sporose_death,	
					_str_beast_name : "SPOROSE",

					_val_beast_hp_stat : 84,
					_val_beast_con_stat : 74,
					_val_beast_ppow_stat : 64,
					_val_beast_mpow_stat : 132,
					_val_beast_pdef_stat : 84,
					_val_beast_mdef_stat : 68,

					_val_beast_crit_stat : 3,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 3,
					_val_beast_min_stat : 2,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "MAGE",

					_arr_beast_talent_trees : ["INVOKER","MEDIC"],
					_str_beast_ability : ["INFECTIOUS STRIKES","RESOLVE","EMPOWER"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Sporose are iguana beasts with fungal ridges, soft green scales, and patches of moss growing between their spines. They bask on warm stones in humid forests, absorbing sunlight and spores alike until their bodies become adaptive vessels for Viridian magic. When threatened, they shift their internal chemistry, hardening skin, empowering allies, or spreading infectious growth through their attacks. Scholars disagree whether Sporose are reptiles colonized by fungus or fungi that learned to wear reptile shape.",
					_str_beast_role : "MB | Adaptive mage that mixes poison pressure, empowerment, and healing utility from midback."
				};
			break;
			#endregion

			#region STRIGIBLOOM
			case "STRIGIBLOOM":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_strigibloom,
					_snd_beast_cry : snd_beast_viridian_strigibloom_cry,
					_snd_beast_death : snd_beast_viridian_strigibloom_death,	
					_str_beast_name : "STRIGIBLOOM",

					_val_beast_hp_stat : 126,
					_val_beast_con_stat : 72,
					_val_beast_ppow_stat : 84,
					_val_beast_mpow_stat : 86,
					_val_beast_pdef_stat : 56,
					_val_beast_mdef_stat : 134,

					_val_beast_crit_stat : 2,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 17,
					_val_beast_min_stat : 3,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "TECHNICAL",
					_str_beast_class : "MERCHANT",

					_arr_beast_talent_trees : ["GAMBLER","ECHO"],
					_str_beast_ability : ["KEEN EYE","DISRUPTIVE","FRISK"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Strigibloom are owl beasts with petal-fringed feathers, bark-dark talons, and luminous eyes that see through leaves, fog, and deception. They nest in hollow trees near old paths, watching travelers with unsettling patience. Unlike common predators, Strigibloom hunt secrets as much as flesh, stealing small objects, reading movement, and exposing hidden weaknesses before battle begins. Their hoots are considered bad luck by thieves, because a Strigibloom rarely watches without eventually revealing what should have stayed concealed.",
					_str_beast_role : "MF | Mystic support that disrupts enemies, scouts advantages, and uses evasive utility from midfront."
				};
			break;
			#endregion

			#region TURFRANTULA
			case "TURFRANTULA":
				_stct_return_beast = {
					_spr_beast : spr_beast_viridian_turfrantula,
					_snd_beast_cry : snd_beast_viridian_turfrantula_cry,
					_snd_beast_death : snd_beast_viridian_turfrantula_death,	
					_str_beast_name : "TURFRANTULA",

					_val_beast_hp_stat : 88,
					_val_beast_con_stat : 84,
					_val_beast_ppow_stat : 28,
					_val_beast_mpow_stat : 34,
					_val_beast_pdef_stat : 62,
					_val_beast_mdef_stat : 96,

					_val_beast_crit_stat : 6,
					_val_beast_crit_dmg_stat : 25,
					_val_beast_dod_stat : 12,
					_val_beast_min_stat : 5,

					_arr_beast_colors : ["VIRIDIAN",undefined],
					_str_beast_color_type : ["NATURAL","BOTANICAL","WILD"],

					_str_beast_archetype : "MAGICAL",
					_str_beast_class : "SUMMONER",

					_arr_beast_talent_trees : ["PLANESCALLER","ARCANIST"],
					_str_beast_ability : ["OPPORTUNIST","EMPOWER","WEATHER CLEANSE"],

					_str_beast_breed : undefined,
					_val_beast_prestige_stat : undefined,
					_val_beast_level : 1,

					_arr_beast_feed_list : ["EMPTY"],
					_ref_beast_held_item : "EMPTY",

					_arr_beast_markings : undefined,
					_arr_beast_scars : undefined,

					_val_beast_hp_cur : 0,
					_val_beast_hp_max : 0,
					_val_beast_exp : 0,

					_str_beast_lore : "Turfrantula are tarantula beasts covered in turf-like hair, thorned legs, and damp soil clinging to their bodies. They dig deep burrows beneath forest floors, where their tunnels become nurseries for eggs, roots, and strange fungal growths. Though frightening, they are patient ecosystem builders, dragging fallen matter underground and turning death into breeding ground. In combat, Turfrantula prefer traps, ambushes, and weather shifts, letting enemies struggle through the battlefield before the brood closes in.",
					_str_beast_role : "BL | Backline broodmother that supports with summons, opportunistic effects, weather control, and attrition."
				};
			break;
			#endregion

		#endregion

	}

	//----------------//
	//ASSIGN SPEED STAT//
	//----------------//
	if (is_struct(_stct_return_beast)){
		_stct_return_beast._val_beast_speed_stat = scr_get_beast_speed_stat(_str_beast_name);
	}

	return _stct_return_beast;
}
