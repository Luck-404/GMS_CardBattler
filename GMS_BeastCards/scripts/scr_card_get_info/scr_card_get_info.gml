//===============================================================================//
//
// SCRIPT: SCR_CARD_GET_INFO
// FUNCTION: Returns a new card struct from an input card ID.
//           Stores all static card definition data in the returned struct and
//           assigns a unique card UID before returning it.
//
// ARGUMENTS: _str_card_name is the card ID whose definition should be returned.
// RETURNS: A newly created card information struct.
//
//===============================================================================//

function scr_card_get_info(_str_card_name){

	//========================//
	//CARD DEFINITION FIELDS//
	//========================//
	// NAME          - string
	// SPRITE        - sprite index
	// COLOR(S)      - ["COLOR1","COLOR2"] or ["COLOR1",undefined]
	// RANGE         - SELF, MELEE, RANGED, BACK, GLOBAL, TEAM
	// MAIN TYPE     - ATTACK, DEFENSE, SUPPORT, UTILITY, ARCHETYPE
	// EFFECT TYPE   - DIRECT, DOT, DEBUFF, CC, BUFF, ARMOR, HEAL, SUMMON,
	//                 WEATHER, CARD_DRAW, MANA, TURN, REPOSITION, EVENT,
	//                 CARD_MANIPULATION, OTHER
	// STAT TYPE     - NEU, MAG, PHY
	// TARGET COUNT  - SELF, ST, ADJACENT, TEAMWIDE, GLOBAL, CARD
	// MAGNITUDE     - int / real
	// ARCHETYPE REQ - MAGICAL, MARTIAL, TECHNICAL
	// CLASS REQ     - MAGE, SUMMONER, PRIEST, SOLDIER, SAILOR, ADVENTURER,
	//                 ENGINEER, MERCHANT, HUNTER
	// RARITY        - I, II, III, IV
	// MANA COST     - int
	// EXHAUSTS      - true or false
	// SCRIPT        - script index
	// DESC          - string

	//================//
	//STRUCT FOR CARD//
	//================//
	var _stct_return_card = {
		_str_card_name : "DEFAULT",
		_str_card_id : _str_card_name,
		_spr_card : spr_card_uncolored,
		_arr_card_colors : ["UNCOLORED",undefined],
		_str_card_range : "MELEE",
		_str_card_type : "ATTACK",
		_str_card_effect_type : "DIRECT",
		_str_card_stat : "NEU",
		_str_card_target_count : "ST",
		_val_card_magnitude : undefined,
		_str_card_scalar : "LINEAR",
		_str_card_archetype_req : undefined,
		_str_card_class_req : undefined,
		_str_card_rarity : "I",
		_val_card_mana_cost : 0,
		_flag_card_exhausts : false,
		_scr_card : scr_card_uncolored_strike,
		_str_card_description : "DEFAULT"
	};

	//==================//
	//CARD DEFINITIONS//
	//==================//
	switch (_str_card_name){

		#region CERULEAN
			#region ABSOLUTE_ZERO
			case "ABSOLUTE_ZERO":
				_stct_return_card = {
					_str_card_name : "ABSOLUTE ZERO",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_absolute_zero,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 16,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : "MAGE",
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_absolute_zero,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [Linear] MAG dmg (base 16). ICEBREAKER."
				};
			break;
			#endregion

			#region ABYSSAL_HARPOON
			case "ABYSSAL_HARPOON":
				_stct_return_card = {
					_str_card_name : "ABYSSAL HARPOON",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_abyssal_harpoon,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : "ENGINEER",
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_abyssal_harpoon,
					_str_card_description : "ST. Self. Summon an Abyssal Harpoon (3/1). Each round, it targets a random enemy Beast (prefers the back half of the team), deals 2 NEU dmg per Magnitude, and pulls that Beast forward 1 position."
				};
			break;
			#endregion

			#region ABYSSAL_TOUCH
			case "ABYSSAL_TOUCH":
				_stct_return_card = {
					_str_card_name : "ABYSSAL TOUCH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_abyssal_touch,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_abyssal_touch,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 6)."
				};
			break;
			#endregion

			#region ANCHOR_STONE
			case "ANCHOR_STONE":
				_stct_return_card = {
					_str_card_name : "ANCHOR STONE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_anchor_stone,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : "ENGINEER",
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_anchor_stone,
					_str_card_description : "EXHAUSTS. ST. Ranged. Summon an Anchor Stone (3/0) on the target allied Beast. While it lives, all allied Beasts gain Immovable."
				};
			break;
			#endregion

			#region ANCIENT_CHARTS
			case "ANCIENT_CHARTS":
				_stct_return_card = {
					_str_card_name : "ANCIENT CHARTS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_ancient_charts,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_MANIPULATION",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_ancient_charts,
					_str_card_description : "EXHAUSTS. Global. Search your draw pile for a Utility card and draw it."
				};
			break;
			#endregion

			#region AQUA_STEP
			case "AQUA_STEP":
				_stct_return_card = {
					_str_card_name : "AQUA STEP",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_aqua_step,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "TEAM",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "REPOSITION",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_aqua_step,
					_str_card_description : "ST. Ranged. Swap the caster's position with the target allied Beast."
				};
			break;
			#endregion

			#region ARCTIC_FOCUS
			case "ARCTIC_FOCUS":
				_stct_return_card = {
					_str_card_name : "ARCTIC FOCUS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_arctic_focus,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_arctic_focus,
					_str_card_description : "ST. Ranged. The target allied Beast is immune to CC for 2 rounds."
				};
			break;
			#endregion

			#region ARCTIC_VOLLEY
			case "ARCTIC_VOLLEY":
				_stct_return_card = {
					_str_card_name : "ARCTIC VOLLEY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_arctic_volley,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_arctic_volley,
					_str_card_description : "ST. Ranged. Deal [Linear] PHY dmg 3 times (base 3 per hit)."
				};
			break;
			#endregion

			#region ARMOR_TRANSFER
			case "ARMOR_TRANSFER":
				_stct_return_card = {
					_str_card_name : "ARMOR TRANSFER",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_armor_transfer,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_armor_transfer,
					_str_card_description : "ST. Ranged. Transfer all Armor from the caster to the target allied Beast."
				};
			break;
			#endregion

			#region AVALANCHE_STRIKE
			case "AVALANCHE_STRIKE":
				_stct_return_card = {
					_str_card_name : "AVALANCHE STRIKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_avalanche_strike,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "FRONT2",
					_val_card_magnitude : 15,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_avalanche_strike,
					_str_card_description : "EXHAUSTS. AoE-2. Melee. Deal [Linear] PHY dmg to the front two enemy Beasts (base 15)."
				};
			break;
			#endregion

			#region BITTER_CHILL
			case "BITTER_CHILL":
				_stct_return_card = {
					_str_card_name : "BITTER CHILL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_bitter_chill,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DOT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_bitter_chill,
					_str_card_description : "ST. Ranged. Apply 1 Frostbite and Weaken the target."
				};
			break;
			#endregion

			#region BRITTLE_CONSTITUTION
			case "BRITTLE_CONSTITUTION":
				_stct_return_card = {
					_str_card_name : "BRITTLE CONSTITUTION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_brittle_constitution,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_brittle_constitution,
					_str_card_description : "EXHAUSTS. ST. Ranged. Reduce the target's CON by 30 for 3 rounds. While active, its DoTs have a 25% chance to not lose duration when they trigger."
				};
			break;
			#endregion

			#region BUBBLE
			case "BUBBLE":
				_stct_return_card = {
					_str_card_name : "BUBBLE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_bubble,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_bubble,
					_str_card_description : "EXHAUSTS. ST. Self. Gain Divine Protection. Block the next Attack."
				};
			break;
			#endregion

			#region BURST
			case "BURST":
				_stct_return_card = {
					_str_card_name : "BURST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_burst,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_burst,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 6)."
				};
			break;
			#endregion

			#region CALL_THE_DEEP
			case "CALL_THE_DEEP":
				_stct_return_card = {
					_str_card_name : "CALL THE DEEP",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_call_the_deep,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 5,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_call_the_deep,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Fill all available Minion slots on the selected team with Tentacles (3/1). Tentacles do not stack during this cast. Each Beast on the selected team gains an expendable Buff: its next direct damage deals 5 additional dmg."
				};
			break;
			#endregion

			#region CALM_SEAS
			case "CALM_SEAS":
				_stct_return_card = {
					_str_card_name : "CALM SEAS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_calm_seas,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "AURA",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_calm_seas,
					_str_card_description : "Teamwide. Ranged. Aura. (+) Allied Beasts heal 3 HP each round. (-) Allied Beasts deal 2 less [Linear] damage."
				};
			break;
			#endregion

			#region CERULEAN_GODS_WRATH
			case "CERULEAN_GODS_WRATH":
				_stct_return_card = {
					_str_card_name : "CERULEAN GOD'S WRATH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_gods_wrath,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "WEATHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_gods_wrath,
					_str_card_description : "EXHAUSTS. Global. Activate an effect based on the current Cerulean Weather. Rain: Heal all allied Beasts for 8 HP. Snow: Grant 15 Armor to all allies. Storming: Deal 8 NEU dmg to all enemy Beasts. No Cerulean Weather: Grant 1 Divine Protection and summon 1 random Cerulean Minion on the caster."
				};
			break;
			#endregion

			#region CHILLING_WEAKNESS
			case "CHILLING_WEAKNESS":
				_stct_return_card = {
					_str_card_name : "CHILLING WEAKNESS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_chilling_weakness,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 25,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_chilling_weakness,
					_str_card_description : "ST. Ranged. Apply WEAKNESS for 3 rounds."
				};
			break;
			#endregion

			#region CHILLING_WORD
			case "CHILLING_WORD":
				_stct_return_card = {
					_str_card_name : "CHILLING WORD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_chilling_word,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DOT",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 1,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_chilling_word,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Apply 1 Frostburn to each enemy Beast."
				};
			break;
			#endregion

			#region COLD_RESERVE
			case "COLD_RESERVE":
				_stct_return_card = {
					_str_card_name : "COLD RESERVE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_cold_reserve,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 10,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_cold_reserve,
					_str_card_description : "EXHAUSTS. ST. Self. Consume up to 10 Armor. Heal the caster for 1 HP per Armor consumed."
				};
			break;
			#endregion

			#region COLD_SNAP
			case "COLD_SNAP":
				_stct_return_card = {
					_str_card_name : "COLD SNAP",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_cold_snap,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_cold_snap,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [Linear] MAG dmg (base 7). If the target has Frostbite, Freeze it."
				};
			break;
			#endregion

			#region COOLING_MIST
			case "COOLING_MIST":
				_stct_return_card = {
					_str_card_name : "COOLING MIST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_cooling_mist,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 15,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_cooling_mist,
					_str_card_description : "ST. Ranged. Heal the target allied Beast for 15 HP. Cleanse its oldest DoT."
				};
			break;
			#endregion

			#region CORAL_GUARDIAN
			case "CORAL_GUARDIAN":
				_stct_return_card = {
					_str_card_name : "CORAL GUARDIAN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_coral_guardian,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_coral_guardian,
					_str_card_description : "ST. Self. Summon a Coral Guardian (4/1). Each round, its host gains 2 Armor per Magnitude."
				};
			break;
			#endregion

			#region CRASHING_WAVE
			case "CRASHING_WAVE":
				_stct_return_card = {
					_str_card_name : "CRASHING WAVE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_crashing_wave,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_crashing_wave,
					_str_card_description : "AoE-3. Deal [Linear] PHY dmg to the target and adjacent Beasts (base 7)."
				};
			break;
			#endregion

			#region CRYOGENIC_RECOVERY
			case "CRYOGENIC_RECOVERY":
				_stct_return_card = {
					_str_card_name : "CRYOGENIC RECOVERY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_cryogenic_recovery,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 15,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_cryogenic_recovery,
					_str_card_description : "ST. Ranged. Heal the target allied Beast for 15 HP. Cleanse 1 CC."
				};
			break;
			#endregion

			#region CRYSTAL_SHELL
			case "CRYSTAL_SHELL":
				_stct_return_card = {
					_str_card_name : "CRYSTAL SHELL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_crystal_shell,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_crystal_shell,
					_str_card_description : "EXHAUSTS. ST. Ranged. Target allied Beast gains 2 Divine Protection. Block the next 2 Attacks."
				};
			break;
			#endregion

			#region DEEP_CURRENT
			case "DEEP_CURRENT":
				_stct_return_card = {
					_str_card_name : "DEEP CURRENT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_deep_current,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_deep_current,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg. Draw 1 card. If the target has Stormstruck, gather all Stormstruck stacks from adjacent Beasts onto the target."
				};
			break;
			#endregion

			#region DEEP_MOMENTUM
			case "DEEP_MOMENTUM":
				_stct_return_card = {
					_str_card_name : "DEEP MOMENTUM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_deep_momentum,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_deep_momentum,
					_str_card_description : "EXHAUSTS. ST. Ranged. For 2 rounds, whenever the target allied Beast Attacks, generate 1 Mana."
				};
			break;
			#endregion

			#region DEEP_REFLECTION
			case "DEEP_REFLECTION":
				_stct_return_card = {
					_str_card_name : "DEEP REFLECTION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_deep_reflection,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_DRAW",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_deep_reflection,
					_str_card_description : "EXHAUSTS. Global. Draw 2 cards, then discard 1 card."
				};
			break;
			#endregion

			#region DEEPFLOW_WHISPERSONG
			case "DEEPFLOW_WHISPERSONG":
				_stct_return_card = {
					_str_card_name : "DEEPFLOW WHISPERSONG",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_deepflow_whispersong,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 5,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_deepflow_whispersong,
					_str_card_description : "EXHAUSTS. Teamwide. Randomly summon 5 Tentacles across the selected team's empty Minion slots. If a selected Beast has full Minion slots, instead give one of its Tentacles +1 HP and +1 Magnitude. TENTACLE: 3 HP. 1 Magnitude. Each round, deals 1 NEU dmg per Magnitude to a random enemy Beast."
				};
			break;
			#endregion

			#region DENSE_FOG
			case "DENSE_FOG":
				_stct_return_card = {
					_str_card_name : "DENSE FOG",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_dense_fog,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_dense_fog,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Blind every Beast on the selected team."
				};
			break;
			#endregion

			#region DEPTH_CHARGE
			case "DEPTH_CHARGE":
				_stct_return_card = {
					_str_card_name : "DEPTH CHARGE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_depth_charge,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_depth_charge,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 8). Deal 25% additional dmg if Cerulean Weather is active."
				};
			break;
			#endregion

			#region DROP_ANCHOR
			case "DROP_ANCHOR":
				_stct_return_card = {
					_str_card_name : "DROP ANCHOR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_drop_anchor,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "TEAM",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "SAILOR",
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_drop_anchor,
					_str_card_description : "EXHAUSTS. Teamwide. All allied Beasts gain Immovable for 2 rounds."
				};
			break;
			#endregion

			#region FORCED_OVERLOAD
			case "FORCED_OVERLOAD":
				_stct_return_card = {
					_str_card_name : "FORCED OVERLOAD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_forced_overload,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_forced_overload,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 8). If the target has at least 4 Stormstruck, force a weak overload: remove half its Stormstruck, then apply half the removed amount to each adjacent Beast (minimum 1)."
				};
			break;
			#endregion

			#region FRACTURE
			case "FRACTURE":
				_stct_return_card = {
					_str_card_name : "FRACTURE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_fracture,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_fracture,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Deal [Linear] MAG dmg to each enemy Beast (base 8). SHATTER each target. Apply 1 Bleed to each target. Begin Snow Weather."
				};
			break;
			#endregion

			#region FROST_WEAPON
			case "FROST_WEAPON":
				_stct_return_card = {
					_str_card_name : "FROST WEAPON",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frost_weapon,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_frost_weapon,
					_str_card_description : "ST. Self. For 2 rounds, the caster's Attacks apply 1 Frostbite."
				};
			break;
			#endregion

			#region FROSTBOLT
			case "FROSTBOLT":
				_stct_return_card = {
					_str_card_name : "FROSTBOLT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frostbolt,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_frostbolt,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 6). Apply 1 Frostbite."
				};
			break;
			#endregion

			#region FROSTBURN_NOVA
			case "FROSTBURN_NOVA":
				_stct_return_card = {
					_str_card_name : "FROSTBURN NOVA",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frostburn_nova,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DOT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 8,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_frostburn_nova,
					_str_card_description : "EXHAUSTS. AoE-3. Ranged. Apply 1 Frostburn to up to 3 selected enemies. Frozen targets gain 1 additional Frostburn."
				};
			break;
			#endregion

			#region FROSTFORM
			case "FROSTFORM":
				_stct_return_card = {
					_str_card_name : "FROSTFORM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frostform,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "AURA",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_frostform,
					_str_card_description : "ST. Self. Aura. This Beast is considered Frozen but can still act. (+) Deal 50% increased damage and Attacks apply 1 Frostburn. (-) Take 50% increased damage and gain 1 Frostbite each round. ICEBREAKER triggers against this Beast."
				};
			break;
			#endregion

			#region FROZEN_ARMOR
			case "FROZEN_ARMOR":
				_stct_return_card = {
					_str_card_name : "FROZEN ARMOR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frozen_armor,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_frozen_armor,
					_str_card_description : "ST. Self. For 3 rounds, when the caster is struck, apply 1 Frostbite to the attacker."
				};
			break;
			#endregion

			#region FROZEN_BASTION
			case "FROZEN_BASTION":
				_stct_return_card = {
					_str_card_name : "FROZEN BASTION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frozen_bastion,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_frozen_bastion,
					_str_card_description : "ST. Self. Double current Armor."
				};
			break;
			#endregion

			#region FROZEN_BULWARK
			case "FROZEN_BULWARK":
				_stct_return_card = {
					_str_card_name : "FROZEN BULWARK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frozen_bulwark,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 10,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_frozen_bulwark,
					_str_card_description : "ST. Ranged. Target allied Beast gains 10 Armor."
				};
			break;
			#endregion

			#region FROZEN_CURSE
			case "FROZEN_CURSE":
				_stct_return_card = {
					_str_card_name : "FROZEN CURSE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frozen_curse,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_frozen_curse,
					_str_card_description : "ST. Ranged. For 3 rounds, whenever this Beast is attacked while Frostbitten, Frostburned, or Frozen, take 5 additional [Linear] NEU damage."
				};
			break;
			#endregion

			#region FROZEN_FANG
			case "FROZEN_FANG":
				_stct_return_card = {
					_str_card_name : "FROZEN FANG",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frozen_fang,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_frozen_fang,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 6). Apply 1 Frostbite."
				};
			break;
			#endregion

			#region FROZEN_PRECISION
			case "FROZEN_PRECISION":
				_stct_return_card = {
					_str_card_name : "FROZEN PRECISION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frozen_precision,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_frozen_precision,
					_str_card_description : "ST. Self. Ignore Dodge for 2 rounds."
				};
			break;
			#endregion

			#region FROZEN_SPEAR
			case "FROZEN_SPEAR":
				_stct_return_card = {
					_str_card_name : "FROZEN SPEAR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_frozen_spear,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "BACK",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 2,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_frozen_spear,
					_str_card_description : "ST. Flank. Deal [Linear] PHY dmg (base 2)."
				};
			break;
			#endregion

			#region GATHERING_STORM
			case "GATHERING_STORM":
				_stct_return_card = {
					_str_card_name : "GATHERING STORM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_gathering_storm,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "OTHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_gathering_storm,
					_str_card_description : "EXHAUSTS. ST. Ranged. Gather all Stormstruck from the target's teammates onto the target. Then trigger DISCHARGE if the target reaches its threshold."
				};
			break;
			#endregion

			#region GLACIAL_CRUSH
			case "GLACIAL_CRUSH":
				_stct_return_card = {
					_str_card_name : "GLACIAL CRUSH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_glacial_crush,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 12,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_glacial_crush,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] PHY dmg (base 12)."
				};
			break;
			#endregion

			#region GLACIAL_ERUPTION
			case "GLACIAL_ERUPTION":
				_stct_return_card = {
					_str_card_name : "GLACIAL ERUPTION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_glacial_eruption,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 9,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_glacial_eruption,
					_str_card_description : "EXHAUSTS. AoE-3. Ranged. Deal [Linear] MAG dmg to up to 3 selected enemies (base 9). Freeze the center target."
				};
			break;
			#endregion

			#region HAILSTONES
			case "HAILSTONES":
				_stct_return_card = {
					_str_card_name : "HAILSTONES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_hailstones,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_hailstones,
					_str_card_description : "AoE-3. Ranged. Deal [Linear] MAG dmg to the target and adjacent Beasts (base 4)."
				};
			break;
			#endregion

			#region HYPOTHERMIA
			case "HYPOTHERMIA":
				_stct_return_card = {
					_str_card_name : "HYPOTHERMIA",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_hypothermia,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_hypothermia,
					_str_card_description : "EXHAUSTS. ST. Ranged. Apply ANTIHEAL for 2 rounds."
				};
			break;
			#endregion

			#region ICE_ACCRETION
			case "ICE_ACCRETION":
				_stct_return_card = {
					_str_card_name : "ICE ACCRETION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_ice_accretion,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_ice_accretion,
					_str_card_description : "ST. Ranged. Target allied Beast gains 5 Armor at the end of each round for 3 rounds."
				};
			break;
			#endregion

			#region ICE_AGE
			case "ICE_AGE":
				_stct_return_card = {
					_str_card_name : "ICE AGE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_ice_age,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_ice_age,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Freeze every Beast. Apply 2 Frostburn to each enemy Beast."
				};
			break;
			#endregion

			#region ICE_LANCE
			case "ICE_LANCE":
				_stct_return_card = {
					_str_card_name : "ICE LANCE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_ice_lance,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_ice_lance,
					_str_card_description : "ST. Ranged. Pierce Armor and deal [Linear] MAG dmg directly to Overhealth and HP (base 4)."
				};
			break;
			#endregion

			#region ICE_MIRROR
			case "ICE_MIRROR":
				_stct_return_card = {
					_str_card_name : "ICE MIRROR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_ice_mirror,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_ice_mirror,
					_str_card_description : "ST. Self. For 3 rounds, when the caster is struck, gain 2 Armor."
				};
			break;
			#endregion

			#region ICE_PLATING
			case "ICE_PLATING":
				_stct_return_card = {
					_str_card_name : "ICE PLATING",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_ice_plating,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 12,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_ice_plating,
					_str_card_description : "ST. Self. Gain 12 Armor."
				};
			break;
			#endregion

			#region ICE_PRISON
			case "ICE_PRISON":
				_stct_return_card = {
					_str_card_name : "ICE PRISON",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_ice_prison,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_ice_prison,
					_str_card_description : "ST. Ranged. Freeze the target."
				};
			break;
			#endregion

			#region ICE_WALL
			case "ICE_WALL":
				_stct_return_card = {
					_str_card_name : "ICE WALL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_ice_wall,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_ice_wall,
					_str_card_description : "ST. Self. Summon an Ice Wall (10/0)."
				};
			break;
			#endregion

			#region ICEBOUND_INSTINCT
			case "ICEBOUND_INSTINCT":
				_stct_return_card = {
					_str_card_name : "ICEBOUND INSTINCT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_icebound_instinct,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_icebound_instinct,
					_str_card_description : "EXHAUSTS. ST. Self. For 4 rounds, CC applied by the caster lasts 1 additional round."
				};
			break;
			#endregion

			#region ICEBOUND_SEAL
			case "ICEBOUND_SEAL":
				_stct_return_card = {
					_str_card_name : "ICEBOUND SEAL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_icebound_seal,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "OTHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_icebound_seal,
					_str_card_description : "ST. Ranged. Transfer the caster's oldest Buff, including all stacks, to the target Beast."
				};
			break;
			#endregion

			#region KRAKEN_AWAKENS
			case "KRAKEN_AWAKENS":
				_stct_return_card = {
					_str_card_name : "KRAKEN AWAKENS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_kraken_awakens,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 15,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_kraken_awakens,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [Linear] PHY dmg (base 15). Apply 2 Bleed and 2 Stormstruck."
				};
			break;
			#endregion

			#region KRAKENS_CHOSEN
			case "KRAKENS_CHOSEN":
				_stct_return_card = {
					_str_card_name : "KRAKENS CHOSEN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_krakens_chosen,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "AURA",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_krakens_chosen,
					_str_card_description : "ST. Ranged. Aura. (+) The target is immune to CC, summons a Tentacle each round, applies 2 Stormstruck with its Attacks, and its Attacks deal additional NEU damage to adjacent enemies. (-) The target loses 10% of its Maximum HP each round and gains WITHER each round."
				};
			break;
			#endregion

			#region KRAKENSLAM
			case "KRAKENSLAM":
				_stct_return_card = {
					_str_card_name : "KRAKENSLAM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_krakenslam,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 15,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_krakenslam,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [Linear] PHY dmg (base 15). Apply Bleed and Stormstruck."
				};
			break;
			#endregion

			#region LEVIATHANS_BLESSING
			case "LEVIATHANS_BLESSING":
				_stct_return_card = {
					_str_card_name : "LEVIATHAN'S BLESSING",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_leviathans_blessing,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_leviathans_blessing,
					_str_card_description : "EXHAUSTS. ST. Ranged. Transform the target allied Beast into Abyssal Form for 5 rounds. Increase all stats by 40 and fill its available Minion slots with Tentacles. Whenever it Attacks, randomly either Stun the target for 1 round, Banish the target for 1 round, or apply Stormstruck."
				};
			break;
			#endregion

			#region LURKING_VISIONS
			case "LURKING_VISIONS":
				_stct_return_card = {
					_str_card_name : "LURKING VISIONS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_lurking_visions,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_lurking_visions,
					_str_card_description : "ST. Ranged. Apply Focus for 3 rounds. Summon 1 random Cerulean Minion on the caster."
				};
			break;
			#endregion

			#region MANA_SPRING
			case "MANA_SPRING":
				_stct_return_card = {
					_str_card_name : "MANA SPRING",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_mana_spring,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "MANA",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_mana_spring,
					_str_card_description : "EXHAUSTS. Global. Gain +2 maximum and current Mana for 3 rounds."
				};
			break;
			#endregion

			#region MARINE_MEND
			case "MARINE_MEND":
				_stct_return_card = {
					_str_card_name : "MARINE MEND",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_marine_mend,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CLEANSE",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_marine_mend,
					_str_card_description : "ST. Ranged. Cleanse all Auras from the target."
				};
			break;
			#endregion

			#region OCEANS_BLESSING
			case "OCEANS_BLESSING":
				_stct_return_card = {
					_str_card_name : "OCEAN'S BLESSING",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_oceans_blessing,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 15,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : "PRIEST",
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_oceans_blessing,
					_str_card_description : "EXHAUSTS. Teamwide. Heal all allied Beasts for 15 HP."
				};
			break;
			#endregion

			#region OCEANS_EMBRACE
			case "OCEANS_EMBRACE":
				_stct_return_card = {
					_str_card_name : "OCEAN'S EMBRACE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_oceans_embrace,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 50,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_oceans_embrace,
					_str_card_description : "EXHAUSTS. Teamwide. Heal all allied Beasts for 50% of their Maximum HP. Remove all DoTs and Debuffs from them."
				};
			break;
			#endregion

			#region PERMAFROST
			case "PERMAFROST":
				_stct_return_card = {
					_str_card_name : "PERMAFROST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_permafrost,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 50,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_permafrost,
					_str_card_description : "EXHAUSTS. ST. Ranged. Apply ARMORBREAK for 3 rounds."
				};
			break;
			#endregion

			#region PRESSURE_CRUSH
			case "PRESSURE_CRUSH":
				_stct_return_card = {
					_str_card_name : "PRESSURE CRUSH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_pressure_crush,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 20,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_pressure_crush,
					_str_card_description : "ST. Ranged. Pierce Armor and deal PHY dmg equal to 20% of the target's current Armor directly to Overhealth and HP."
				};
			break;
			#endregion

			#region PRESSURE_SPIKE
			case "PRESSURE_SPIKE":
				_stct_return_card = {
					_str_card_name : "PRESSURE SPIKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_pressure_spike,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_pressure_spike,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 8). Deal 25% additional dmg if the target has no Armor."
				};
			break;
			#endregion

			#region PULLED_UNDER
			case "PULLED_UNDER":
				_stct_return_card = {
					_str_card_name : "PULLED UNDER",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_pulled_under,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_pulled_under,
					_str_card_description : "EXHAUSTS. Teamwide. Set a Trap on the selected enemy team. The next Beast on that team that receives healing is Banished for 1 round."
				};
			break;
			#endregion

			#region PURIFY_WATERS
			case "PURIFY_WATERS":
				_stct_return_card = {
					_str_card_name : "PURIFY WATERS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_purify_waters,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "OTHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_purify_waters,
					_str_card_description : "ST. Ranged. Transfer the caster's oldest DoT, including all stacks, to the target Beast."
				};
			break;
			#endregion

			#region RAIN
			case "RAIN":
				_stct_return_card = {
					_str_card_name : "RAIN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_rain,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "WEATHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_rain,
					_str_card_description : "EXHAUSTS. Global. Begin Rain Weather."
				};
			break;
			#endregion

			#region RAZOR_FIN
			case "RAZOR_FIN":
				_stct_return_card = {
					_str_card_name : "RAZOR FIN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_razor_fin,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_razor_fin,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 7). Apply 1 Bleed."
				};
			break;
			#endregion

			#region RAZOR_SHELL
			case "RAZOR_SHELL":
				_stct_return_card = {
					_str_card_name : "RAZOR SHELL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_razor_shell,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 3,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_razor_shell,
					_str_card_description : "ST. Self. For 3 rounds, when the caster is struck, deal 3 NEU dmg to the attacker."
				};
			break;
			#endregion

			#region RIP_CURRENT
			case "RIP_CURRENT":
				_stct_return_card = {
					_str_card_name : "RIP CURRENT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_rip_current,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "REPOSITION",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_rip_current,
					_str_card_description : "ST. Ranged. Move the target Beast backward 1 position, swapping positions with the Beast behind it."
				};
			break;
			#endregion

			#region RIPPLING_POOL
			case "RIPPLING_POOL":
				_stct_return_card = {
					_str_card_name : "RIPPLING POOL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_rippling_pool,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_DRAW",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_rippling_pool,
					_str_card_description : "EXHAUSTS. Global. Draw 2 cards."
				};
			break;
			#endregion

			#region ROUGH_SEAS
			case "ROUGH_SEAS":
				_stct_return_card = {
					_str_card_name : "ROUGH SEAS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_rough_seas,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "AURA",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_rough_seas,
					_str_card_description : "Teamwide. Ranged. Aura. (+) Whenever an enemy Beast takes damage, randomly move it forward or backward 1 position. (-) Allied Beasts take 10% increased damage."
				};
			break;
			#endregion

			#region SAILORS_RESOLVE
			case "SAILORS_RESOLVE":
				_stct_return_card = {
					_str_card_name : "SAILOR'S RESOLVE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_sailors_resolve,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 33,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_sailors_resolve,
					_str_card_description : "ST. Ranged. Increase the target allied Beast's healing received by 33% for 3 rounds."
				};
			break;
			#endregion

			#region RIMEFROST_ELEMENTAL
			case "RIMEFROST_ELEMENTAL":
				_stct_return_card = {
					_str_card_name : "RIMEFROST ELEMENTAL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_rimefrost_elemental,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_rimefrost_elemental,
					_str_card_description : "EXHAUSTS. ST. Ranged. Summon a Rimefrost Elemental (2/1). Each round, it applies 1 Frostbite per Magnitude to a random enemy Beast."
				};
			break;
			#endregion

			#region SEA_LEGS
			case "SEA_LEGS":
				_stct_return_card = {
					_str_card_name : "SEA LEGS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_sea_legs,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_sea_legs,
					_str_card_description : "ST. Self. Gain Immovable for 2 rounds."
				};
			break;
			#endregion

			#region SHARED_BULWARK
			case "SHARED_BULWARK":
				_stct_return_card = {
					_str_card_name : "SHARED BULWARK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_shared_bulwark,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "TEAM",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_shared_bulwark,
					_str_card_description : "Teamwide. Redistribute the caster's current Armor evenly among all allied Beasts."
				};
			break;
			#endregion

			#region SHATTER_STRIKE
			case "SHATTER_STRIKE":
				_stct_return_card = {
					_str_card_name : "SHATTER STRIKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_shatter_strike,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_shatter_strike,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 8). SHATTER the target."
				};
			break;
			#endregion

			#region SHATTERSTORM
			case "SHATTERSTORM":
				_stct_return_card = {
					_str_card_name : "SHATTERSTORM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_shatterstorm,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_shatterstorm,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Deal [Linear] PHY dmg to each enemy Beast (base 8). SHATTER each target, then apply 1 Bleed to each."
				};
			break;
			#endregion

			#region SHELL_SHIELD
			case "SHELL_SHIELD":
				_stct_return_card = {
					_str_card_name : "SHELL SHIELD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_shell_shield,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 6,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_shell_shield,
					_str_card_description : "ST. Self. Gain 6 Armor."
				};
			break;
			#endregion

			#region SNOWDRIFT
			case "SNOWDRIFT":
				_stct_return_card = {
					_str_card_name : "SNOWDRIFT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_snowdrift,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 4,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_snowdrift,
					_str_card_description : "ST. Self. Gain 4 Armor at the end of each round for 3 rounds."
				};
			break;
			#endregion

			#region SNOWFALL
			case "SNOWFALL":
				_stct_return_card = {
					_str_card_name : "SNOWFALL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_snowfall,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "WEATHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_snowfall,
					_str_card_description : "EXHAUSTS. Global. Begin Snow Weather."
				};
			break;
			#endregion

			#region SNOWFORT
			case "SNOWFORT":
				_stct_return_card = {
					_str_card_name : "SNOWFORT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_snowfort,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "TEAM",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 6,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_snowfort,
					_str_card_description : "Teamwide. All allied Beasts gain 6 Armor."
				};
			break;
			#endregion

			#region SOOTHING_CURRENT
			case "SOOTHING_CURRENT":
				_stct_return_card = {
					_str_card_name : "SOOTHING CURRENT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_soothing_current,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 12,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_soothing_current,
					_str_card_description : "ST. Self. Heal the caster for 12 HP."
				};
			break;
			#endregion

			#region STATIC_BARRIER
			case "STATIC_BARRIER":
				_stct_return_card = {
					_str_card_name : "STATIC BARRIER",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_static_barrier,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_static_barrier,
					_str_card_description : "ST. Self. For 3 rounds, when the caster is struck, apply 1 Stormstruck to the attacker."
				};
			break;
			#endregion

			#region STATIC_RESONANCE
			case "STATIC_RESONANCE":
				_stct_return_card = {
					_str_card_name : "STATIC RESONANCE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_static_resonance,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_static_resonance,
					_str_card_description : "ST. Ranged. Apply Static Resonance for 3 rounds. Whenever the target is repositioned, apply 1 Stormstruck to it."
				};
			break;
			#endregion

			#region STORM_BEACON
			case "STORM_BEACON":
				_stct_return_card = {
					_str_card_name : "STORM BEACON",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_storm_beacon,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_storm_beacon,
					_str_card_description : "EXHAUSTS. ST. Ranged. Set a Trap on an enemy Beast. The next time that Beast casts a card, apply 3 Stormstruck to it."
				};
			break;
			#endregion

			#region STORM_WISP
			case "STORM_WISP":
				_stct_return_card = {
					_str_card_name : "STORM WISP",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_storm_wisp,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_storm_wisp,
					_str_card_description : "ST. Ranged. Summon a Storm Wisp (2/1). Each round, it deals 3 NEU dmg per Magnitude to a random enemy Beast, then applies 1 Stormstruck to the enemy with the highest existing Stormstruck."
				};
			break;
			#endregion

			#region THE_ABYSS_STARES_BACK
			case "THE_ABYSS_STARES_BACK":
				_stct_return_card = {
					_str_card_name : "THE ABYSS STARES BACK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_the_abyss_stares_back,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_the_abyss_stares_back,
					_str_card_description : "EXHAUSTS. Global. Every Beast gains 1 random Cerulean Buff, 1 random Cerulean Debuff, and 1 random Cerulean Minion. Apply 1 random CC to a random allied Beast and a random enemy Beast."
				};
			break;
			#endregion

			#region THIN_ICE
			case "THIN_ICE":
				_stct_return_card = {
					_str_card_name : "THIN ICE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_thin_ice,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_thin_ice,
					_str_card_description : "EXHAUSTS. ST. Ranged. Set a Trap on an enemy Beast. The next time that Beast Attacks, apply 2 Frostbite to it."
				};
			break;
			#endregion

			#region THUNDERCLAP
			case "THUNDERCLAP":
				_stct_return_card = {
					_str_card_name : "THUNDERCLAP",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_thunderclap,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_thunderclap,
					_str_card_description : "AoE-3. Ranged. Deal [Linear] MAG dmg to up to 3 selected Beasts (base 4). Then immediately trigger each struck Beast's normal Stormstruck action reaction as though it had acted."
				};
			break;
			#endregion

			#region THUNDERSTORM
			case "THUNDERSTORM":
				_stct_return_card = {
					_str_card_name : "THUNDERSTORM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_thunderstorm,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "WEATHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "SAILOR",
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_thunderstorm,
					_str_card_description : "EXHAUSTS. Global. Begin Storming Weather."
				};
			break;
			#endregion

			#region TIDAL_BREAK
			case "TIDAL_BREAK":
				_stct_return_card = {
					_str_card_name : "TIDAL BREAK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_tidal_break,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 9,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "SAILOR",
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_tidal_break,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] PHY dmg (base 9). If this attack breaks Armor, apply 2 Stormstruck."
				};
			break;
			#endregion

			#region TIDAL_FLOW
			case "TIDAL_FLOW":
				_stct_return_card = {
					_str_card_name : "TIDAL FLOW",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_tidal_flow,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "MANA",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_tidal_flow,
					_str_card_description : "EXHAUSTS. Global. Gain 1 Mana. Draw 1 card."
				};
			break;
			#endregion

			#region TIDAL_RECOVERY
			case "TIDAL_RECOVERY":
				_stct_return_card = {
					_str_card_name : "TIDAL RECOVERY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_tidal_recovery,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 10,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_tidal_recovery,
					_str_card_description : "ST. Ranged. Apply Regeneration for 3 rounds. Heal the target for 10 HP each round."
				};
			break;
			#endregion

			#region TIDAL_SLASH
			case "TIDAL_SLASH":
				_stct_return_card = {
					_str_card_name : "TIDAL SLASH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_tidal_slash,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_tidal_slash,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 6). If Rain is active, deal 5 additional dmg."
				};
			break;
			#endregion

			#region TIDEHEART
			case "TIDEHEART":
				_stct_return_card = {
					_str_card_name : "TIDEHEART",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_tideheart,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "ECHO",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_tideheart,
					_str_card_description : "EXHAUSTS. Global. Cleanse all negative statuses on caster. Add 1 to echo counter."
				};
			break;
			#endregion

			#region TORRENT
			case "TORRENT":
				_stct_return_card = {
					_str_card_name : "TORRENT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_torrent,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "BACK",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_torrent,
					_str_card_description : "ST. Flank. Deal [Linear] MAG dmg (base 6)."
				};
			break;
			#endregion

			#region UNDERTOW
			case "UNDERTOW":
				_stct_return_card = {
					_str_card_name : "UNDERTOW",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_undertow,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "REPOSITION",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_undertow,
					_str_card_description : "ST. Ranged. Move the target Beast forward 1 position, swapping positions with the Beast ahead of it."
				};
			break;
			#endregion

			#region UNSTABLE_COIL
			case "UNSTABLE_COIL":
				_stct_return_card = {
					_str_card_name : "UNSTABLE COIL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_unstable_coil,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_unstable_coil,
					_str_card_description : "ST. Ranged. Apply Unstable Coil for 3 rounds. When the target triggers DISCHARGE, apply the discharged Stormstruck to every other allied Beast instead of only adjacent Beasts."
				};
			break;
			#endregion

			#region WHIRLPOOL
			case "WHIRLPOOL":
				_stct_return_card = {
					_str_card_name : "WHIRLPOOL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_whirlpool,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_whirlpool,
					_str_card_description : "ST. Ranged. Banish the target for 1 round."
				};
			break;
			#endregion


			#region WHITEOUT
			case "WHITEOUT":
				_stct_return_card = {
					_str_card_name : "WHITEOUT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_whiteout,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 33,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_whiteout,
					_str_card_description : "ST. Ranged. Target has a 33% chance to whiff card casts, making the cast fail. Lasts 3 rounds."
				};
			break;
			#endregion

			#region WHITEWATER
			case "WHITEWATER":
				_stct_return_card = {
					_str_card_name : "WHITEWATER",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_whitewater,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "REPOSITION",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "SAILOR",
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_whitewater,
					_str_card_description : "ST. Ranged. Deal [Linear] PHY dmg (base 8). Move the target forward 1 position."
				};
			break;
			#endregion

			#region WINTER_RESONANCE
			case "WINTER_RESONANCE":
				_stct_return_card = {
					_str_card_name : "WINTER RESONANCE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_winter_resonance,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "SHATTER",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_cerulean_winter_resonance,
					_str_card_description : "ST. Ranged. SHATTER the target."
				};
			break;
			#endregion

			#region WINTERS_BITE
			case "WINTERS_BITE":
				_stct_return_card = {
					_str_card_name : "WINTER'S BITE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_winters_bite,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 10,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_winters_bite,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] PHY dmg (base 10). ICEBREAKER."
				};
			break;
			#endregion

			#region WINTERS_HOUR
			case "WINTERS_HOUR":
				_stct_return_card = {
					_str_card_name : "WINTER'S HOUR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_cerulean_winters_hour,
					_arr_card_colors : ["CERULEAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "WEATHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 15,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_cerulean_winters_hour,
					_str_card_description : "EXHAUSTS. Teamwide. Begin Snow Weather. Heal all allied Beasts and apply 1 Frostbite to each enemy Beast."
				};
			break;
			#endregion

		#endregion

		#region VIRIDIAN
			#region ANCIENT_GROVE
			case "ANCIENT_GROVE":
				_stct_return_card = {
					_str_card_name : "ANCIENT GROVE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_ancient_grove,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : "SUMMONER",
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_ancient_grove,
					_str_card_description : "EXHAUSTS. Teamwide. Summon a Grove Spirit (5/1) on each allied Beast. Each Grove Spirit heals its host for 3 HP per round. Whenever its host gains Armor, the Grove Spirit gains 1 Magnitude and 2 maximum HP. At 10 HP, it also deals 1 NEU dmg per Magnitude to the front enemy each round. At 20 HP, its attacks also Stun for 1 round."
				};
			break;
			#endregion

			#region APEX_PREDATOR
			case "APEX_PREDATOR":
				_stct_return_card = {
					_str_card_name : "APEX PREDATOR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_apex_predator,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "CLEANSE",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_apex_predator,
					_str_card_description : "EXHAUSTS. ST. Self. Remove all DoTs, Debuffs, and CC from all allied Beasts. For each stack removed, permanently increase the caster’s linear damage by 2 and heal the caster for 2 HP."
				};
			break;
			#endregion

			#region BARKSKIN
			case "BARKSKIN":
				_stct_return_card = {
					_str_card_name : "BARKSKIN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_barkskin,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 10,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_barkskin,
					_str_card_description : "ST. Self. Gain 10 Armor."
				};
			break;
			#endregion

			#region BEASTIAL_WRATH
			case "BEASTIAL_WRATH":
				_stct_return_card = {
					_str_card_name : "BEASTIAL WRATH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_beastial_wrath,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "FRONT2",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_beastial_wrath,
					_str_card_description : "AoE-2. Melee. Deal [Linear] PHY dmg to the front target and the Beast behind it (base 6). Stun the front target for 1 round."
				};
			break;
			#endregion

			#region BIOBOLT
			case "BIOBOLT":
				_stct_return_card = {
					_str_card_name : "BIOBOLT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_biobolt,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_biobolt,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 4)."
				};
			break;
			#endregion

			#region BIOSTORM
			case "BIOSTORM":
				_stct_return_card = {
					_str_card_name : "BIOSTORM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_biostorm,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 10,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_biostorm,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Deal [%] MAG dmg (base 10% of each target’s maximum HP)."
				};
			break;
			#endregion

			#region BLOOMING_SHIELD
			case "BLOOMING_SHIELD":
				_stct_return_card = {
					_str_card_name : "BLOOMING SHIELD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_blooming_shield,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_blooming_shield,
					_str_card_description : "ST. Ranged. Target gains 7 Armor."
				};
			break;
			#endregion

			#region BLOOMING_SPRITE
			case "BLOOMING_SPRITE":
				_stct_return_card = {
					_str_card_name : "BLOOMING SPRITE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_blooming_sprite,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : undefined,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_blooming_sprite,
					_str_card_description : "ST. Ranged. Summon a Blooming Sprite (2/1). While alive, its host gains +2 linear damage per Magnitude."
				};
			break;
			#endregion

			#region BLOOMTIDE
			case "BLOOMTIDE":
				_stct_return_card = {
					_str_card_name : "BLOOMTIDE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_bloomtide,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "EVENT",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : undefined,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_bloomtide,
					_str_card_description : "EXHAUSTS. Global. Begin the Bloomtide Event."
				};
			break;
			#endregion

			#region BLOWDART
			case "BLOWDART":
				_stct_return_card = {
					_str_card_name : "BLOWDART",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_blowdart,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DOT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_blowdart,
					_str_card_description : "ST. Ranged. Deal 4 NEU dmg. Apply 1 Poison."
				};
			break;
			#endregion

			#region BRAMBLE_HIDE
			case "BRAMBLE_HIDE":
				_stct_return_card = {
					_str_card_name : "BRAMBLE HIDE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_bramble_hide,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_bramble_hide,
					_str_card_description : "ST. Ranged. Grant Thorns for 3 rounds. When attacked, deal 3 NEU dmg to the attacker."
				};
			break;
			#endregion

			#region BRAMBLE_ERUPTION
			case "BRAMBLE_ERUPTION":
				_stct_return_card = {
					_str_card_name : "BRAMBLE ERUPTION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_bramble_eruption,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 8,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : "MAGE",
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_bramble_eruption,
					_str_card_description : "AoE-3. Ranged. Deal [Linear] MAG dmg to up to 3 selected Beasts (base 8)."
				};
			break;
			#endregion

			#region BURGEONING_BLOOM
			case "BURGEONING_BLOOM":
				_stct_return_card = {
					_str_card_name : "BURGEONING BLOOM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_burgeoning_bloom,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "AURA",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0.25,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_burgeoning_bloom,
					_str_card_description : "Self Aura. (+) When this Beast receives a healing effect, adjacent allied Beasts heal for 25% of that effect. (-) This Beast's Maximum HP is reduced by 15%."
				};
			break;
			#endregion

			#region BURSTING_SEED
			case "BURSTING_SEED":
				_stct_return_card = {
					_str_card_name : "BURSTING SEED",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_bursting_seed,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_bursting_seed,
					_str_card_description : "ST. Ranged. Apply Armorbreak for 2 rounds and Vulnerable for 1 round. METABOLIZE 3: Consume 3 Poison. Increase the duration of both effects by 1 round."
				};
			break;
			#endregion

			#region CHANNEL_THE_SPIRITS
			case "CHANNEL_THE_SPIRITS":
				_stct_return_card = {
					_str_card_name : "CHANNEL THE SPIRITS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_channel_the_spirits,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_channel_the_spirits,
					_str_card_description : "EXHAUSTS. Global. Deal [Linear] MAG dmg 12 times to random enemy Beasts (base 6 per hit)."
				};
			break;
			#endregion

			#region CIRCLE_OF_LIFE
			case "CIRCLE_OF_LIFE":
				_stct_return_card = {
					_str_card_name : "CIRCLE OF LIFE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_circle_of_life,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "SACRIFICE",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_circle_of_life,
					_str_card_description : "EXHAUSTS. Global. Expend all corpses. For each corpse expended, generate 1 Mana, heal all allied Beasts for 5 HP, and summon a Dormant Seed (1/0) in an available allied Minion slot. If no slot is available, increase an existing allied Minion’s current HP, maximum HP, and Magnitude by 1 instead."
				};
			break;
			#endregion

			#region CLAW
			case "CLAW":
				_stct_return_card = {
					_str_card_name : "CLAW",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_claw,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_claw,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 5)."
				};
			break;
			#endregion

			#region CRIPPLING_VINES
			case "CRIPPLING_VINES":
				_stct_return_card = {
					_str_card_name : "CRIPPLING VINES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_crippling_vines,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_crippling_vines,
					_str_card_description : "ST. Ranged. Reduce the target’s PHYPOW by 20 for 3 rounds and prevent repositioning."
				};
			break;
			#endregion

			#region CULTIVATE
			case "CULTIVATE":
				_stct_return_card = {
					_str_card_name : "CULTIVATE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_cultivate,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_str_card_cast_motion : "MINION",
					_val_card_magnitude : 2,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_cultivate,
					_str_card_description : "ST. Ranged. Increase the current HP, maximum HP, and Magnitude of all Minions on the target by 2 for the remainder of battle."
				};
			break;
			#endregion

			#region CURE_ALL
			case "CURE_ALL":
				_stct_return_card = {
					_str_card_name : "CURE ALL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_cure_all,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CLEANSE",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_cure_all,
					_str_card_description : "EXHAUSTS. ST. Ranged. Remove all negative statuses from the target."
				};
			break;
			#endregion

			#region DECAYING_TOUCH
			case "DECAYING_TOUCH":
				_stct_return_card = {
					_str_card_name : "DECAYING TOUCH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_decaying_touch,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_decaying_touch,
					_str_card_description : "ST. Ranged. Apply Wither for 3 rounds. If the target is Poisoned, Wither lasts 5 rounds instead."
				};
			break;
			#endregion

			#region DISEASE
			case "DISEASE":
				_stct_return_card = {
					_str_card_name : "DISEASE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_disease,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_disease,
					_str_card_description : "ST. Ranged. Weaken the target for 3 rounds."
				};
			break;
			#endregion

			#region DISTRACTING_TRAP
			case "DISTRACTING_TRAP":
				_stct_return_card = {
					_str_card_name : "DISTRACTING TRAP",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_distracting_trap,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_distracting_trap,
					_str_card_description : "EXHAUSTS. ST. Ranged. Set a Trap on a Beast. The first Attack that targets it misses. Draw 1 card."
				};
			break;
			#endregion

			#region DORMANT_SEED
			case "DORMANT_SEED":
				_stct_return_card = {
					_str_card_name : "DORMANT SEED",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_dormant_seed,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_dormant_seed,
					_str_card_description : "ST. Ranged. Summon a Dormant Seed (1/0). After 2 rounds, it hatches into a random Viridian Minion. HP and Magnitude bonuses carry over to the hatched Minion."
				};
			break;
			#endregion

			#region DRAINING_KISS
			case "DRAINING_KISS":
				_stct_return_card = {
					_str_card_name : "DRAINING KISS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_draining_kiss,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_draining_kiss,
					_str_card_description : "ST. Ranged. Heal the caster for 5 HP. Apply Drained for 3 rounds. Drained reduces MAGPOW and MAGDEF by 20."
				};
			break;
			#endregion

			#region EMERALD_SLAM
			case "EMERALD_SLAM":
				_stct_return_card = {
					_str_card_name : "EMERALD SLAM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_emerald_slam,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_emerald_slam,
					_str_card_description : "ST. Melee. Stun the target for 1 round."
				};
			break;
			#endregion

			#region EMERALD_WISDOM
			case "EMERALD_WISDOM":
				_stct_return_card = {
					_str_card_name : "EMERALD WISDOM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_emerald_wisdom,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_emerald_wisdom,
					_str_card_description : "EXHAUSTS. Global. For the next 3 draw events, draw 2 additional cards per event."
				};
			break;
			#endregion

			#region ENDLESS_BLOOM
			case "ENDLESS_BLOOM":
				_stct_return_card = {
					_str_card_name : "ENDLESS BLOOM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_endless_bloom,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_endless_bloom,
					_str_card_description : "EXHAUSTS. Teamwide. For 5 rounds, whenever an allied Minion dies or is sacrificed, replace it with a Dormant Seed (1/0). The Dormant Seed inherits that Minion's HP and Magnitude bonuses."
				};
			break;
			#endregion

			#region PLAGUE_GARDEN
			case "PLAGUE_GARDEN":
				_stct_return_card = {
					_str_card_name : "PLAGUE GARDEN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_plague_garden,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_plague_garden,
					_str_card_description : "EXHAUSTS. Teamwide. For 5 rounds, whenever an enemy gains Bleed, Poison, or Venom, summon a Sporeling (1/1) on that Beast. If necessary, replace an existing Minion. When a Sporeling is replaced or killed, apply 1 Poison to its host."
				};
			break;
			#endregion

			#region ENTANGLE
			case "ENTANGLE":
				_stct_return_card = {
					_str_card_name : "ENTANGLE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_entangle,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_entangle,
					_str_card_description : "EXHAUSTS. ST. Ranged. Stun the target for 1 round."
				};
			break;
			#endregion

			#region FELL
			case "FELL":
				_stct_return_card = {
					_str_card_name : "FELL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_fell,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 15,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_fell,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [%] PHY dmg (base 15% of target’s maximum HP)."
				};
			break;
			#endregion

			#region FERAL_FRENZY
			case "FERAL_FRENZY":
				_stct_return_card = {
					_str_card_name : "FERAL FRENZY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_feral_frenzy,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 2,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_feral_frenzy,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg 3 times (base 2 per hit)."
				};
			break;
			#endregion

			#region FOR_THE_THROAT
			case "FOR_THE_THROAT":
				_stct_return_card = {
					_str_card_name : "FOR THE THROAT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_for_the_throat,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					// Current percent-damage API:
					// 30 = 30% of maximum HP.
					_val_card_magnitude : 30,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : "HUNTER",
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_for_the_throat,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [%] PHY dmg (base 30% of target’s maximum HP). Apply 5 Bleed. Stun the caster for 2 rounds. EXECUTE: Heal the caster for 30% of its maximum HP."
				};
			break;
			#endregion

			#region FUNGAL_RECYCLING
			case "FUNGAL_RECYCLING":
				_stct_return_card = {
					_str_card_name : "FUNGAL RECYCLING",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_fungal_recycling,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "CORPSE_OPTIONAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_MANIPULATION",
					_flag_allow_empty_corpse_target : true,
					_flag_corpse_cancel_to_card_select : true,					
					_str_card_stat : "NEU",
					_str_card_target_count : "CORPSE",
					_flag_allow_empty_corpse_target : true,
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_fungal_recycling,
					_str_card_description : "EXHAUSTS. Global. Sacrifice a corpse. Return a random exhausted Viridian card to the draw pile. If no corpse is available, the caster loses 10 HP instead."
				};
			break;
			#endregion

			#region GERMINATE
			case "GERMINATE":
				_stct_return_card = {
					_str_card_name : "GERMINATE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_germinate,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_str_card_cast_motion : "MINION",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_germinate,
					_str_card_description : "ST. Ranged. Hatch all existing Dormant Seeds on the target, then summon 2 Dormant Seeds."
				};
			break;
			#endregion

			#region GREENFLOW
			case "GREENFLOW":
				_stct_return_card = {
					_str_card_name : "GREENFLOW",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_greenflow,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : "SUMMONER",
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_greenflow,
					_str_card_description : "ST. Ranged. Deal 5 NEU dmg X times, where X equals the number of Minions controlled by the caster. EXECUTE: Cultivate all Minions on the caster by 1."
				};
			break;
			#endregion

			#region GREENSTEP
			case "GREENSTEP":
				_stct_return_card = {
					_str_card_name : "GREENSTEP",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_greenstep,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "TEAM",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "REPOSITION",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_greenstep,
					_str_card_description : "ST. Ranged. Swap the caster’s position with the target allied Beast. Heal both Beasts for 3 HP."
				};
			break;
			#endregion

			#region GROWTH_SIGIL
			case "GROWTH_SIGIL":
				_stct_return_card = {
					_str_card_name : "GROWTH SIGIL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_growth_sigil,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "WEATHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_growth_sigil,
					_str_card_description : "EXHAUSTS. Global. Begin Seedfall Weather."
				};
			break;
			#endregion

			#region HEART_OF_THE_FOREST
			case "HEART_OF_THE_FOREST":
				_stct_return_card = {
					_str_card_name : "HEART OF THE FOREST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_heart_of_the_forest,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_heart_of_the_forest,
					_str_card_description : "EXHAUSTS. Teamwide. For 5 rounds, whenever an allied Beast receives healing, it gains an equal amount of Armor and each Minion hosted by that Beast gains +1 maximum HP."
				};
			break;
			#endregion

			#region HONEYED_SCENT
			case "HONEYED_SCENT":
				_stct_return_card = {
					_str_card_name : "HONEYED SCENT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_honeyed_scent,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "AURA",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 10,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_honeyed_scent,
					_str_card_description : "Global. Teamwide Aura. (+) Whenever an allied Beast casts an Attack card, summon a Wasp Drone (2/1) on that Beast. Each Wasp Drone deals 1 NEU dmg per Magnitude to a random enemy each round and applies Weakness for 1 round to another random enemy. (-) The caster has 0 Dodge and takes 10% more damage while this Aura is active."
				};
			break;
			#endregion

			#region HUNTERS_INSTINCT
			case "HUNTERS_INSTINCT":
				_stct_return_card = {
					_str_card_name : "HUNTER'S INSTINCT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_hunters_instinct,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : "HUNTER",
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_hunters_instinct,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 4). Deal 4 additional dmg if the target is Bleeding. EXECUTE: Gain Boost for 2 rounds."
				};
			break;
			#endregion

			#region HUNTERS_JAVELIN
			case "HUNTERS_JAVELIN":
				_stct_return_card = {
					_str_card_name : "HUNTER'S JAVELIN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_hunters_javelin,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 10,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : "HUNTER",
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_hunters_javelin,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [Linear] PHY dmg (base 10)."
				};
			break;
			#endregion

			#region INTERLOCKING_SCALES
			case "INTERLOCKING_SCALES":
				_stct_return_card = {
					_str_card_name : "INTERLOCKING SCALES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_interlocking_scales,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "PHY",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_interlocking_scales,
					_str_card_description : "ST. Self. Gain [Linear] Armor (base 3)."
				};
			break;
			#endregion

			#region LIFE_SPIRIT
			case "LIFE_SPIRIT":
				_stct_return_card = {
					_str_card_name : "LIFE SPIRIT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_life_spirit,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_life_spirit,
					_str_card_description : "ST. Ranged. Summon a Life Spirit (2/1). Each round, it heals its host for 2 HP per Magnitude."
				};
			break;
			#endregion

			#region LIFEBLOOM
			case "LIFEBLOOM":
				_stct_return_card = {
					_str_card_name : "LIFEBLOOM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_lifebloom,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_lifebloom,
					_str_card_description : "ST. Ranged. Heal [Linear] HP (base 6)."
				};
			break;
			#endregion

			#region MANAVINE
			case "MANAVINE":
				_stct_return_card = {
					_str_card_name : "MANAVINE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_manavine,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "MANA",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_manavine,
					_str_card_description : "EXHAUSTS. Global. Gain +1 maximum and current Mana for 3 rounds."
				};
			break;
			#endregion

			#region MIRACLE_MUSA
			case "MIRACLE_MUSA":
				_stct_return_card = {
					_str_card_name : "MIRACLE MUSA",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_miracle_musa,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "MAG",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_miracle_musa,
					_str_card_description : "ST. Self. Gain [Linear] Overhealth for 3 rounds (base 3). Each round, regenerate up to 1 stack's worth of this Overhealth, up to the total granted by all stacks."
				};
			break;
			#endregion

			#region NATURAL_CYCLE
			case "NATURAL_CYCLE":
				_stct_return_card = {
					_str_card_name : "NATURAL CYCLE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_natural_cycle,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "TEAM",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "OTHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_str_card_cast_motion : "MINION",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_natural_cycle,
					_str_card_description : "EXHAUSTS. ST. Ranged. Sacrifice the oldest Minion on the target allied Beast. Draw 2 cards and heal that Beast for 5 HP."
				};
			break;
			#endregion

			#region NATURAL_RECOVERY
			case "NATURAL_RECOVERY":
				_stct_return_card = {
					_str_card_name : "NATURAL RECOVERY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_natural_recovery,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_natural_recovery,
					_str_card_description : "ST. Ranged. Target gains 4 Armor, removes 1 Crowd Control or DoT, and heals for 4 HP."
				};
			break;
			#endregion

			#region NATURES_FURY
			case "NATURES_FURY":
				_stct_return_card = {
					_str_card_name : "NATURE'S FURY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_natures_fury,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 12,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_natures_fury,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] MAG dmg (base 12)."
				};
			break;
			#endregion

			#region NATURES_WRATH
			case "NATURES_WRATH":
				_stct_return_card = {
					_str_card_name : "NATURE'S WRATH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_natures_wrath,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_natures_wrath,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 4). Deal 1 additional dmg per Poison on the target. METABOLIZE 2: Consume up to 2 Poison. Heal the caster for 3 HP per Poison consumed."
				};
			break;
			#endregion

			#region NATURES_BOND
			case "NATURES_BOND":
				_stct_return_card = {
					_str_card_name : "NATURE'S BOND",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_natures_bond,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 5,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_natures_bond,
					_str_card_description : "ST. Self. Heal the caster for 5 HP. Gain Nature’s Bond for 5 rounds. Whenever the caster receives healing, gain 2 Armor per stack."
				};
			break;
			#endregion

			#region NATURES_GRACE
			case "NATURES_GRACE":
				_stct_return_card = {
					_str_card_name : "NATURE'S GRACE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_natures_grace,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 20,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_natures_grace,
					_str_card_description : "EXHAUSTS. ST. Ranged. Target gains 20 Armor."
				};
			break;
			#endregion

			#region NATURES_MEND
			case "NATURES_MEND":
				_stct_return_card = {
					_str_card_name : "NATURE'S MEND",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_natures_mend,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CLEANSE",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_natures_mend,
					_str_card_description : "ST. Ranged. Remove 1 stack from each DoT and Debuff on the target. Remove any status reduced to 0 stacks."
				};
			break;
			#endregion

			#region OLD_GROWTH_PUMMEL
			case "OLD_GROWTH_PUMMEL":
				_stct_return_card = {
					_str_card_name : "OLD GROWTH PUMMEL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_old_growth_pummel,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_old_growth_pummel,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg 3 times (base 3 per hit). Each hit deals 1 additional dmg for every 5 Armor on the caster."
				};
			break;
			#endregion

			#region OVERGROWTH
			case "OVERGROWTH":
				_stct_return_card = {
					_str_card_name : "OVERGROWTH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_overgrowth,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "PHY",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_overgrowth,
					_str_card_description : "AoE-3. Self. Gain [Linear] Armor on the caster and adjacent allied Beasts (base 4)."
				};
			break;
			#endregion

			#region PACK_INSTINCT
			case "PACK_INSTINCT":
				_stct_return_card = {
					_str_card_name : "PACK INSTINCT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_pack_instinct,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_pack_instinct,
					_str_card_description : "Global. For 4 rounds, each allied Beast gains +2 damage and +2 maximum HP for each living Minion attached to it."
				};
			break;
			#endregion

			#region PHEROMONES
			case "PHEROMONES":
				_stct_return_card = {
					_str_card_name : "PHEROMONES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_pheromones,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_pheromones,
					_str_card_description : "ST. Self. Taunt for 2 rounds. The caster is the only available target for attacks while Taunt is active."
				};
			break;
			#endregion

			#region POLLINATE
			case "POLLINATE":
				_stct_return_card = {
					_str_card_name : "POLLINATE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_pollinate,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "MAG",
					_str_card_target_count : "TARGET_BEHIND",
					_val_card_magnitude : 0.05,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_pollinate,
					_str_card_description : "AoE-2. Ranged. Apply Regeneration to the target and the allied Beast behind it for 3 rounds. Heal [Scalar] HP immediately and each round."
				};
			break;
			#endregion

			#region REJUVENATE
			case "REJUVENATE":
				_stct_return_card = {
					_str_card_name : "REJUVENATE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_rejuvenate,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_rejuvenate,
					_str_card_description : "ST. Ranged. Apply Regeneration for 3 rounds. Heal [Linear] HP at the start of each round (base 5)."
				};
			break;
			#endregion

			#region POTENT_SPORE
			case "POTENT_SPORE":
				_stct_return_card = {
					_str_card_name : "POTENT SPORE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_potent_spore,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DOT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_potent_spore,
					_str_card_description : "ST. Ranged. Apply 3 Poison."
				};
			break;
			#endregion

			#region POTENT_FRUIT
			case "POTENT_FRUIT":
				_stct_return_card = {
					_str_card_name : "POTENT FRUIT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_potent_fruit,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_potent_fruit,
					_str_card_description : "EXHAUSTS. ST. Self. Gain Boost for 2 rounds. Boost increases damage dealt by 25%."
				};
			break;
			#endregion

			#region PREDATORS_MARK
			case "PREDATORS_MARK":
				_stct_return_card = {
					_str_card_name : "PREDATOR'S MARK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_predators_mark,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : "HUNTER",
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_predators_mark,
					_str_card_description : "ST. Ranged. Apply Vulnerable. If the target has Bleed, Poison, or Venom, increase Vulnerable’s duration by 1 round."
				};
			break;
			#endregion

			#region PREDATORY_SCENT
			case "PREDATORY_SCENT":
				_stct_return_card = {
					_str_card_name : "PREDATORY SCENT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_predatory_scent,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : "HUNTER",
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_predatory_scent,
					_str_card_description : "ST. Ranged. Apply Focus for 3 rounds. Allied Minions prioritize the target. METABOLIZE 3: Consume 3 Poison. Cultivate all Minions on the caster by 1."
				};
			break;
			#endregion

			#region PRIMAL_BLAST
			case "PRIMAL_BLAST":
				_stct_return_card = {
					_str_card_name : "PRIMAL BLAST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_primal_blast,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 10,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_primal_blast,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [Linear] MAG dmg (base 10)."
				};
			break;
			#endregion

			#region PROLIFERATE
			case "PROLIFERATE":
				_stct_return_card = {
					_str_card_name : "PROLIFERATE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_proliferate,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "DOT",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_proliferate,
					_str_card_description : "EXHAUSTS. Teamwide. Starting with the front enemy Beast, copy all of its DoTs onto the next Beast. Continue toward the back, copying each Beast’s current DoTs onto the next, then reverse direction and repeat until the effect returns to the front Beast."
				};
			break;
			#endregion

			#region RAKE
			case "RAKE":
				_stct_return_card = {
					_str_card_name : "RAKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_rake,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_rake,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 4). Apply 1 Bleed."
				};
			break;
			#endregion

			#region REGENERATE
			case "REGENERATE":
				_stct_return_card = {
					_str_card_name : "REGENERATE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_regenerate,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_regenerate,
					_str_card_description : "EXHAUSTS. ST. Ranged. Target gains 8 Armor at the end of each round for 5 rounds."
				};
			break;
			#endregion

			#region RETURN_TO_NATURE
			case "RETURN_TO_NATURE":
				_stct_return_card = {
					_str_card_name : "RETURN TO NATURE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_return_to_nature,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "CORPSE_OPTIONAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "MANA",
					_flag_allow_empty_corpse_target : true,
					_flag_corpse_cancel_to_card_select : true,					
					_str_card_stat : "NEU",
					_str_card_target_count : "CORPSE",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_return_to_nature,
					_str_card_description : "ST. Ranged. Sacrifice a corpse to generate 1 Mana. If no corpse is available, the caster loses 10 HP instead."
				};
			break;
			#endregion

			#region ROOTED_DEFENSE
			case "ROOTED_DEFENSE":
				_stct_return_card = {
					_str_card_name : "ROOTED DEFENSE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_rooted_defense,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 20,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_rooted_defense,
					_str_card_description : "EXHAUSTS. ST. Self. Gain 20 Armor."
				};
			break;
			#endregion

			#region ROT_BLOOM
			case "ROT_BLOOM":
				_stct_return_card = {
					_str_card_name : "ROT BLOOM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_rot_bloom,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_rot_bloom,
					_str_card_description : "EXHAUSTS. AoE-3. Ranged. Deal 8 NEU dmg to each target. Each target takes 1 additional dmg per Poison stack it has."
				};
			break;
			#endregion

			#region SAPSPRING
			case "SAPSPRING":
				_stct_return_card = {
					_str_card_name : "SAPSPRING",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_sapspring,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "MAG",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 12,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_sapspring,
					_str_card_description : "EXHAUSTS. AoE-3. Ranged. Heal up to 3 selected allied Beasts for [Linear] HP (base 12)."
				};
			break;
			#endregion

			#region ROTTING_SPORES
			case "ROTTING_SPORES":
				_stct_return_card = {
					_str_card_name : "ROTTING SPORES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_rotting_spores,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_rotting_spores,
					_str_card_description : "EXHAUSTS. ST. Ranged. Set a Trap on a Beast. The next time that Beast receives healing, cancel the healing, apply 1 Venom, and deal 5 magical damage."
				};
			break;
			#endregion

			#region SAVAGE_MAUL
			case "SAVAGE_MAUL":
				_stct_return_card = {
					_str_card_name : "SAVAGE MAUL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_savage_maul,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 12,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_savage_maul,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] PHY dmg (base 12)."
				};
			break;
			#endregion

			#region SECOND_BLOOM
			case "SECOND_BLOOM":
				_stct_return_card = {
					_str_card_name : "SECOND BLOOM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_second_bloom,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_second_bloom,
					_str_card_description : "EXHAUSTS. ST. Ranged. For 4 rounds, the next time the target would be defeated, restore it to 25% of its maximum HP instead."
				};
			break;
			#endregion

			#region SEED_BARRAGE
			case "SEED_BARRAGE":
				_stct_return_card = {
					_str_card_name : "SEED BARRAGE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_seed_barrage,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_seed_barrage,
					_str_card_description : "Teamwide. Ranged. Deal [Linear] MAG dmg 4 times to random Beasts on the selected team (base 4 per hit)."
				};
			break;
			#endregion

			#region SEED_THE_FIELD
			case "SEED_THE_FIELD":
				_stct_return_card = {
					_str_card_name : "SEED THE FIELD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_seed_the_field,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_seed_the_field,
					_str_card_description : "Teamwide. Summon 1 Dormant Seed (1/0) in each available allied Minion slot."
				};
			break;
			#endregion

			#region SERPENT_SUMMON
			case "SERPENT_SUMMON":
				_stct_return_card = {
					_str_card_name : "SERPENT SUMMON",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_serpent_summon,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : "SUMMONER",
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_serpent_summon,
					_str_card_description : "EXHAUSTS. ST. Self. Summon 3 Serpents (3/1). Each Serpent applies 1 Venom per Magnitude to a random enemy each round."
				};
			break;
			#endregion

			#region SHIMMERING_SPORES
			case "SHIMMERING_SPORES":
				_stct_return_card = {
					_str_card_name : "SHIMMERING SPORES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_shimmering_spores,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_shimmering_spores,
					_str_card_description : "ST. Ranged. Blind the target for 3 rounds."
				};
			break;
			#endregion

			#region SINEWY_VINES
			case "SINEWY_VINES":
				_stct_return_card = {
					_str_card_name : "SINEWY VINES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_sinewy_vines,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_sinewy_vines,
					_str_card_description : "ST. Self. Gain [Linear] Armor (base 3)."
				};
			break;
			#endregion

			#region SLEEP_DART
			case "SLEEP_DART":
				_stct_return_card = {
					_str_card_name : "SLEEP DART",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_sleep_dart,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_sleep_dart,
					_str_card_description : "ST. Ranged. Sleep the target for 3 rounds."
				};
			break;
			#endregion

			#region SLEEPING_POLLEN
			case "SLEEPING_POLLEN":
				_stct_return_card = {
					_str_card_name : "SLEEPING POLLEN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_sleeping_pollen,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_sleeping_pollen,
					_str_card_description : "EXHAUSTS. AoE-3. Ranged. Sleep up to 3 selected enemies for 2 rounds."
				};
			break;
			#endregion

			#region SNARLING_BITE
			case "SNARLING_BITE":
				_stct_return_card = {
					_str_card_name : "SNARLING BITE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_snarling_bite,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_snarling_bite,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] PHY dmg (base 4). If the attack deals HP damage, apply Vulnerable."
				};
			break;
			#endregion

			#region SPIKE_PIERCE
			case "SPIKE_PIERCE":
				_stct_return_card = {
					_str_card_name : "SPIKE PIERCE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_spike_pierce,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_spike_pierce,
					_str_card_description : "EXHAUSTS. ST. Melee. Pierce Armor and deal [Linear] PHY dmg directly to Overhealth and HP (base 3)."
				};
			break;
			#endregion

			#region SPINESLING
			case "SPINESLING":
				_stct_return_card = {
					_str_card_name : "SPINESLING",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_spinesling,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_spinesling,
					_str_card_description : "ST. Ranged. Deal [Linear] PHY dmg (base 4)."
				};
			break;
			#endregion

			#region SPIRIT_FANG
			case "SPIRIT_FANG":
				_stct_return_card = {
					_str_card_name : "SPIRIT FANG",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_spirit_fang,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_spirit_fang,
					_str_card_description : "ST. Melee. Deal [Linear] MAG dmg (base 4). Apply 1 Venom."
				};
			break;
			#endregion

			#region SPIRIT_PIERCE
			case "SPIRIT_PIERCE":
				_stct_return_card = {
					_str_card_name : "SPIRIT PIERCE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_spirit_pierce,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_spirit_pierce,
					_str_card_description : "EXHAUSTS. ST. Melee. Pierce Armor and deal [Linear] MAG dmg directly to Overhealth and HP (base 3)."
				};
			break;
			#endregion

			#region SPIT_VENOM
			case "SPIT_VENOM":
				_stct_return_card = {
					_str_card_name : "SPIT VENOM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_spit_venom,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_spit_venom,
					_str_card_description : "ST. Ranged. Deal [Linear] PHY dmg (base 3). Apply 1 Venom."
				};
			break;
			#endregion

			#region SPORE_CLOUD
			case "SPORE_CLOUD":
				_stct_return_card = {
					_str_card_name : "SPORE CLOUD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_spore_cloud,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 12,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_spore_cloud,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [%] MAG dmg (base 12% of target’s maximum HP)."
				};
			break;
			#endregion

			#region STALKING_SWIPE
			case "STALKING_SWIPE":
				_stct_return_card = {
					_str_card_name : "STALKING SWIPE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_stalking_swipe,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "BACK",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_stalking_swipe,
					_str_card_description : "ST. Flank. Deal [Linear] PHY dmg (base 5)."
				};
			break;
			#endregion

			#region STAMPEDE
			case "STAMPEDE":
				_stct_return_card = {
					_str_card_name : "STAMPEDE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_stampede,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 15,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "ADVENTURER",
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_stampede,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Deal [%] PHY dmg (base 15% of each target’s maximum HP)."
				};
			break;
			#endregion

			#region STEELFUR
			case "STEELFUR":
				_stct_return_card = {
					_str_card_name : "STEELFUR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_steelfur,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_steelfur,
					_str_card_description : "EXHAUSTS. ST. Self. Double current Armor."
				};
			break;
			#endregion

			#region SYMBIOSIS
			case "SYMBIOSIS":
				_stct_return_card = {
					_str_card_name : "SYMBIOSIS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_symbiosis,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_symbiosis,
					_str_card_description : "EXHAUSTS. ST. Ranged. Redirect the next damage instance intended for the target allied Beast to the caster."
				};
			break;
			#endregion

			#region THICK_HIDE
			case "THICK_HIDE":
				_stct_return_card = {
					_str_card_name : "THICK HIDE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_thick_hide,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 6,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_thick_hide,
					_str_card_description : "ST. Self. Gain 6 Armor plus 1 additional Armor for each status on the caster."
				};
			break;
			#endregion

			#region THORN_NET
			case "THORN_NET":
				_stct_return_card = {
					_str_card_name : "THORN NET",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_thorn_net,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_thorn_net,
					_str_card_description : "EXHAUSTS. ST. Ranged. Set a Trap on a Beast. The next time that Beast attacks, cancel the Attack, deal 4 damage, and apply Vulnerable."
				};
			break;
			#endregion

			#region THORN_STORM
			case "THORN_STORM":
				_stct_return_card = {
					_str_card_name : "THORN STORM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_thorn_storm,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_thorn_storm,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Deal [Linear] MAG dmg to each Beast on the selected team twice (base 8 per hit)."
				};
			break;
			#endregion

			#region THORNMAIL
			case "THORNMAIL":
				_stct_return_card = {
					_str_card_name : "THORNMAIL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_thornmail,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_thornmail,
					_str_card_description : "ST. Self. Gain 4 Armor. Gain Thorns for 3 rounds."
				};
			break;
			#endregion

			#region TOXIC_ERUPTION
			case "TOXIC_ERUPTION":
				_stct_return_card = {
					_str_card_name : "TOXIC ERUPTION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_toxic_eruption,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 2,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_toxic_eruption,
					_str_card_description : "Teamwide. Ranged. Consume all Poison from each target. Deal 2 NEU dmg per Poison stack consumed from that target."
				};
			break;
			#endregion

			#region TOXIC_HIDE
			case "TOXIC_HIDE":
				_stct_return_card = {
					_str_card_name : "TOXIC HIDE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_toxic_hide,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_toxic_hide,
					_str_card_description : "ST. Self. Gain Toxic Hide for 3 rounds. When an enemy successfully deals Melee damage to the caster, apply 1 Poison to that enemy per stack."
				};
			break;
			#endregion

			#region TOXIC_RECLAIMATION
			case "TOXIC_RECLAIMATION":
				_stct_return_card = {
					_str_card_name : "TOXIC RECLAIMATION",
					_str_card_id : _str_card_name,
					_spr_card : scr_card_viridian_toxic_reclaimation,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_MANIPULATION",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_toxic_reclaimation,
					_str_card_description : "EXHAUSTS. ST. Ranged. METABOLIZE 3: Consume 3 Poison from the target. Draw 2 cards."
				};
			break;
			#endregion

			#region TOXIC_SNARE
			case "TOXIC_SNARE":
				_stct_return_card = {
					_str_card_name : "TOXIC SNARE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_toxic_snare,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_toxic_snare,
					_str_card_description : "EXHAUSTS. ST. Ranged. Set a Trap on a Beast. At 5 total DoT stacks or 3 different DoTs, Stun it for 1 round and apply 2 Poison to adjacent Beasts."
				};
			break;
			#endregion

			#region TRANQUILITY
			case "TRANQUILITY":
				_stct_return_card = {
					_str_card_name : "TRANQUILITY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_tranquility,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "ECHO",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_tranquility,
					_str_card_description : "EXHAUSTS. Teamwide. Gain 1 Echo. Heal all allied Beasts for 3 HP."
				};
			break;
			#endregion

			#region UNSEEN_ROOT
			case "UNSEEN_ROOT":
				_stct_return_card = {
					_str_card_name : "UNSEEN ROOT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_unseen_root,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "BACK",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_unseen_root,
					_str_card_description : "ST. Flank. Deal [Linear] MAG dmg (base 5)."
				};
			break;
			#endregion

			#region VENOM_BLOOM
			case "VENOM_BLOOM":
				_stct_return_card = {
					_str_card_name : "VENOM BLOOM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_venom_bloom,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_venom_bloom,
					_str_card_description : "EXHAUSTS. ST. Ranged. Set a Trap on a Beast. When that Beast dies, apply Poison to adjacent Beasts and summon a Sporeling (1/1) on each. Each Sporeling applies 1 Poison per Magnitude to its host each round."
				};
			break;
			#endregion

			#region VERDANT_BOLT
			case "VERDANT_BOLT":
				_stct_return_card = {
					_str_card_name : "VERDANT BOLT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_verdant_bolt,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_verdant_bolt,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 3). Apply 1 random DoT: Bleed, Poison, or Venom."
				};
			break;
			#endregion

			#region VERDANT_EMBRACE
			case "VERDANT_EMBRACE":
				_stct_return_card = {
					_str_card_name : "VERDANT EMBRACE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_verdant_embrace,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 15,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_verdant_embrace,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Heal all allied Beasts for [Linear] HP (base 15)."
				};
			break;
			#endregion

			#region VERDANT_INSIGHT
			case "VERDANT_INSIGHT":
				_stct_return_card = {
					_str_card_name : "VERDANT INSIGHT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_verdant_insight,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_verdant_insight,
					_str_card_description : "ST. Ranged. Increase the target’s MAGPOW and MAGDEF by 20 for 3 rounds."
				};
			break;
			#endregion

			#region VERDANT_SWIPES
			case "VERDANT_SWIPES":
				_stct_return_card = {
					_str_card_name : "VERDANT SWIPES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_verdant_swipes,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 2,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_verdant_swipes,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg 3 times (base 2 per hit)."
				};
			break;
			#endregion

			#region VIRAL_SURGE
			case "VIRAL_SURGE":
				_stct_return_card = {
					_str_card_name : "VIRAL SURGE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_viral_surge,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DOT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_viral_surge,
					_str_card_description : "EXHAUSTS. ST. Ranged. Double all DoT stacks on the target."
				};
			break;
			#endregion

			#region VIRIDIAN_BURST
			case "VIRIDIAN_BURST":
				_stct_return_card = {
					_str_card_name : "VIRIDIAN BURST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_viridian_burst,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_viridian_burst,
					_str_card_description : "AoE-3. Ranged. Deal [Linear] PHY dmg to up to 3 selected Beasts (base 5). Apply 1 Poison to each target."
				};
			break;
			#endregion

			#region WILD_VIGOR
			case "WILD_VIGOR":
				_stct_return_card = {
					_str_card_name : "WILD VIGOR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_wild_vigor,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_wild_vigor,
					_str_card_description : "ST. Ranged. Increase the target’s PHYPOW and PHYDEF by 20 for 3 rounds."
				};
			break;
			#endregion

			#region WILDSTRIKE
			case "WILDSTRIKE":
				_stct_return_card = {
					_str_card_name : "WILDSTRIKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_wildstrike,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_wildstrike,
					_str_card_description : "ST. Melee. Deal [Linear] MAG dmg (base 5)."
				};
			break;
			#endregion

			#region WILDWARD
			case "WILDWARD":
				_stct_return_card = {
					_str_card_name : "WILDWARD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_wildward,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "PHY",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 12,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_wildward,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. All allied Beasts gain [Linear] Armor (base 12)."
				};
			break;
			#endregion

			#region WILT
			case "WILT":
				_stct_return_card = {
					_str_card_name : "WILT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_wilt,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_wilt,
					_str_card_description : "ST. Ranged. Apply Wither for 3 rounds. METABOLIZE 2: Consume 2 Poison. Wither lasts 5 rounds instead."
				};
			break;
			#endregion

		#endregion

		#region UNCOLORED
			#region ARTIFACT_HOURGLASS
			case "ARTIFACT_HOURGLASS":
				_stct_return_card = {
					_str_card_name : "ARTIFACT HOURGLASS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_artifact_hourglass,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TURN",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_uncolored_artifact_hourglass,
					_str_card_description : "EXHAUSTS. Global. After this turn ends, take another full turn."
				};
			break;
			#endregion

			#region BLOCK
			case "BLOCK":
				_stct_return_card = {
					_str_card_name : "BLOCK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_block,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 6,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_block,
					_str_card_description : "ST. Self. Gain 6 Armor."
				};
			break;
			#endregion

			#region BULWARK
			case "BULWARK":
				_stct_return_card = {
					_str_card_name : "BULWARK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_bulwark,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 12,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_bulwark,
					_str_card_description : "ST. Self. Gain 12 Armor."
				};
			break;
			#endregion

			#region CLEARCAST
			case "CLEARCAST":
				_stct_return_card = {
					_str_card_name : "CLEARCAST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_clearcast,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "WEATHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_uncolored_clearcast,
					_str_card_description : "EXHAUSTS. Global. Clear the active Weather."
				};
			break;
			#endregion

			#region DEFT_STRIKE
			case "DEFT_STRIKE":
				_stct_return_card = {
					_str_card_name : "DEFT STRIKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_deft_strike,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "BACK",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DOT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_deft_strike,
					_str_card_description : "ST. Backline. Deal [Linear] NEU dmg (base 3). Apply 1 Bleed."
				};
			break;
			#endregion

			#region ECHO
			case "ECHO":
				_stct_return_card = {
					_str_card_name : "ECHO",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_echo,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "ECHO",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 1,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_uncolored_echo,
					_str_card_description : "EXHAUSTS. Global. Gain 1 Echo. The next non-Echo card is cast 1 additional time per Echo."
				};
			break;
			#endregion

			#region HIDDEN_CARD
			case "HIDDEN_CARD":
				_stct_return_card = {
					_str_card_name : "HIDDEN CARD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_hidden_card,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_DRAW",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 1,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_uncolored_hidden_card,
					_str_card_description : "EXHAUSTS. Global. Draw 1 card."
				};
			break;
			#endregion

			#region INSPIRATION
			case "INSPIRATION":
				_stct_return_card = {
					_str_card_name : "INSPIRATION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_inspiration,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "MANA",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_uncolored_inspiration,
					_str_card_description : "EXHAUSTS. Global. Gain +2 maximum and current Mana for 3 rounds."
				};
			break;
			#endregion

			#region MALLEABILITY
			case "MALLEABILITY":
				_stct_return_card = {
					_str_card_name : "MALLEABILITY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_malleability,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_uncolored_malleability,
					_str_card_description : "EXHAUSTS. ST. Self. The next card cast by this Beast ignores caster requirements."
				};
			break;
			#endregion
			
			#region MARKING_RUNE
			case "MARKING_RUNE":
				_stct_return_card = {
					_str_card_name : "MARKING RUNE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_marking_rune,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_marking_rune,
					_str_card_description : "ST. Ranged. Apply Focus for 3 rounds. Summon 1 random Minion from the combined Viridian, Cerulean, and Vermilion Minion pools on the caster."
				};
			break;
			#endregion			
			
			#region POWER_STRIKE
			case "POWER_STRIKE":
				_stct_return_card = {
					_str_card_name : "POWER STRIKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_power_strike,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 8,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_power_strike,
					_str_card_description : "ST. Melee. Deal [Linear] NEU dmg (base 8)."
				};
			break;
			#endregion

			#region RAPID_STRIKES
			case "RAPID_STRIKES":
				_stct_return_card = {
					_str_card_name : "RAPID STRIKES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_rapid_strikes,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 2,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_rapid_strikes,
					_str_card_description : "ST. Ranged. Deal [Linear] NEU dmg 3 times (base 2 per hit)."
				};
			break;
			#endregion

			#region REPOSITION
			case "REPOSITION":
				_stct_return_card = {
					_str_card_name : "REPOSITION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_reposition,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "TEAM",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "REPOSITION",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_reposition,
					_str_card_description : "ST. Ranged. Swap the caster’s position with the target allied Beast."
				};
			break;
			#endregion

			#region SHIV
			case "SHIV":
				_stct_return_card = {
					_str_card_name : "SHIV",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_shiv,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 2,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_shiv,
					_str_card_description : "ST. Melee. Pierce Armor and deal [Linear] NEU dmg directly to Overhealth and HP (base 2)."
				};
			break;
			#endregion

			#region SOULCLEANSE
			case "SOULCLEANSE":
				_stct_return_card = {
					_str_card_name : "SOULCLEANSE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_soulcleanse,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CLEANSE",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_soulcleanse,
					_str_card_description : "ST. Ranged. Cleanse all Auras from the target."
				};
			break;
			#endregion

			#region SPELLBOOK_WILDCARD
			case "SPELLBOOK_WILDCARD":
				_stct_return_card = {
					_str_card_name : "SPELLBOOK: WILDCARD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_spellbook_wildcard,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DOT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_uncolored_spellbook_wildcard,
					_str_card_description : "EXHAUSTS. ST. Ranged. Apply 5 random DoT stacks."
				};
			break;
			#endregion

			#region STRIKE
			case "STRIKE":
				_stct_return_card = {
					_str_card_name : "STRIKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_strike,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_strike,
					_str_card_description : "ST. Melee. Deal [Linear] NEU dmg (base 5)."
				};
			break;
			#endregion

			#region THOUGHTSTEAL
			case "THOUGHTSTEAL":
				_stct_return_card = {
					_str_card_name : "THOUGHTSTEAL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_thoughtsteal,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "ENEMY_CARD",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_MANIPULATION",
					_str_card_stat : "NEU",
					_str_card_target_count : "CARD",
					_val_card_magnitude : 0,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_uncolored_thoughtsteal,
					_str_card_description : "EXHAUSTS. ST. Card. Select a revealed enemy card. Gain Mana equal to its Mana cost and disable it for its next cast."
				};
			break;
			#endregion

		#endregion

		#region VERMILION
			#region 3RD_DEGREE
			case "3RD_DEGREE":
				_stct_return_card = {
					_str_card_name : "3RD DEGREE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_3rd_degree,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "AURA",
					_str_card_stat : "NEU",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_3rd_degree,
					_str_card_description : "EXHAUSTS. AoE-3. Ranged. Aura. (+) The target Beast and adjacent allied Beasts deal 25% increased damage. (-) Affected Beasts take 15% increased damage."
				};
			break;
			#endregion

			#region ANEMIA
			case "ANEMIA":
				_stct_return_card = {
					_str_card_name : "ANEMIA",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_anemia,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_anemia,
					_str_card_description : "ST. Ranged. Reduce the target's PHYPOW by 30 for 3 rounds."
				};
			break;
			#endregion
		
			#region ARTERIAL_BURST
			case "ARTERIAL_BURST":
				_stct_return_card = {
					_str_card_name : "ARTERIAL BURST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_arterial_burst,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_arterial_burst,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 7). Deal 4 additional dmg if the target is Bleeding. HEMORRHAGE."
				};
			break;
			#endregion		

			#region ASHEN_FORMATION
			case "ASHEN_FORMATION":
				_stct_return_card = {
					_str_card_name : "ASHEN FORMATION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_ashen_formation,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "TEAM",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 3,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_ashen_formation,
					_str_card_description : "EXHAUSTS. Teamwide. All allied Beasts gain 5 Armor and Burning Thorns for 3 rounds. The next enemy that directly damages each affected Beast gains 1 Burn."
				};
			break;
			#endregion
		
			#region BACKDRAFT
			case "BACKDRAFT":
				_stct_return_card = {
					_str_card_name : "BACKDRAFT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_backdraft,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 50,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_backdraft,
					_str_card_description : "EXHAUSTS. ST. Self. Gain Backdraft. The next time the caster would take direct damage, reflect 50% of that damage to its source as NEU dmg, reducing the incoming damage by the reflected amount. Then consume Backdraft."
				};
			break;
			#endregion
		
			#region BARBED_BOLT
			case "BARBED_BOLT":
				_stct_return_card = {
					_str_card_name : "BARBED BOLT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_barbed_bolt,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_barbed_bolt,
					_str_card_description : "ST. Ranged. Deal [Linear] PHY dmg (base 4). Apply 1 Bleed."
				};
			break;
			#endregion	
	
			#region BATTLE_FRENZY
			case "BATTLE_FRENZY":
				_stct_return_card = {
					_str_card_name : "BATTLE FRENZY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_battle_frenzy,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "SOLDIER",
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_battle_frenzy,
					_str_card_description : "EXHAUSTS. ST. Self. Gain Battle Frenzy. After the caster's next Attack resolves, repeat its damage at 25% effectiveness as NEU dmg. Does not repeat statuses or secondary effects. Stackable."
				};
			break;
