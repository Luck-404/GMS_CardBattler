//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_GET_ITEM_INFO
// FUNCTION: Builds and returns the authoritative Item struct for a requested
//           Item ID.
//
//           Defines Item display data, sprite, Item Type, trigger type,
//           behavior script, description, team-Unique metadata, stack behavior,
//           quantity limits, and Item UID assignment.
//
// ARGUMENTS: _str_item_id - Item ID to resolve.
// RETURNS: Complete Item struct for the requested Item ID.
//
//===============================================================================//

function scr_inventory_get_item_info(_str_item_id){

	//================//
	//CREATE ITEM//
	//================//
	var _stct_item = {
		_str_item_id : _str_item_id,
		_str_item_name : "DEFAULT",
		_spr_item : spr_item_egg_arbrawn,
		_str_item_type : undefined,
		_str_trigger_text : undefined,
		_str_item_trigger_type : undefined,
		_str_unique_team_group : "",
		_scr_item : undefined,
		_str_item_desc : "DEFAULT",
		_flag_consumed_on_trigger : false,
		_flag_unique_team : false,
		_flag_stackable : false,
		_ct_item_amount : 1,
		_ct_item_max_amount : 1,
		_uid_item : global.uid_next_item
	};

	//================//
	//GET ITEM INFO//
	//================//
	switch (_str_item_id){

		#region QUEST

		case "QUEST_IMPORTANT_NOTEBOOK":
			_stct_item._str_item_name = "IMPORTANT NOTEBOOK";
			_stct_item._spr_item = spr_item_quest_important_notebook;
			_stct_item._str_item_type = "QUEST";
			_stct_item._scr_item = scr_inventory_item_quest_important_notebook;
			_stct_item._str_item_desc = "An important notebook used for completing a quest.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		#endregion

		#region CONSUMABLE

		case "CONSUMABLE_HEALING_SALVE":
			_stct_item._str_item_name = "HEALING SALVE";
			_stct_item._spr_item = spr_item_consumable_healing_salve;
			_stct_item._str_item_type = "CONSUMABLE";
			_stct_item._scr_item = scr_inventory_item_consumable_healing_salve;
			_stct_item._str_item_desc = "A healing balm that can be used to heal beasts.";
			_stct_item._flag_stackable = true;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 10;
		break;

		#endregion


		case "HELD_ARCANE_CAPACITOR":
			_stct_item._str_item_name = "ARCANE CAPACITOR";
			_stct_item._spr_item = spr_item_held_arcane_capacitor;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "TEAM_RULE";
			_stct_item._scr_item = scr_inventory_item_held_arcane_capacitor;
			_stct_item._str_item_desc = "Unique (1 per team). Increases the player's maximum Mana by 1.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_unique_team = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_ARCHMAGES_FOCUS":
			_stct_item._str_item_name = "ARCHMAGE'S FOCUS";
			_stct_item._spr_item = spr_item_held_archmages_focus;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "PASSIVE";
			_stct_item._scr_item = scr_inventory_item_held_archmages_focus;
			_stct_item._str_item_desc = "Unique (1 per team). Draw 1 additional Card at the beginning of each player turn.";
			_stct_item._flag_unique_team = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_FORGOTTEN_MANUSCRIPT":
			_stct_item._str_item_name = "FORGOTTEN MANUSCRIPT";
			_stct_item._spr_item = spr_item_held_forgotten_manuscript;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "PASSIVE";
			_stct_item._scr_item = scr_inventory_item_held_forgotten_manuscript;
			_stct_item._str_item_desc = "Unique (1 per team). Increases maximum hand size by 1.";
			_stct_item._flag_unique_team = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		#region MATERIAL

		case "MATERIAL_BLADE_GRASS":
		case "MATERIAL_CRIMSITE":
		case "MATERIAL_DARKWOOD":
		case "MATERIAL_DAZZLING_HIDE":
		case "MATERIAL_HARDSTONE":
		case "MATERIAL_IRON":
		case "MATERIAL_LEAF_LITTER":
		case "MATERIAL_LIFEPETAL":
		case "MATERIAL_LIGHTWOOD":
		case "MATERIAL_LINEN":
		case "MATERIAL_ROUGH_BONE":
		case "MATERIAL_SILK":
		case "MATERIAL_SIMPLE_HIDE":
		case "MATERIAL_SOFTSTONE":
		case "MATERIAL_VINES":

			var _stct_material_info = scr_inventory_get_material_info(_str_item_id);

			if (_stct_material_info != undefined){

				_stct_item._str_item_id = _stct_material_info._str_item_id;
				_stct_item._str_item_name = _stct_material_info._str_item_name;

				_stct_item._spr_item = _stct_material_info._spr_item;

				_stct_item._str_item_type = "MATERIAL";

				_stct_item._scr_item = scr_inventory_use_material_item;

				_stct_item._str_item_desc = _stct_material_info._str_item_desc;

				_stct_item._flag_stackable = true;

				_stct_item._ct_item_amount = 1;
				_stct_item._ct_item_max_amount = 100;
			}

		break;

		#endregion
		#region PRISM

		case "PRISM_COMMON":
		case "PRISM_UNCOMMON":
		case "PRISM_RARE":
		case "PRISM_EPIC":
		case "PRISM_LEGENDARY":
		case "PRISM_ARCWORK":

			var _stct_prism_info = scr_inventory_get_prism_info(_str_item_id);

			if (_stct_prism_info != undefined){
				_stct_item._str_item_id = _stct_prism_info._str_item_id;
				_stct_item._str_item_name = _stct_prism_info._str_item_name;
				_stct_item._spr_item = _stct_prism_info._spr_item;
				_stct_item._str_item_type = "PRISM";
				_stct_item._scr_item = scr_inventory_use_prism_overworld;
				_stct_item._str_item_desc = _stct_prism_info._str_item_desc;
				_stct_item._flag_stackable = true;
				_stct_item._ct_item_amount = 1;
				_stct_item._ct_item_max_amount = 10;
			}
		break;

		#endregion

		#region HELD



		case "HELD_BATTLE_STANDARD":
			_stct_item._str_item_name = "BATTLE STANDARD";
			_stct_item._spr_item = spr_item_held_battle_standard;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "GAINED BOOST";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_battle_standard;
			_stct_item._str_item_desc = "On battle entry, the holder gains 1 stack of BOOST (+10% damage) for 3 turns.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_BLOOD_MOON_TALISMAN":
			_stct_item._str_item_name = "BLOOD MOON TALISMAN";
			_stct_item._spr_item = spr_item_held_blood_moon_talisman;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "STARTED EVENT: BLOOD MOON";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_blood_moon_talisman;
			_stct_item._str_item_desc = "Begin battle with BLOOD MOON.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_BLOODSTAINED_IDOL":
			_stct_item._str_item_name = "BLOODSTAINED IDOL";
			_stct_item._spr_item = spr_item_held_bloodstained_idol;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "STARTED EVENT: BLOODMIST";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_bloodstained_idol;
			_stct_item._str_item_desc = "Begin battle with BLOODMIST.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_BLOOMTIDE_CHALICE":
			_stct_item._str_item_name = "BLOOMTIDE CHALICE";
			_stct_item._spr_item = spr_item_held_bloomtide_chalice;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "STARTED EVENT: BLOOMTIDE";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_bloomtide_chalice;
			_stct_item._str_item_desc = "Begin battle with BLOOMTIDE.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_CINDER_CORE":
			_stct_item._str_item_name = "CINDER CORE";
			_stct_item._spr_item = spr_item_held_cinder_core;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "STARTED WEATHER: HEATWAVE";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_cinder_core;
			_stct_item._str_item_desc = "Begin battle with HEATWAVE.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_EXPANDED_GRIMOIRE":
			_stct_item._str_item_name = "EXPANDED GRIMOIRE";
			_stct_item._spr_item = spr_item_held_expanded_grimoire;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "TEAM_RULE";
			_stct_item._scr_item = scr_inventory_item_held_expanded_grimoire;
			_stct_item._str_item_desc = "Unique (1 per team). Increases maximum Deck Size by 5.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_unique_team = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_FIRESTORM_LANTERN":
			_stct_item._str_item_name = "FIRESTORM LANTERN";
			_stct_item._spr_item = spr_item_held_firestorm_lantern;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "STARTED WEATHER: FIRESTORM";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_firestorm_lantern;
			_stct_item._str_item_desc = "Begin battle with FIRESTORM.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_RAINCALLER_SHELL":
			_stct_item._str_item_name = "RAINCALLER SHELL";
			_stct_item._spr_item = spr_item_held_raincaller_shell;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "STARTED WEATHER: RAIN";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_raincaller_shell;
			_stct_item._str_item_desc = "Begin battle with RAIN.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_SEERS_LENS":
			_stct_item._str_item_name = "SEER'S LENS";
			_stct_item._spr_item = spr_item_held_seers_lens;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "TEAM_RULE";
			_stct_item._scr_item = scr_inventory_item_held_seers_lens;
			_stct_item._str_item_desc = "Draw 2 additional Cards in the opening hand.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_unique_team = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_SNOW_GLOBE":
			_stct_item._str_item_name = "SNOW GLOBE";
			_stct_item._spr_item = spr_item_held_snow_globe;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "STARTED WEATHER: SNOW";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_snow_globe;
			_stct_item._str_item_desc = "Begin battle with SNOW.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_STORMGLASS":
			_stct_item._str_item_name = "STORMGLASS";
			_stct_item._spr_item = spr_item_held_stormglass;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "STARTED WEATHER: STORMING";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_stormglass;
			_stct_item._str_item_desc = "Begin battle with STORMING.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_AMPLIFYING_BELL":
			_stct_item._str_item_name = "AMPLIFYING BELL";
			_stct_item._spr_item = spr_item_held_amplifying_bell;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "PASSIVE_MODIFIER";
			_stct_item._scr_item = scr_inventory_item_held_amplifying_bell;
			_stct_item._str_item_desc = "Unique (1 per team). When the holder creates a stackable Buff, it gains 1 additional stack.";
			_stct_item._flag_unique_team = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_BLIGHT_VIAL":
			_stct_item._str_item_name = "BLIGHT VIAL";
			_stct_item._spr_item = spr_item_held_blight_vial;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "PASSIVE_MODIFIER";
			_stct_item._scr_item = scr_inventory_item_held_blight_vial;
			_stct_item._str_item_desc = "Unique (1 per team). When the holder creates a stackable DoT, it gains 1 additional stack.";
			_stct_item._flag_unique_team = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_POCKET_HIVE":
			_stct_item._str_item_name = "POCKET HIVE";
			_stct_item._spr_item = spr_item_held_pocket_hive;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "SPAWNED WASP DRONES";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_pocket_hive;
			_stct_item._str_item_desc = "On battle entry, summon up to 3 Wasp Drones on the holder, stopping when its Minion slots are full.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_POWERFUL_STONE":
			_stct_item._str_item_name = "POWERFUL STONE";
			_stct_item._spr_item = spr_item_held_powerful_stone;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_powerful_stone;
			_stct_item._str_item_desc = "Can be given to a beast to increase their physical power.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_SORCEROUS_GEM":
			_stct_item._str_item_name = "SORCEROUS GEM";
			_stct_item._spr_item = spr_item_held_sorcerous_gem;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_sorcerous_gem;
			_stct_item._str_item_desc = "Can be given to a beast to increase their magic power.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_INSPIRING_CHIME":
			_stct_item._str_item_name = "INSPIRING CHIME";
			_stct_item._spr_item = spr_item_held_inspiring_chime;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "PLAYER";
			_stct_item._scr_item = scr_inventory_item_held_inspiring_chime;
			_stct_item._str_item_desc = "Can be given to a beast to increase the move speed of a player by 15%. Stacks.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_VERDANT_SEED":
			_stct_item._str_item_name = "VERDANT SEED";
			_stct_item._spr_item = spr_item_held_verdant_seed;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "STARTED WEATHER: SEEDFALL";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_verdant_seed;
			_stct_item._str_item_desc = "Begin battle with SEEDFALL.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_EMERALD_TALISMAN":
			_stct_item._str_item_name = "EMERALD TALISMAN";
			_stct_item._spr_item = spr_item_held_emerald_talisman;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "SPAWNED VIRIDIAN MINION";
			_stct_item._str_item_trigger_type = "TURN_START";
			_stct_item._scr_item = scr_inventory_item_held_emerald_talisman;
			_stct_item._str_item_desc = "Can be given to a beast to spawn a random Viridian minion upon turn start.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_BURNING_ASH":
			_stct_item._str_item_name = "BURNING ASH";
			_stct_item._spr_item = spr_item_held_burning_ash;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "ON_HIT";
			_stct_item._scr_item = scr_inventory_item_held_burning_ash;
			_stct_item._str_item_desc = "Physical attacks have a 25% chance to apply Burn.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_HEALING_FRUIT":
			_stct_item._str_item_name = "HEALING FRUIT";
			_stct_item._spr_item = spr_item_held_healing_fruit;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "ON_TARGET";
			_stct_item._str_trigger_text = "HEALED FOR 25% HP";
			_stct_item._scr_item = scr_inventory_item_held_healing_fruit;
			_stct_item._str_item_desc = "After taking direct HP damage, if the holder is below 50% HP, restore 25% of maximum HP. Consumed.";
			_stct_item._flag_consumed_on_trigger = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_HUNTERS_TROPHY":
			_stct_item._str_item_name = "HUNTER'S TROPHY";
			_stct_item._spr_item = spr_item_held_hunters_trophy;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "ENCOUNTER";
			_stct_item._str_unique_team_group = "ELITE_ENCOUNTER";
			_stct_item._scr_item = scr_inventory_item_held_hunters_trophy;
			_stct_item._str_item_desc = "Unique (1 Elite encounter Item per team). Raises natural Elite encounter chance from 4% to 20%. Successful Elites are Risk Tier 1: doubled universal Elite stat/HP bonuses, +5 Linear damage to Attack damage instances, and 25% improved reward quality. Cannot be equipped alongside Challenger's Bell.";
			_stct_item._flag_unique_team = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_BOLSTERING_SHELL":
			_stct_item._str_item_name = "BOLSTERING SHELL";
			_stct_item._spr_item = spr_item_held_bolstering_shell;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "TURN_END";
			_stct_item._scr_item = scr_inventory_item_held_bolstering_shell;
			_stct_item._str_item_desc = "Grants 3 Armor to its holder at the end of every turn.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_GOLD_FANG":
			_stct_item._str_item_name = "GOLD FANG";
			_stct_item._spr_item = spr_item_held_gold_fang;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "BATTLE_EXIT";
			_stct_item._scr_item = scr_inventory_item_held_gold_fang;
			_stct_item._str_item_desc = "Increases gold gained from victorious battles by 10%.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_BROOD_TOTEM":
			_stct_item._str_item_name = "BROOD TOTEM";
			_stct_item._spr_item = spr_item_held_brood_totem;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_brood_totem;
			_stct_item._str_item_desc = "Can be given to a beast to increase their Minion Slots by 1.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_CERULEAN_INCENSE":
			_stct_item._str_item_name = "CERULEAN INCENSE";
			_stct_item._spr_item = spr_item_held_cerulean_incense;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "ENCOUNTER";
			_stct_item._scr_item = scr_inventory_item_held_cerulean_incense;
			_stct_item._str_item_desc = "Doubles the encounter weight of Cerulean Beasts already present in local encounter pools. Does not stack.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_CHALLENGERS_BELL":
			_stct_item._str_item_name = "CHALLENGER'S BELL";
			_stct_item._spr_item = spr_item_held_challengers_bell;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "ENCOUNTER";
			_stct_item._str_unique_team_group = "ELITE_ENCOUNTER";
			_stct_item._scr_item = scr_inventory_item_held_challengers_bell;
			_stct_item._str_item_desc = "Unique (1 Elite encounter Item per team). Raises natural Elite encounter chance from 4% to 10%. Cannot be equipped alongside Hunter's Trophy.";
			_stct_item._flag_unique_team = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_COLLECTORS_SEAL":
			_stct_item._str_item_name = "COLLECTOR'S SEAL";
			_stct_item._spr_item = spr_item_held_collectors_seal;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "RESOURCE";
			_stct_item._scr_item = scr_inventory_item_held_collectors_seal;
			_stct_item._str_item_desc = "Increases normal Beast and Zone Item reward chance from victorious battles by 10 percentage points. Stacks.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_CURSED_IDOL":
			_stct_item._str_item_name = "CURSED IDOL";
			_stct_item._spr_item = spr_item_held_cursed_idol;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "APPLIED WITHER x3";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_cursed_idol;
			_stct_item._str_item_desc = "On battle entry, attempt to apply WITHER x3 for 3 turns to a random living enemy.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_DORMANT_POD":
			_stct_item._str_item_name = "DORMANT POD";
			_stct_item._spr_item = spr_item_held_dormant_pod;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "SPAWNED DORMANT SEEDS";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_dormant_pod;
			_stct_item._str_item_desc = "On battle entry, summon up to 2 Dormant Seeds on the holder, stopping when its Minion slots are full.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_EMBER_LENS":
			_stct_item._str_item_name = "EMBER LENS";
			_stct_item._spr_item = spr_item_held_ember_lens;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "PASSIVE_MODIFIER";
			_stct_item._scr_item = scr_inventory_item_held_ember_lens;
			_stct_item._str_item_desc = "Holder's Vermilion Attack Cards gain +2 base damage magnitude.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_FLEET_FEATHER":
			_stct_item._str_item_name = "FLEET FEATHER";
			_stct_item._spr_item = spr_item_held_fleet_feather;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_fleet_feather;
			_stct_item._str_item_desc = "Can be given to a beast to increase their Speed by 20.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_HAWKEYE_LENS":
			_stct_item._str_item_name = "HAWKEYE LENS";
			_stct_item._spr_item = spr_item_held_hawkeye_lens;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_hawkeye_lens;
			_stct_item._str_item_desc = "Can be given to a beast to increase their Critical Hit Chance by 5%.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_IRON_SHELL":
			_stct_item._str_item_name = "IRON SHELL";
			_stct_item._spr_item = spr_item_held_iron_shell;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_iron_shell;
			_stct_item._str_item_desc = "Can be given to a beast to increase their physical defense.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_LUCKY_COIN":
			_stct_item._str_item_name = "LUCKY COIN";
			_stct_item._spr_item = spr_item_held_lucky_coin;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "RESOURCE";
			_stct_item._scr_item = scr_inventory_item_held_lucky_coin;
			_stct_item._str_item_desc = "Increases all normal optional battle reward chances by 5 percentage points. Stacks.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_MENDING_MOSS":
			_stct_item._str_item_name = "MENDING MOSS";
			_stct_item._spr_item = spr_item_held_mending_moss;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "HEALED 5";
			_stct_item._str_item_trigger_type = "TURN_END";
			_stct_item._scr_item = scr_inventory_item_held_mending_moss;
			_stct_item._str_item_desc = "At Turn End, heal the holder for 5 HP.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_NEUTRAL_LENS":
			_stct_item._str_item_name = "NEUTRAL LENS";
			_stct_item._spr_item = spr_item_held_neutral_lens;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "PASSIVE_MODIFIER";
			_stct_item._scr_item = scr_inventory_item_held_neutral_lens;
			_stct_item._str_item_desc = "Holder's Uncolored Attack Cards gain +2 base damage magnitude.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_PHOENIX_EMBER":
			_stct_item._str_item_name = "PHOENIX EMBER";
			_stct_item._spr_item = spr_item_held_phoenix_ember;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "ON_FATAL";
			_stct_item._str_trigger_text = "DEATH PREVENTED";
			_stct_item._scr_item = scr_inventory_item_held_phoenix_ember;
			_stct_item._str_item_desc = "Prevents defeat once. Restore 5% of maximum HP and remove all other Status effects except OUTLEVELED and other resurrection effects. Consumed.";
			_stct_item._flag_consumed_on_trigger = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_PURIFYING_BELL":
			_stct_item._str_item_name = "PURIFYING BELL";
			_stct_item._spr_item = spr_item_held_purifying_bell;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "CLEANSE";
			_stct_item._str_item_trigger_type = "TURN_START";
			_stct_item._scr_item = scr_inventory_item_held_purifying_bell;
			_stct_item._str_item_desc = "At Turn Start, cleanse 1 stack from one random cleansable negative Status on the holder.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_QUICKSILK_RIBBON":
			_stct_item._str_item_name = "QUICKSILK RIBBON";
			_stct_item._spr_item = spr_item_held_quicksilk_ribbon;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_quicksilk_ribbon;
			_stct_item._str_item_desc = "Can be given to a beast to increase their Dodge Chance by 5%.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_RAZOR_FANG":
			_stct_item._str_item_name = "RAZOR FANG";
			_stct_item._spr_item = spr_item_held_razor_fang;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_razor_fang;
			_stct_item._str_item_desc = "Can be given to a beast to increase their Critical Hit Damage by 10%.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_REGROWTH_CHARM":
			_stct_item._str_item_name = "REGROWTH CHARM";
			_stct_item._spr_item = spr_item_held_regrowth_charm;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "RESTORED 3% MAX HP";
			_stct_item._str_item_trigger_type = "TURN_END";
			_stct_item._scr_item = scr_inventory_item_held_regrowth_charm;
			_stct_item._str_item_desc = "Unique (1 per team). At Turn End, heal the holder for 3% of its maximum HP.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_unique_team = true;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_RESOLUTE_CHARM":
			_stct_item._str_item_name = "RESOLUTE CHARM";
			_stct_item._spr_item = spr_item_held_resolute_charm;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_resolute_charm;
			_stct_item._str_item_desc = "Can be given to a beast to increase their Constitution by 20.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_SALVAGERS_MAGNET":
			_stct_item._str_item_name = "SALVAGER'S MAGNET";
			_stct_item._spr_item = spr_item_held_salvagers_magnet;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "RESOURCE";
			_stct_item._scr_item = scr_inventory_item_held_salvagers_magnet;
			_stct_item._str_item_desc = "Guarantees 1 additional Material reward after victorious battles. Stacks with other Salvager's Magnets.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_SCHOLARS_RIBBON":
			_stct_item._str_item_name = "SCHOLAR'S RIBBON";
			_stct_item._spr_item = spr_item_held_scholars_ribbon;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "RESOURCE";
			_stct_item._scr_item = scr_inventory_item_held_scholars_ribbon;
			_stct_item._str_item_desc = "Holder gains 2 additional EXP after victorious battles if they survive.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_SCRIBES_QUILL":
			_stct_item._str_item_name = "SCRIBE'S QUILL";
			_stct_item._spr_item = spr_item_held_scribes_quill;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "RESOURCE";
			_stct_item._scr_item = scr_inventory_item_held_scribes_quill;
			_stct_item._str_item_desc = "Increases Beast and Zone Card reward chances from victorious battles by 10 percentage points. Stacks.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_THORNPLATE":
			_stct_item._str_item_name = "THORNPLATE";
			_stct_item._spr_item = spr_item_held_thornplate;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "ON_DIRECT_DAMAGE";
			_stct_item._str_trigger_text = "RETALIATED";
			_stct_item._scr_item = scr_inventory_item_held_thornplate;
			_stct_item._str_item_desc = "When struck by direct Card damage, retaliate for 3 fixed Neutral damage.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_TIDAL_LENS":
			_stct_item._str_item_name = "TIDAL LENS";
			_stct_item._spr_item = spr_item_held_tidal_lens;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "PASSIVE_MODIFIER";
			_stct_item._scr_item = scr_inventory_item_held_tidal_lens;
			_stct_item._str_item_desc = "Holder's Cerulean Attack Cards gain +2 base damage magnitude.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;


		case "HELD_TRAVELERS_BUCKLER":
			_stct_item._str_item_name = "TRAVELER'S BUCKLER";
			_stct_item._spr_item = spr_item_held_travelers_buckler;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_trigger_text = "GAINED 20 ARMOR";
			_stct_item._str_item_trigger_type = "ENTRY";
			_stct_item._scr_item = scr_inventory_item_held_travelers_buckler;
			_stct_item._str_item_desc = "On battle entry, the holder gains 20 Armor.";
			_stct_item._flag_consumed_on_trigger = false;
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_VERDANT_LENS":
			_stct_item._str_item_name = "VERDANT LENS";
			_stct_item._spr_item = spr_item_held_verdant_lens;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "PASSIVE_MODIFIER";
			_stct_item._scr_item = scr_inventory_item_held_verdant_lens;
			_stct_item._str_item_desc = "Holder's Viridian Attack Cards gain +2 base damage magnitude.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_VERMILION_INCENSE":
			_stct_item._str_item_name = "VERMILION INCENSE";
			_stct_item._spr_item = spr_item_held_vermilion_incense;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "ENCOUNTER";
			_stct_item._scr_item = scr_inventory_item_held_vermilion_incense;
			_stct_item._str_item_desc = "Doubles the encounter weight of Vermilion Beasts already present in local encounter pools. Does not stack.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_VIRIDIAN_INCENSE":
			_stct_item._str_item_name = "VIRIDIAN INCENSE";
			_stct_item._spr_item = spr_item_held_viridian_incense;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "ENCOUNTER";
			_stct_item._scr_item = scr_inventory_item_held_viridian_incense;
			_stct_item._str_item_desc = "Doubles the encounter weight of Viridian Beasts already present in local encounter pools. Does not stack.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_VITALITY_ROOT":
			_stct_item._str_item_name = "VITALITY ROOT";
			_stct_item._spr_item = spr_item_held_vitality_root;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_vitality_root;
			_stct_item._str_item_desc = "Can be given to a beast to increase their HP Stat by 20.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		case "HELD_WARDING_CRYSTAL":
			_stct_item._str_item_name = "WARDING CRYSTAL";
			_stct_item._spr_item = spr_item_held_warding_crystal;
			_stct_item._str_item_type = "HELD";
			_stct_item._str_item_trigger_type = "STATS";
			_stct_item._scr_item = scr_inventory_item_held_warding_crystal;
			_stct_item._str_item_desc = "Can be given to a beast to increase their magical defense.";
			_stct_item._flag_stackable = false;
			_stct_item._ct_item_amount = 1;
			_stct_item._ct_item_max_amount = 1;
		break;

		#endregion

		#region EGG

			#region VIRIDIAN

				#region ARBRAWN
				case "EGG_ARBRAWN":
					_stct_item._str_item_name = "ARBRAWN EGG";
					_stct_item._spr_item = spr_item_egg_arbrawn;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Arbrawn.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region ARGENTBUD
				case "EGG_ARGENTBUD":
					_stct_item._str_item_name = "ARGENTBUD EGG";
					_stct_item._spr_item = spr_item_egg_argentbud;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Argentbud.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region BEAVINE
				case "EGG_BEAVINE":
					_stct_item._str_item_name = "BEAVINE EGG";
					_stct_item._spr_item = spr_item_egg_beavine;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Beavine.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region BRYOBITE
				case "EGG_BRYOBITE":
					_stct_item._str_item_name = "BRYOBITE EGG";
					_stct_item._spr_item = spr_item_egg_bryobite;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Bryobite.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region CHITROOPER
				case "EGG_CHITROOPER":
					_stct_item._str_item_name = "CHITROOPER EGG";
					_stct_item._spr_item = spr_item_egg_chitropper;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Chitrooper.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region CRUSABER
				case "EGG_CRUSABER":
					_stct_item._str_item_name = "CRUSABER EGG";
					_stct_item._spr_item = spr_item_egg_crusaber;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Crusaber.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region DRYADAE
				case "EGG_DRYADAE":
					_stct_item._str_item_name = "DRYADAE EGG";
					_stct_item._spr_item = spr_item_egg_dryadae;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Dryadae.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region FIGHTREE
				case "EGG_FIGHTREE":
					_stct_item._str_item_name = "FIGHTREE EGG";
					_stct_item._spr_item = spr_item_egg_fightree;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Fightree.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region FLITSAGE
				case "EGG_FLITSAGE":
					_stct_item._str_item_name = "FLITSAGE EGG";
					_stct_item._spr_item = spr_item_egg_flitsage;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Flitsage.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region FURN
				case "EGG_FURN":
					_stct_item._str_item_name = "FURN EGG";
					_stct_item._spr_item = spr_item_egg_furn;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Furn.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region LEPOROOT
				case "EGG_LEPOROOT":
					_stct_item._str_item_name = "LEPOROOT EGG";
					_stct_item._spr_item = spr_item_egg_leporoot;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Leporoot.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region LUMBUCK
				case "EGG_LUMBUCK":
					_stct_item._str_item_name = "LUMBUCK EGG";
					_stct_item._spr_item = spr_item_egg_lumbuck;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Lumbuck.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region MAMBARK
				case "EGG_MAMBARK":
					_stct_item._str_item_name = "MAMBARK EGG";
					_stct_item._spr_item = spr_item_egg_mambark;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Mambark.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region MORELUSH
				case "EGG_MORELUSH":
					_stct_item._str_item_name = "MORELUSH EGG";
					_stct_item._spr_item = spr_item_egg_morelush;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Morelush.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region SPOROSE
				case "EGG_SPOROSE":
					_stct_item._str_item_name = "SPOROSE EGG";
					_stct_item._spr_item = spr_item_egg_sporose;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Sporose.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region STRIGIBLOOM
				case "EGG_STRIGIBLOOM":
					_stct_item._str_item_name = "STRIGIBLOOM EGG";
					_stct_item._spr_item = spr_item_egg_strigibloom;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Strigibloom.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region TURFRANTULA
				case "EGG_TURFRANTULA":
					_stct_item._str_item_name = "TURFRANTULA EGG";
					_stct_item._spr_item = spr_item_egg_turfrantula;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Turfrantula.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

			#endregion

			#region CERULEAN

				#region AMMOMARSH
				case "EGG_AMMOMARSH":
					_stct_item._str_item_name = "AMMOMARSH EGG";
					_stct_item._spr_item = spr_item_egg_ammomarsh;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Ammomarsh.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region BLIZZDRIFT
				case "EGG_BLIZZDRIFT":
					_stct_item._str_item_name = "BLIZZDRIFT EGG";
					_stct_item._spr_item = spr_item_egg_blizzdrift;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Blizzdrift.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region CAUDAQUA
				case "EGG_CAUDAQUA":
					_stct_item._str_item_name = "CAUDAQUA EGG";
					_stct_item._spr_item = spr_item_egg_caudaqua;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Caudaqua.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region CEPHARIME
				case "EGG_CEPHARIME":
					_stct_item._str_item_name = "CEPHARIME EGG";
					_stct_item._spr_item = spr_item_egg_cepharime;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Cepharime.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region CHELONSEA
				case "EGG_CHELONSEA":
					_stct_item._str_item_name = "CHELONSEA EGG";
					_stct_item._spr_item = spr_item_egg_chelonsea;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Chelonsea.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region CORALLIARC
				case "EGG_CORALLIARC":
					_stct_item._str_item_name = "CORALLIARC EGG";
					_stct_item._spr_item = spr_item_egg_coralliarc;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Coralliarc.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region FROSTUSK
				case "EGG_FROSTUSK":
					_stct_item._str_item_name = "FROSTUSK EGG";
					_stct_item._spr_item = spr_item_egg_frostusk;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Frostusk.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region GALENATRIUM
				case "EGG_GALENATRIUM":
					_stct_item._str_item_name = "GALENATRIUM EGG";
					_stct_item._spr_item = spr_item_egg_galenatrium;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Galenatrium.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region GLACIMIGHT
				case "EGG_GLACIMIGHT":
					_stct_item._str_item_name = "GLACIMIGHT EGG";
					_stct_item._spr_item = spr_item_egg_glacimight;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Glacimight.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region GULFLOW
				case "EGG_GULFLOW":
					_stct_item._str_item_name = "GULFLOW EGG";
					_stct_item._spr_item = spr_item_egg_gulflow;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Gulflow.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region ISTIRAIN
				case "EGG_ISTIRAIN":
					_stct_item._str_item_name = "ISTIRAIN EGG";
					_stct_item._spr_item = spr_item_egg_istirain;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Istirain.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region KELPLATANI
				case "EGG_KELPLATANI":
					_stct_item._str_item_name = "KELPLATANI EGG";
					_stct_item._spr_item = spr_item_egg_kelplatani;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Kelplatani.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region LONTRIVER
				case "EGG_LONTRIVER":
					_stct_item._str_item_name = "LONTRIVER EGG";
					_stct_item._spr_item = spr_item_egg_lontriver;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Lontriver.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region MARITIMICE
				case "EGG_MARITIMICE":
					_stct_item._str_item_name = "MARITIMICE EGG";
					_stct_item._spr_item = spr_item_egg_maritimice;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Maritimice.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region SALTWAGG
				case "EGG_SALTWAGG":
					_stct_item._str_item_name = "SALTWAGG EGG";
					_stct_item._spr_item = spr_item_egg_saltwagg;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Saltwagg.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region SPHENISKIP
				case "EGG_SPHENISKIP":
					_stct_item._str_item_name = "SPHENISKIP EGG";
					_stct_item._spr_item = spr_item_egg_spheniskip;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Spheniskip.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

			#endregion

			#region VERMILION

				#region ASCHEMASS
				case "EGG_ASCHEMASS":
					_stct_item._str_item_name = "ASCHEMASS EGG";
					_stct_item._spr_item = spr_item_egg_achemass;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Aschemass.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region CANIGNIS
				case "EGG_CANIGNIS":
					_stct_item._str_item_name = "CANIGNIS EGG";
					_stct_item._spr_item = spr_item_egg_canignis;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Canignis.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region DAIMONIS
				case "EGG_DAIMONIS":
					_stct_item._str_item_name = "DAIMONIS EGG";
					_stct_item._spr_item = spr_item_egg_daimonis;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Daimonis.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region DRAKOAL
				case "EGG_DRAKOAL":
					_stct_item._str_item_name = "DRAKOAL EGG";
					_stct_item._spr_item = spr_item_egg_drakoal;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Drakoal.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region EMBEROOST
				case "EGG_EMBEROOST":
					_stct_item._str_item_name = "EMBEROOST EGG";
					_stct_item._spr_item = spr_item_egg_emberoost;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Emberoost.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region HELLSHROOM
				case "EGG_HELLSHROOM":
					_stct_item._str_item_name = "HELLSHROOM EGG";
					_stct_item._spr_item = spr_item_egg_hellshroom;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Hellshroom.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region IMPARCH
				case "EGG_IMPARCH":
					_stct_item._str_item_name = "IMPARCH EGG";
					_stct_item._spr_item = spr_item_egg_imparch;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Imparch.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region INFERNUS
				case "EGG_INFERNUS":
					_stct_item._str_item_name = "INFERNUS EGG";
					_stct_item._spr_item = spr_item_egg_infernus;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Infernus.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region LAVAROWANA
				case "EGG_LAVAROWANA":
					_stct_item._str_item_name = "LAVAROWANA EGG";
					_stct_item._spr_item = spr_item_egg_lavarowana;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Lavarowana.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region PYREKNIGHT
				case "EGG_PYREKNIGHT":
					_stct_item._str_item_name = "PYREKNIGHT EGG";
					_stct_item._spr_item = spr_item_egg_pyreknight;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Pyreknight.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region PYROPLUME
				case "EGG_PYROPLUME":
					_stct_item._str_item_name = "PYROPLUME EGG";
					_stct_item._spr_item = spr_item_egg_pyroplume;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Pyroplume.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region SANGUINAUT
				case "EGG_SANGUINAUT":
					_stct_item._str_item_name = "SANGUINAUT EGG";
					_stct_item._spr_item = spr_item_egg_sanginaut;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Sanguinaut.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region SLAGOLEM
				case "EGG_SLAGOLEM":
					_stct_item._str_item_name = "SLAGOLEM EGG";
					_stct_item._spr_item = spr_item_egg_slagolem;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Slagolem.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region SOLEMOLD
				case "EGG_SOLEMOLD":
					_stct_item._str_item_name = "SOLEMOLD EGG";
					_stct_item._spr_item = spr_item_egg_solemold;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Solemold.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region WRATHOOD
				case "EGG_WRATHOOD":
					_stct_item._str_item_name = "WRATHOOD EGG";
					_stct_item._spr_item = spr_item_egg_wrathood;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Wrathood.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

				#region WYRMELTA
				case "EGG_WYRMELTA":
					_stct_item._str_item_name = "WYRMELTA EGG";
					_stct_item._spr_item = spr_item_egg_wyrmelta;
					_stct_item._str_item_type = "EGG";
					_stct_item._scr_item = undefined;
					_stct_item._str_item_desc = "An egg of the beast Wyrmelta.";
					_stct_item._flag_stackable = false;
					_stct_item._ct_item_amount = 1;
					_stct_item._ct_item_max_amount = 1;
				break;
				#endregion

			#endregion

		#endregion
	}

	//================//
	//ASSIGN ITEM UID//
	//================//
	global.uid_next_item++;

	return _stct_item;
}