#endregion	
	
			#region BATTLE_TRANCE
			case "BATTLE_TRANCE":
				_stct_return_card = {
					_str_card_name : "BATTLE TRANCE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_battle_trance,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_DRAW",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "SOLDIER",
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_battle_trance,
					_str_card_description : "ST. Self. Draw 1 card. Gain 1 Rage."
				};
			break;
			#endregion	
	
			#region BERSERKER_CHARGE
			case "BERSERKER_CHARGE":
				_stct_return_card = {
					_str_card_name : "BERSERKER CHARGE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_berserker_charge,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "BACK",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_berserker_charge,
					_str_card_description : "ST. Flank. Deal [Linear] PHY dmg (base 6)."
				};
			break;
			#endregion	
	
			#region BERSERKER_FLURRY
			case "BERSERKER_FLURRY":
				_stct_return_card = {
					_str_card_name : "BERSERKER FLURRY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_berserker_flurry,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_berserker_flurry,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg 3 times (base 3 per hit)."
				};
			break;
			#endregion	

			#region BLOOD_FEUD
			case "BLOOD_FEUD":
				_stct_return_card = {
					_str_card_name : "BLOOD FEUD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_blood_feud,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_blood_feud,
					_str_card_description : "ST. Ranged. Apply Focus for 3 rounds. Summon 1 random Vermilion Minion on the caster."
				};
			break;
			#endregion
	
			#region BLOOD_FURNACE
			case "BLOOD_FURNACE":
				_stct_return_card = {
					_str_card_name : "BLOOD FURNACE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_blood_furnace,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_blood_furnace,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 7), plus 2 additional dmg per Char on the target. ERUPTION 3: Apply 1 Char."
				};
			break;
			#endregion	
	
			#region BLOOD_MOON
			case "BLOOD_MOON":
				_stct_return_card = {
					_str_card_name : "BLOOD MOON",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_blood_moon,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "EVENT",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_blood_moon,
					_str_card_description : "EXHAUSTS. Global. Begin the Blood Moon Event."
				};
			break;
			#endregion	
	
			#region BLOOD_OATH
			case "BLOOD_OATH":
				_stct_return_card = {
					_str_card_name : "BLOOD OATH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_blood_oath,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_blood_oath,
					_str_card_description : "EXHAUSTS. ST. Ranged. Redirect the next damage instance intended for the target allied Beast to the caster. When triggered, the caster gains 2 Rage."
				};
			break;
			#endregion	
	
			#region BLOOD_OFFERING
			case "BLOOD_OFFERING":
				_stct_return_card = {
					_str_card_name : "BLOOD OFFERING",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_blood_offering,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "MANA",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_blood_offering,
					_str_card_description : "EXHAUSTS. ST. Self. Lose 10 HP. Generate 1 Mana and summon 1 random Vermilion Minion on the caster."
				};
			break;
			#endregion	
	
			#region BLOOD_PRICE
			case "BLOOD_PRICE":
				_stct_return_card = {
					_str_card_name : "BLOOD PRICE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_blood_price,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 16,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_blood_price,
					_str_card_description : "EXHAUSTS. ST. Melee. The caster loses 8 HP. Deal [Linear] PHY dmg (base 16)."
				};
			break;
			#endregion	

			#region BLOOD_RUSH
			case "BLOOD_RUSH":
				_stct_return_card = {
					_str_card_name : "BLOOD RUSH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_blood_rush,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_DRAW",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_blood_rush,
					_str_card_description : "ST. Self. The caster loses 8 HP. Draw 2 cards."
				};
			break;
			#endregion
	
			#region BLOODCOATED
			case "BLOODCOATED":
				_stct_return_card = {
					_str_card_name : "BLOODCOATED",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloodcoated,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_bloodcoated,
					_str_card_description : "ST. Self. Cleanse all Bleed from the caster and heal 2 HP per Bleed removed. If the caster has at least 1 Rage, gain Bloodcoated for 3 rounds. While active, the caster's Attacks apply 1 Bleed."
				};
			break;
			#endregion	
	
			#region BLOODFLAME_BOLT
			case "BLOODFLAME_BOLT":
				_stct_return_card = {
					_str_card_name : "BLOODFLAME BOLT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloodflame_bolt,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_bloodflame_bolt,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 6)."
				};
			break;
			#endregion		
		
			#region BLOODFLAME_NEEDLE
			case "BLOODFLAME_NEEDLE":
				_stct_return_card = {
					_str_card_name : "BLOODFLAME NEEDLE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloodflame_needle,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_bloodflame_needle,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 3). Apply 1 Bleed. If the target is Burning, apply 1 additional Bleed."
				};
			break;
			#endregion		
	
			#region BLOODHUNGER
			case "BLOODHUNGER":
				_stct_return_card = {
					_str_card_name : "BLOODHUNGER",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloodhunger,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_bloodhunger,
					_str_card_description : "ST. Ranged. Gain Leech for 3 rounds, this status heals the host for 25% of the HP damage dealt by its Attacks."
				};
			break;
			#endregion	
	
			#region BLOODLETTING
			case "BLOODLETTING":
				_stct_return_card = {
					_str_card_name : "BLOODLETTING",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloodletting,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 18,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_bloodletting,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [%] PHY dmg (base 18% of target's maximum HP). HEMORRHAGE."
				};
			break;
			#endregion		
		
			#region BLOODLINE
			case "BLOODLINE":
				_stct_return_card = {
					_str_card_name : "BLOODLINE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloodline,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_MANIPULATION",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_bloodline,
					_str_card_description : "EXHAUSTS. Global. Search your deck for an Attack card and draw it."
				};
			break;
			#endregion		
		
			#region BLOODLUST_LUNGE
			case "BLOODLUST_LUNGE":
				_stct_return_card = {
					_str_card_name : "BLOODLUST LUNGE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloodlust_lunge,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "BACK",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_bloodlust_lunge,
					_str_card_description : "ST. Flank. Consume 3 Rage. Deal [Linear] PHY dmg (base 6) plus 12 additional dmg. EXECUTE: Heal the caster for 5 HP."
				};
			break;
			#endregion
		
			#region BLOODMIST
			case "BLOODMIST":
				_stct_return_card = {
					_str_card_name : "BLOODMIST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloodmist,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "EVENT",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_bloodmist,
					_str_card_description : "EXHAUSTS. Global. Begin the Bloodmist Event."
					};
			break;
			#endregion

			#region BLOODSTEP
			case "BLOODSTEP":
				_stct_return_card = {
					_str_card_name : "BLOODSTEP",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloodstep,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "TEAM",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "REPOSITION",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_bloodstep,
					_str_card_description : "ST. Ranged. Swap the caster's position with the target allied Beast."
				};
			break;
			#endregion
		
			#region BLOODY_SHIELD
			case "BLOODY_SHIELD":
				_stct_return_card = {
					_str_card_name : "BLOODY SHIELD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloody_shield,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 5,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_bloody_shield,
					_str_card_description : "ST. Self. Gain 5 Armor. Beast consumes up to 2 Rage to gain 5 additional Armor each."
				};
			break;
			#endregion		
		
			#region BREAKJAW
			case "BREAKJAW":
				_stct_return_card = {
					_str_card_name : "BREAKJAW",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_breakjaw,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_breakjaw,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 8). If the caster has at least 3 Rage, Stun the target for 1 round."
				};
			break;
			#endregion		
		
			#region BLOODY_SWIPE
			case "BLOODY_SWIPE":
				_stct_return_card = {
					_str_card_name : "BLOODY SWIPE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bloody_swipe,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_bloody_swipe,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 6). Apply 2 Bleed."
				};
			break;
			#endregion		
		
			#region BURNING_CLEAVE
			case "BURNING_CLEAVE":
				_stct_return_card = {
					_str_card_name : "BURNING CLEAVE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_burning_cleave,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "FRONT2",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_burning_cleave,
					_str_card_description : "AoE-2. Melee. Deal [Linear] PHY dmg to the front target and the Beast behind it (base 8)."
				};
			break;
			#endregion		
		
			#region BURNING_MISSILES
			case "BURNING_MISSILES":
				_stct_return_card = {
					_str_card_name : "BURNING MISSILES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_burning_missiles,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_burning_missiles,
					_str_card_description : "AoE-3. Ranged. Deal [Linear] MAG dmg to up to 3 selected Beasts (base 5). If a target is already Burning, apply 1 additional Burn to it."
				};
			break;
			#endregion		
		
			#region BURNING_PARRY
			case "BURNING_PARRY":
				_stct_return_card = {
					_str_card_name : "BURNING PARRY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_burning_parry,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "PHY",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_burning_parry,
					_str_card_description : "EXHAUSTS. ST. Self. For 2 rounds, block the next Melee Attack against the caster and deal [Linear] PHY dmg to the attacker (base 6)."
				};
			break;
			#endregion	
		
			#region BURSTING_METEOR
			case "BURSTING_METEOR":
				_stct_return_card = {
					_str_card_name : "BURSTING METEOR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_bursting_meteor,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 11,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_bursting_meteor,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 11). ERUPTION 5: Deal 5 MAG dmg and apply 2 Burn to adjacent enemies."
				};
			break;
			#endregion		

			#region CATACLYSM
			case "CATACLYSM":
				_stct_return_card = {
					_str_card_name : "CATACLYSM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_cataclysm,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 8,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_cataclysm,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Caster dies. Deal [%] MAG dmg to each Beast (base 8% of each target's maximum HP). Trigger eligible ERUPTIONS in order: ERUPTION 3: Trigger Burn twice. ERUPTION 5: Deal 5 damage to adjacent Beasts. ERUPTION 8: Begin Firestorm and strike all enemies for 8 damage. ERUPTION 10: Deal 20 damage, apply 5 Char, and Stun."
				};
			break;
			#endregion

			#region CAUTERIZED_WOUND
			case "CAUTERIZED_WOUND":
				_stct_return_card = {
					_str_card_name : "CAUTERIZED WOUND",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_cauterized_wound,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_cauterized_wound,
					_str_card_description : "ST. Ranged. Apply Antiheal for 2 rounds. If the target is Burning, Antiheal lasts 3 rounds instead."
				};
			break;
			#endregion
		
			#region CHAIN_COMBUSTION
			case "CHAIN_COMBUSTION":
				_stct_return_card = {
					_str_card_name : "CHAIN COMBUSTION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_chain_combustion,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_chain_combustion,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Strike each Burning enemy from front to back. Deal [Linear] MAG dmg to the first target (base 8), then deal 1 less dmg with each successive hit, minimum 4."
				};
			break;
			#endregion		
		
			#region CINDER_CHASE
			case "CINDER_CHASE":
				_stct_return_card = {
					_str_card_name : "CINDER CHASE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_cinder_chase,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_cinder_chase,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] MAG dmg (base 8). EXECUTE: Draw 2 cards."
				};
			break;
			#endregion
		
			#region CINDER_KICK
			case "CINDER_KICK":
				_stct_return_card = {
					_str_card_name : "CINDER KICK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_cinder_kick,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_cinder_kick,
					_str_card_description : "ST. Melee. Deal 5 PHY dmg. ERUPTION 3: Move the target backward 1 position."
				};
			break;
			#endregion		
		
			#region CINDER_SPEAR
			case "CINDER_SPEAR":
				_stct_return_card = {
					_str_card_name : "CINDER SPEAR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_cinder_spear,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_cinder_spear,
					_str_card_description : "ST. Ranged. Deal [Linear] PHY dmg (base 5)."
				};
			break;
			#endregion		
		
			#region CINDERGUARD
			case "CINDERGUARD":
				_stct_return_card = {
					_str_card_name : "CINDERGUARD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_cinderguard,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_cinderguard,
					_str_card_description : "ST. Self. Gain 5 Armor. The next enemy that directly damages the caster gains 1 Burn. 2 charges."
				};
			break;
			#endregion		
		
			#region COMBUSTION
			case "COMBUSTION":
				_stct_return_card = {
					_str_card_name : "COMBUSTION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_combustion,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 15,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_combustion,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [%] MAG dmg (base 15% of target's maximum HP)."
				};
			break;
			#endregion		
		
			#region CREMATE
			case "CREMATE":
				_stct_return_card = {
					_str_card_name : "CREMATE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_cremate,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "CORPSE_OPTIONAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "OTHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "CORPSE_OPTIONAL",
					_flag_allow_empty_corpse_target : true,
					_flag_corpse_cancel_to_card_select : true,
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_cremate,
					_str_card_description : "EXHAUSTS. ST. Ranged. Sacrifice a corpse or have the caster lose 10 HP. Draw 2 cards and gain 2 Rage."
				};
			break;
			#endregion

			#region CRIMSON_FOCUS
			case "CRIMSON_FOCUS":
				_stct_return_card = {
					_str_card_name : "CRIMSON FOCUS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_crimson_focus,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 15,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_crimson_focus,
					_str_card_description : "ST. Self. Increase the caster's Critical Hit chance by 15% for 3 rounds."
				};
			break;
			#endregion

			#region DANCING_FLAME
			case "DANCING_FLAME":
				_stct_return_card = {
					_str_card_name : "DANCING FLAME",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_dancing_flame,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_dancing_flame,
					_str_card_description : "ST. Ranged. Confuse the target for 1 round. Its Attacks, DoTs, CC, and Debuffs targeting enemies have a 66% chance to target a random Beast instead."
				};
			break;
			#endregion

			#region DRAGON_MINE
			case "DRAGON_MINE":
				_stct_return_card = {
					_str_card_name : "DRAGON MINE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_dragon_mine,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : "ENGINEER",
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_dragon_mine,
					_str_card_description : "EXHAUSTS. ST. Ranged. Set a Trap on an enemy Beast. The next time that Beast Attacks, deal [Linear] MAG dmg to it (base 6) and apply 3 Burn."
				};
			break;
			#endregion
		
			#region DRAGONSTORM
			case "DRAGONSTORM":
				_stct_return_card = {
					_str_card_name : "DRAGONSTORM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_dragonstorm,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 20,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_dragonstorm,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Deal 2 NEU dmg 20 times to random Beasts on the selected team. If a target is not Burning, apply 1 Burn. If it is already Burning, apply 1 Char."
				};
			break;
			#endregion		
		
			#region EMBER_BARRAGE
			case "EMBER_BARRAGE":
				_stct_return_card = {
					_str_card_name : "EMBER BARRAGE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_ember_barrage,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_ember_barrage,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg 3 times (base 3 per hit)."
				};
			break;
			#endregion		
		
			#region EMBER_SHOT
			case "EMBER_SHOT":
				_stct_return_card = {
					_str_card_name : "EMBER SHOT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_ember_shot,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_ember_shot,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg. Apply 1 Burn (base 4)."
				};
			break;
			#endregion		
		
			#region EMBER_TURRET
			case "EMBER_TURRET":
				_stct_return_card = {
					_str_card_name : "EMBER TURRET",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_ember_turret,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_ember_turret,
					_str_card_description : "ST. Ranged. Summon an Ember Turret (3/1). If the enemy is not Burning, apply 1 Burn. If the enemy is already Burning, deal 2 NEU dmg per Magnitude instead."
				};
			break;
			#endregion		
		
			#region ENDLESS_RAGE
			case "ENDLESS_RAGE":
				_stct_return_card = {
					_str_card_name : "ENDLESS RAGE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_endless_rage,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "SOLDIER",
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_endless_rage,
					_str_card_description : "EXHAUSTS. ST. Ranged. For 3 rounds, set the target Beast to 5 Rage and increase its damage dealt and Critical Hit chance by 25%. Rage deals double damage to the host, cannot be removed, and may be spent without reducing its Rage. Remove all Rage when the effect ends."
				};
			break;
			#endregion		
		
			#region ERUPTING_SLAM
			case "ERUPTING_SLAM":
				_stct_return_card = {
					_str_card_name : "ERUPTING SLAM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_erupting_slam,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_erupting_slam,
					_str_card_description : "ST. Ranged. Deal [Linear] PHY dmg (base 7). Apply 1 Burn. ERUPTION 5: Deal 25% of the primary hit to adjacent enemies."
				};
			break;
			#endregion		
		
			#region EXSANGUINATE
			case "EXSANGUINATE":
				_stct_return_card = {
					_str_card_name : "EXSANGUINATE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_exsanguinate,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "HEMORRHAGE",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_exsanguinate,
					_str_card_description : "ST. Melee. HEMORRHAGE. Then apply 3 Bleed."
				};
			break;
			#endregion		

			#region FEED_THE_FLAME
			case "FEED_THE_FLAME":
				_stct_return_card = {
					_str_card_name : "FEED THE FLAME",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_feed_the_flame,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_feed_the_flame,
					_str_card_description : "ST. Ranged. Sacrifice the caster's oldest Minion. Deal [Linear] MAG dmg (base 5) plus that Minion's maximum HP. If no Minion is available, the caster loses 6 HP instead. Apply 2 Burn."
				};
			break;
			#endregion
		
			#region FEED_THE_FURNACE
			case "FEED_THE_FURNACE":
				_stct_return_card = {
					_str_card_name : "FEED THE FURNACE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_feed_the_furnace,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "MANA",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_str_card_cast_motion : "MINION",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : "ENGINEER",
					_str_card_rarity : "II",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_feed_the_furnace,
					_str_card_description : "EXHAUSTS. ST. Self. Sacrifice the caster's oldest Minion to generate 2 Mana. If no Minion is available, lose 8 HP and generate 1 Mana instead."
				};
			break;
			#endregion	
		
			#region FIERY_BLOW
			case "FIERY_BLOW":
				_stct_return_card = {
					_str_card_name : "FIERY BLOW",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_fiery_blow,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_fiery_blow,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 6)."
				};
			break;
			#endregion
		
			#region FINISHING_BLOW
			case "FINISHING_BLOW":
				_stct_return_card = {
					_str_card_name : "FINISHING BLOW",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_finishing_blow,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_finishing_blow,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 4). EXECUTE: Gain 1 Rage."
				};
			break;
			#endregion			
		
			#region FIREBALL
			case "FIREBALL":
				_stct_return_card = {
					_str_card_name : "FIREBALL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_fireball,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_fireball,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Deal [Linear] MAG dmg to each enemy Beast (base 8)."
				};
			break;
			#endregion		

			#region FIRESTORM
			case "FIRESTORM":
				_stct_return_card = {
					_str_card_name : "FIRESTORM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_firestorm,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "WEATHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_firestorm,
					_str_card_description : "Global. Begin Firestorm Weather."
				};
			break;
			#endregion
		
			#region FLAME_LANCE
			case "FLAME_LANCE":
				_stct_return_card = {
					_str_card_name : "FLAME LANCE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_flame_lance,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "BACK",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_flame_lance,
					_str_card_description : "ST. Flank. Deal [Linear] MAG dmg (base 7)."
				};
			break;
			#endregion		

			#region FLAME_SPOUT
			case "FLAME_SPOUT":
				_stct_return_card = {
					_str_card_name : "FLAME SPOUT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_flame_spout,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 9,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_flame_spout,
					_str_card_description : "AoE-3. Ranged. Deal [Linear] MAG dmg to up to 3 selected Beasts (base 9)."
				};
			break;
			#endregion

			#region FLAMEFORGED
			case "FLAMEFORGED":
				_stct_return_card = {
					_str_card_name : "FLAMEFORGED",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_flameforged,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_str_card_cast_motion : "MINION",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_flameforged,
					_str_card_description : "ST. Self. Summon a Flameguard (7/0). While it lives, its host Taunts enemy Beasts."
				};
			break;
			#endregion

			#region FLAMESPAWN
			case "FLAMESPAWN":
				_stct_return_card = {
					_str_card_name : "FLAMESPAWN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_flamespawn,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_str_card_cast_motion : "MINION",
					_val_card_magnitude : 3,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : "SUMMONER",
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_flamespawn,
					_str_card_description : "EXHAUSTS. ST. Ranged. Summon 3 Cinderlings (2/1) in available allied Minion slots. Each Cinderling deals 1 NEU dmg per Magnitude each round. When killed, apply 1 Burn to an opposing Beast."
				};
			break;
			#endregion

			#region FLAMING_LASHES
			case "FLAMING_LASHES":
				_stct_return_card = {
					_str_card_name : "FLAMING LASHES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_flaming_lashes,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 20,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_flaming_lashes,
					_str_card_description : "EXHAUSTS. ST. Ranged. For 3 rounds, the target's Attacks deal 20% of their damage to an adjacent enemy."
				};
			break;
			#endregion

			#region FLASHPOINT
			case "FLASHPOINT":
				_stct_return_card = {
					_str_card_name : "FLASHPOINT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_flashpoint,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_flashpoint,
					_str_card_description : "ST. Ranged. Deal 4 NEU dmg. ERUPTION 3: Deal 3 additional NEU dmg."
				};
			break;
			#endregion	
	
			#region FORWARD_MARCH
			case "FORWARD_MARCH":
				_stct_return_card = {
					_str_card_name : "FORWARD MARCH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_forward_march,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "SOLDIER",
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_forward_march,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 5). If the caster is the front allied Beast, gain 1 Rage."
				};
			break;
			#endregion		
	
			#region FRONTLINE_ORDER
			case "FRONTLINE_ORDER":
				_stct_return_card = {
					_str_card_name : "FRONTLINE ORDER",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_frontline_order,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "SOLDIER",
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_frontline_order,
					_str_card_description : "ST. Ranged. Target Beast gains 1 Rage and 4 Armor."
				};
			break;
			#endregion
	
			#region FUEL_THE_FIRE
			case "FUEL_THE_FIRE":
				_stct_return_card = {
					_str_card_name : "FUEL THE FIRE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_fuel_the_fire,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "HEAL",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_fuel_the_fire,
					_str_card_description : "EXHAUSTS. ST. Self. Spend 2 Rage. Heal the caster for 5 HP and generate 1 Mana."
				};
			break;
			#endregion	
	
			#region FURIOUS_SLICE
			case "FURIOUS_SLICE":
				_stct_return_card = {
					_str_card_name : "FURIOUS SLICE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_furious_slice,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_furious_slice,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 5). Consume 1 Rage to deal 4 additional dmg."
				};
			break;
			#endregion		

			#region FURNACE_HEART
			case "FURNACE_HEART":
				_stct_return_card = {
					_str_card_name : "FURNACE HEART",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_furnace_heart,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_furnace_heart,
					_str_card_description : "EXHAUSTS. ST. Self. Absorb the next MAG Attack and prevent its damage. The caster's next Attack deals additional NEU dmg equal to 50% of the absorbed damage."
				};
			break;
			#endregion
		
			#region HARDEN_BLOOD
			case "HARDEN_BLOOD":
				_stct_return_card = {
					_str_card_name : "HARDEN BLOOD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_harden_blood,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 8,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_harden_blood,
					_str_card_description : "ST. Self. Gain 8 Armor."
				};
			break;
			#endregion		
		
			#region HEADSMANS_DUE
			case "HEADSMANS_DUE":
				_stct_return_card = {
					_str_card_name : "HEADSMAN'S DUE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_headsmans_due,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_headsmans_due,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] PHY dmg (base 8). Deal 12 additional dmg if the target is below 25% HP. EXECUTE: Generate 2 Mana."
				};
			break;
			#endregion		

			#region HEAT_UP
			case "HEAT_UP":
				_stct_return_card = {
					_str_card_name : "HEAT UP",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_heat_up,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_heat_up,
					_str_card_description : "ST. Ranged. Target Beast gains 2 Rage."
				};
			break;
			#endregion
		
			#region HEATWAVE
			case "HEATWAVE":
				_stct_return_card = {
					_str_card_name : "HEATWAVE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_heatwave,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "WEATHER",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_heatwave,
					_str_card_description : "Global. Begin Heat Wave Weather."
				};
			break;
			#endregion		
		
			#region HELLFIRE_STRIKE
			case "HELLFIRE_STRIKE":
				_stct_return_card = {
					_str_card_name : "HELLFIRE STRIKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_hellfire_strike,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_hellfire_strike,
					_str_card_description : "ST. Melee. Deal [Linear] MAG dmg (base 7)."
				};
			break;
			#endregion		

			#region HEMOPHILIA
			case "HEMOPHILIA":
				_stct_return_card = {
					_str_card_name : "HEMOPHILIA",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_hemophilia,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_hemophilia,
					_str_card_description : "ST. Ranged. For 3 rounds, whenever the target Beast is attacked, apply 1 Bleed to it."
				};
			break;
			#endregion

			#region HUNGERING_FLAMES
			case "HUNGERING_FLAMES":
				_stct_return_card = {
					_str_card_name : "HUNGERING FLAMES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_hungering_flames,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "AURA",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_hungering_flames,
					_str_card_description : "EXHAUSTS. Teamwide. Aura. (+) At the end of each round, heal allied Beast for 2 HP for each Burning Beast on the enemy team. (-) Allied beasts have have 20% reduced maximum HP."
				};
			break;
			#endregion

			#region INFERNO_ETERNAL
			case "INFERNO_ETERNAL":
				_stct_return_card = {
					_str_card_name : "INFERNO ETERNAL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_inferno_eternal,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_inferno_eternal,
					_str_card_description : "EXHAUSTS. Global. For 5 rounds, reduce all ERUPTION thresholds by 2, to a minimum of 1. Begin Heat Wave Weather."
				};
			break;
			#endregion

			#region INNER_FLAME
			case "INNER_FLAME":
				_stct_return_card = {
					_str_card_name : "INNER FLAME",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_inner_flame,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_inner_flame,
					_str_card_description : "EXHAUSTS. ST. Self. Remove all DoTs and Debuffs from the caster. The caster's next Attack deals 2 additional dmg for each status removed."
				};
			break;
			#endregion

			#region LAST_STAND
			case "LAST_STAND":
				_stct_return_card = {
					_str_card_name : "LAST STAND",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_last_stand,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_last_stand,
					_str_card_description : "EXHAUSTS. ST. Ranged. For 3 rounds, the next fatal damage dealt to the target leaves it at 5 HP instead. Remove all nonpermanent effects from the target and grant 2 Rage."
				};
			break;
			#endregion

			#region LIVING_FLAME
			case "LIVING_FLAME":
				_stct_return_card = {
					_str_card_name : "LIVING FLAME",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_living_flame,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_living_flame,
					_str_card_description : "ST. Ranged. Summon a Living Flame (3/1). Each round, it deals 1 NEU dmg per Magnitude to a random enemy. If the target has Armor, deal additional dmg equal to half its Magnitude, rounded up."
				};
			break;
			#endregion

			#region MAGMA_CANNON
			case "MAGMA_CANNON":
				_stct_return_card = {
					_str_card_name : "MAGMA CANNON",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_magma_cannon,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_str_card_cast_motion : "MINION",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : "ENGINEER",
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_magma_cannon,
					_str_card_description : "EXHAUSTS. ST. Ranged. Summon a Magma Cannon (3/3). Each round, it deals 1 NEU dmg per Magnitude to a random enemy, plus 2 additional dmg if that enemy is Burning."
				};
			break;
			#endregion

			#region MELTING_ARMAMENTS
			case "MELTING_ARMAMENTS":
				_stct_return_card = {
					_str_card_name : "MELTING ARMAMENTS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_melting_armaments,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_melting_armaments,
					_str_card_description : "ST. Ranged. For 3 rounds, the target's Attacks deal 4 additional damage to Armor before dealing their normal damage."
				};
			break;
			#endregion

			#region MELTPLATE
			case "MELTPLATE":
				_stct_return_card = {
					_str_card_name : "MELTPLATE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_meltplate,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_meltplate,
					_str_card_description : "EXHAUSTS. ST. Ranged. Destroy 10 Armor, then deal [Linear] MAG dmg (base 7). If any Armor was destroyed, apply 1 Burn."
				};
			break;
			#endregion

			#region MENACING_ROAR
			case "MENACING_ROAR":
				_stct_return_card = {
					_str_card_name : "MENACING ROAR",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_menacing_roar,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_menacing_roar,
					_str_card_description : "AoE-3. Ranged. Apply Weakness for 2 rounds to up to 3 selected targets. If the caster has at least 4 Rage, also apply Vulnerable for 1 round and 1 Bleed to each target."
				};
			break;
			#endregion

			#region MOLTEN_AEGIS
			case "MOLTEN_AEGIS":
				_stct_return_card = {
					_str_card_name : "MOLTEN AEGIS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_molten_aegis,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_molten_aegis,
					_str_card_description : "ST. Ranged. Target Beast gains 7 Armor. Its next Attack applies 1 Burn."
				};
			break;
			#endregion

			#region MOLTEN_BRAND
			case "MOLTEN_BRAND":
				_stct_return_card = {
					_str_card_name : "MOLTEN BRAND",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_molten_brand,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_molten_brand,
					_str_card_description : "ST. Ranged. For 2 rounds, the target takes 25% increased damage from Vermilion Cards."
				};
			break;
			#endregion

			#region MOLTEN_EDGE
			case "MOLTEN_EDGE":
				_stct_return_card = {
					_str_card_name : "MOLTEN EDGE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_molten_edge,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_molten_edge,
					_str_card_description : "EXHAUSTS. ST. Melee. Pierce Armor and deal [Linear] PHY dmg directly to Overhealth and HP (base 4)."
				};
			break;
			#endregion		
	
			#region MOLTEN_RUIN
			case "MOLTEN_RUIN":
				_stct_return_card = {
					_str_card_name : "MOLTEN RUIN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_molten_ruin,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 20,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_molten_ruin,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Deal [Linear] MAG dmg to the Armor of each Beast on the selected team (base 20). Apply 2 Char. Excess Armor damage does not spill into Overhealth or HP. Each Armor break summons a random Vermilion Minion on the caster."
				};
			break;
			#endregion	
	
			#region OPEN_VEIN
			case "OPEN_VEIN":
				_stct_return_card = {
					_str_card_name : "OPEN VEIN",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_open_vein,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "BACK",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 6,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_open_vein,
					_str_card_description : "ST. Flank. Deal [Linear] PHY dmg (base 6). Apply 1 Bleed. HEMORRHAGE."
				};
			break;
			#endregion

			#region OVERHEAT
			case "OVERHEAT":
				_stct_return_card = {
					_str_card_name : "OVERHEAT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_overheat,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 7,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_overheat,
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 7). Gain 1 Rage. If the caster has at least 3 Rage, apply 2 Burn."
				};
			break;
			#endregion
		
			#region PAIN_RESPONSE
			case "PAIN_RESPONSE":
				_stct_return_card = {
					_str_card_name : "PAIN RESPONSE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_pain_response,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_pain_response,
					_str_card_description : "ST. Self. For 2 rounds, the first time each round the caster takes HP damage, gain 1 Rage."
				};
			break;
			#endregion		
		
			#region PHOENIX_REBIRTH
			case "PHOENIX_REBIRTH":
				_stct_return_card = {
					_str_card_name : "PHOENIX REBIRTH",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_phoenix_rebirth,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 40,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_phoenix_rebirth,
					_str_card_description : "EXHAUSTS. ST. Ranged. Grant Phoenix Rebirth for the remainder of battle. The next time the target would be defeated, revive it at 40% maximum HP, remove all negative statuses, and heal all other allied Beasts for 20% of their maximum HP. Then expend Phoenix Rebirth."
				};
			break;
			#endregion		
		
			#region POWDER_KEG
			case "POWDER_KEG":
				_stct_return_card = {
					_str_card_name : "POWDER KEG",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_powder_keg,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_powder_keg,
					_str_card_description : "EXHAUSTS. ST. Ranged. Set a Trap on a Beast. The next time that Beast takes direct damage, deal [Linear] PHY dmg to it and adjacent Beasts (base 5)."
				};
			break;
			#endregion		

			#region PYRE_WEAPON
			case "PYRE_WEAPON":
				_stct_return_card = {
					_str_card_name : "PYRE WEAPON",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_pyre_weapon,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_pyre_weapon,
					_str_card_description : "EXHAUSTS. ST. Ranged. For 2 rounds, the target's Attacks apply 1 Burn."
				};
			break;
			#endregion		
		
			#region PYROCLAST
			case "PYROCLAST":
				_stct_return_card = {
					_str_card_name : "PYROCLAST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_pyroclast,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 13,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_pyroclast,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [Linear] MAG dmg (base 13)."
				};
			break;
			#endregion		
		
			#region RAGEFIRE
			case "RAGEFIRE":
				_stct_return_card = {
					_str_card_name : "RAGEFIRE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_ragefire,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_ragefire,
					_str_card_description : "EXHAUSTS. AoE-3. Ranged. Consume all Rage. Deal [Linear] MAG dmg to up to 3 selected Beasts (base 5), plus 4 additional dmg per Rage consumed. Apply 1 Burn to each target."
				};
			break;
			#endregion		

			#region RAGEHOOK
			case "RAGEHOOK":
				_stct_return_card = {
					_str_card_name : "RAGEHOOK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_ragehook,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "REPOSITION",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_ragehook,
					_str_card_description : "ST. Ranged. Deal [Linear] PHY dmg (base 4). If the caster has at least 2 Rage, move the target forward 1 position."
				};
			break;
			#endregion
		
			#region RAGEPLATE
			case "RAGEPLATE":
				_stct_return_card = {
					_str_card_name : "RAGEPLATE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_rageplate,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 5,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_rageplate,
					_str_card_description : "ST. Self. Consume all Rage. Gain 5 Armor per Rage consumed."
				};
			break;
			#endregion		
		
			#region RAGING_BLOW
			case "RAGING_BLOW":
				_stct_return_card = {
					_str_card_name : "RAGING BLOW",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_raging_blow,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 14,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_raging_blow,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] PHY dmg (base 14)."
				};
			break;
			#endregion		

			#region RAGING_HOWL
			case "RAGING_HOWL":
				_stct_return_card = {
					_str_card_name : "RAGING HOWL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_raging_howl,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "ADJACENT",
					_val_card_magnitude : 1,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_raging_howl,
					_str_card_description : "EXHAUSTS. AoE-3. Ranged. Stun up to 3 selected targets for 1 round."
				};
			break;
			#endregion
	
			#region RAGING_SPARK
			case "RAGING_SPARK":
				_stct_return_card = {
					_str_card_name : "RAGING SPARK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_raging_spark,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DOT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_raging_spark,
					_str_card_description : "ST. Ranged. Consume 1 Rage. Apply 2 Burn."
				};
			break;
			#endregion	
	
			#region RECKLESS_ASSAULT
			case "RECKLESS_ASSAULT":
				_stct_return_card = {
					_str_card_name : "RECKLESS ASSAULT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_reckless_assault,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 8,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_reckless_assault,
					_str_card_description : "ST. Melee. Gain 2 Rage, then deal [Linear] PHY dmg (base 8). The gained Rage increases this attack."
				};
			break;
			#endregion	
	
			#region REKINDLE
			case "REKINDLE":
				_stct_return_card = {
					_str_card_name : "REKINDLE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_rekindle,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "CARD_MANIPULATION",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_rekindle,
					_str_card_description : "EXHAUSTS. GLOBAL. Lose 20% of the caster's maximum HP. Select an exhausted Vermilion card and return it to your hand."
				};
			break;
			#endregion
	
			#region RELENTLESS
			case "RELENTLESS":
				_stct_return_card = {
					_str_card_name : "RELENTLESS",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_relentless,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 10,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_relentless,
					_str_card_description : "EXHAUSTS. ST. Self. Heal the caster for 10 HP. Spend 5 Rage: For 2 rounds, cards cast through the caster do not Exhaust. Gain Boost for 3 rounds."
				};
			break;
			#endregion	
	
			#region RENDING_BLOW
			case "RENDING_BLOW":
				_stct_return_card = {
					_str_card_name : "RENDING BLOW",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_rending_blow,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_rending_blow,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 4). If the target is already Bleeding, apply 1 Bleed."
				};
			break;
			#endregion		

			#region SACRIFICIAL_PYRE
			case "SACRIFICIAL_PYRE":
				_stct_return_card = {
					_str_card_name : "SACRIFICIAL PYRE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_sacrificial_pyre,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "SUMMON",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 4,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_sacrificial_pyre,
					_str_card_description : "EXHAUSTS. ST. Self. Sacrifice all allied Minions and summon an Ash Phoenix (4/4) on the caster. It gains +1 maximum HP and +1 Magnitude for each Minion sacrificed. Each round, it deals 3 NEU dmg per Magnitude and applies Weakness for 1 round. While it lives, the caster gains 15% Dodge."
				};
			break;
			#endregion

			#region SANGUINE_SONG
			case "SANGUINE_SONG":
				_stct_return_card = {
					_str_card_name : "SANGUINE SONG",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_sanguine_song,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "ECHO",
					_str_card_stat : "NEU",
					_str_card_target_count : "GLOBAL",
					_val_card_magnitude : 0,
					_str_card_scalar : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_sanguine_song,
					_str_card_description : "EXHAUSTS. Global. Add 1 rage to caster. Sacrifice 10% of caster's hp. Add 1 to echo counter."
				};
			break;
			#endregion
		
			#region SCORCHING_CLAW
			case "SCORCHING_CLAW":
				_stct_return_card = {
					_str_card_name : "SCORCHING CLAW",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_scorching_claw,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "PHY",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_scorching_claw,
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg. Apply 1 Burn (base 5)."
				};
			break;
			#endregion		
		
			#region SEARING_RAY
			case "SEARING_RAY":
				_stct_return_card = {
					_str_card_name : "SEARING RAY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_searing_ray,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_searing_ray,
					_str_card_description : "EXHAUSTS. ST. Ranged. Pierce Armor and deal [Linear] MAG dmg directly to Overhealth and HP (base 5)."
				};
			break;
			#endregion		
			
			#region SECOND_WIND
			case "SECOND_WIND":
				_stct_return_card = {
					_str_card_name : "SECOND WIND",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_second_wind,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "SELF",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 15,
					_str_card_scalar : "PERCENT",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_second_wind,
					_str_card_description : "EXHAUSTS. ST. Self. Remove all CC from the caster and heal 15% of its maximum HP. The caster's next Attack deals 50% additional direct damage."
				};
			break;
			#endregion			
			
			#region THE_RED_FEAST
			case "THE_RED_FEAST":
				_stct_return_card = {
					_str_card_name : "THE RED FEAST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_the_red_feast,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ARCHETYPE",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "MAG",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 4,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_the_red_feast,
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. For each Beast on the selected team, consume up to 3 Bleed and deal [Linear] MAG dmg per Bleed consumed (base 4). Heal the caster for 100% of the total HP damage dealt. The caster gains Boost for 2 rounds."
				};
			break;
			#endregion			
			
			#region VOLATILE_BRAND
			case "VOLATILE_BRAND":
				_stct_return_card = {
					_str_card_name : "VOLATILE BRAND",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_volatile_brand,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_effect_type : "TRAP",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_vermilion_volatile_brand,
					_str_card_description : "EXHAUSTS. ST. Ranged. Set a Trap on an enemy Beast. When that Beast dies, deal [Linear] MAG dmg to adjacent enemies (base 5) and apply 2 Burn to them."
				};
			break;
			#endregion			

			#region WAR_CRY
			case "WAR_CRY":
				_stct_return_card = {
					_str_card_name : "WAR CRY",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_vermilion_war_cry,
					_arr_card_colors : ["VERMILION",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_effect_type : "BUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "TEAMWIDE",
					_val_card_magnitude : 2,
					_str_card_scalar : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : "SOLDIER",
					_str_card_rarity : "III",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : false,
					_scr_card : scr_card_vermilion_war_cry,
					_str_card_description : "Teamwide. All Beasts on the selected team gain 2 Rage."
				};
			break;
			#endregion
		#endregion

		#region DEFAULT - CARD NOT FOUND YET
			default:
				_stct_return_card = {
					_str_card_name : "BLOCK",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_block,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "SELF",
					_str_card_type : "DEFENSE",
					_str_card_effect_type : "ARMOR",
					_str_card_stat : "NEU",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 6,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_block,
					_str_card_description : "ST. Self. Gain 6 Armor."
				};
			break;
		#endregion
	}

	//================//
	//VALIDATE CARD//
	//================//
	if (_stct_return_card == undefined){
		return undefined;
	}

	//==================//
	//ASSIGN UNIQUE UID//
	//==================//
	_stct_return_card._uid_card = global.uid_next_card;
	global.uid_next_card++;

	return _stct_return_card;
}