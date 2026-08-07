//===============================================================================//
//
// SCRIPT: scr_get_card_info
// FUNCTION: Returns a new card struct from an input card ID.
// Stores all card data as struct variables instead of ds_map entries.
// Assigns a unique card UID before returning the card.
//
//===============================================================================//
function scr_get_card_info(_str_card_name){
	// NAME				- string
	// SPRITE			- sprite index
	// COLOR(S)			- ["COLOR1","COLOR2"] or ["COLOR1",undefined]
	// RANGE			- SELF, MELEE, RANGED, BACK, GLOBAL, TEAN
	// MAIN TYPE        - ATTACK, DEFENSE, SUPPORT, UTILITY, ARCHETYPE
	// EFFECT TYPE      - DIRECT, DOT, DEBUFF, CC, BUFF, ARMOR, HEAL, SUMMON,
	//                    WEATHER, CARD_DRAW, MANA, TURN, REPOSITION,
	//                    CARD_MANIPULATION, OTHER
	// STAT TYPE        - NEU, MAG, PHY
	// TARGET COUNT     - SELF, ST, ADJACENT, TEAMWIDE, GLOBAL, CARD
	// MAGNITUDE		- int
	// TARGETS			- int
	// ARCHETYPE REQ	- MAGICAL, MARTIAL, TECHNICAL
	// CLASS REQ		- MAGE, SUMMONER, PRIEST, SOLDIER, SAILOR, ADVENTURER, ENGINEER, MERCHANT, HUNTER
	// RARITY			- I, II, III, IV
	// MANA COST		- int
	// EXHAUSTS			- true or false
	// SCRIPT			- script index
	// DESC				- string
	
	var _stct_return_card = {
					_str_card_name : "DEFAULT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DIRECT",
					_str_card_stat : "NEU",
					_val_card_magnitude : undefined,
					_str_card_scalar : "LINEAR",
					_str_card_target_count : "ST",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_strike,
					_str_card_description : "DEFAULT"
				};
	
	switch(_str_card_name){
		#region VIRIDIAN

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
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_beastial_wrath,
					_str_card_description : "AoE-2. Melee. Deal [Linear] phy dmg to the front two Beasts (base 6). Stun the front target."
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
					_str_card_description : "ST. Ranged. Deal [Linear] mag dmg (base 4)."
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
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Deal [%] mag dmg (10% of target max hp)."
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
					_str_card_description : "ST. Ranged. Grant 7 Armor."
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

					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,

					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_blooming_sprite,

					_str_card_description :
						"ST. Ranged. Summon a 2 HP Blooming Sprite. While alive, it grants its host +5 linear damage."
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
					_str_card_effect_type : "WEATHER",
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

					_str_card_description :
						"EXHAUSTS. Global. Summons the Bloomtide weather event."
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
					_str_card_description : "ST. Ranged. Deal 4 neutral dmg and apply 1 Poison stack."
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
					_str_card_description : "AOE-3. Ranged. Deal [Linear] mag dmg to up to 3 selected beasts."
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
					_str_card_description : "ST. Melee. Deal [Linear] phy dmg (base 5)."
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
					_str_card_type : "ATTACK",
					_str_card_effect_type : "DEBUFF",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : undefined,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_disease,
					_str_card_description : "Ranged, ST, Weaken for 3 rounds"
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

					_str_card_description :
						"EXHAUSTS. ST. Ranged. Set a Trap on a friendly Beast. The first enemy Attack that targets it misses. Draw 1 card."
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

					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : "SUMMONER",

					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_dormant_seed,

					_str_card_description : "ST. Ranged. Spawn one Dormant Seed minion. After 2 rounds, it transforms into a random Viridian minion."
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
					_str_card_type : "ATTACK",
					_str_card_effect_type : "CC",
					_str_card_stat : "NEU",
					_str_card_target_count : "ST",
					_val_card_magnitude : undefined,
					_str_card_archetype_req : "MARTIAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_emerald_slam,
					_str_card_description : "Melee, ST, Stun for 1 turn"
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
					_str_card_description : "Exhausts. Global. Draw 2 more cards per turn, also heal lowest beast."
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
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [%] phy dmg (base 15% of target max hp)."
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
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_feral_frenzy,
					_str_card_description : "ST. Melee. Deal [Linear] phy dmg 3 times."
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
					_str_card_stat : "NEU",
					_str_card_target_count : "CORPSE",

					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",

					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,

					_str_card_rarity : "III",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,

					_scr_card : scr_card_viridian_fungal_recycling,

					_str_card_description : "EXHAUSTS. Global. Sacrifice a corpse. Return a random exhausted Viridian card to the draw pile. If no corpse is available, caster loses 10 HP instead."
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

					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",

					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,

					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_germinate,

					_str_card_description : "ST. Ranged. Hatch all existing Dormant Seeds on target, then summon 2 Dormant Seeds."
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
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_greenflow,
					_str_card_description : "EXHAUSTS. ST. Ranged. Fire X magic bolts dealing 5 dmg each. X is equal to minions controlled by the caster."
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

					_str_card_description :
						"ST. Ranged. Swap places with target. Heal both caster and target for 3 HP."
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
					_str_card_description : "Exhausts. Global. Set up rapid growth weather."
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
					_str_card_description : "ST. Melee. Deal [Linear] phy dmg (base 4). Deal 4 additional damage to Bleeding targets."
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
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_hunters_javelin,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [Linear] phy dmg (base 10)."
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
					_str_card_description : "ST. Self. Gain [Linear] Armor (base 3). Scales with PHYPOW."
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
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_life_spirit,
					_str_card_description : "Ranged, ST, Summons 2/2 Life Spirit that heals host for +2 each round."
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

					_str_card_description :
						"EXHAUSTS. Global. Generate 1 extra mana for 3 rounds."
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

					_str_card_description :
						"ST. Self. Gain [Linear] Overhealth for 3 turns (base 3). Scales with MAGPOW."
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

					_val_card_magnitude : 5,
					_str_card_scalar : "LINEAR",

					_str_card_archetype_req : "TECHNICAL",
					_str_card_class_req : undefined,

					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,

					_scr_card : scr_card_viridian_natural_cycle,

					_str_card_description :
						"EXHAUSTS. ST. Ranged. Sacrifice the oldest Minion on target ally. Draw 2 cards and heal its former host for 5 HP."
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
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_natural_recovery,
					_str_card_description : "ST. Ranged. Grant 4 Armor. Cleanse 1 CC; if none, cleanse 1 DoT. Heal 4 HP."
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
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] mag dmg (base 12)."
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
					_str_card_description : "ST. Ranged. Deal [Linear] mag dmg (base 4). Deal 1 additional dmg per Poison stack on the target."
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
					_str_card_description : "EXHAUSTS. ST. Ranged. Apply 20 Armor."
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
					_str_card_description : "ST. Melee. Deal [Linear] phy dmg 3 times (base 3 per hit). Each hit deals +1 dmg for every 5 Armor on the caster."
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
					_str_card_description : "AoE-3. Self. Grant [Linear] Armor to self and adjacent Beasts (base 4). Scales with PHYPOW."
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

					_str_card_description :
						"ST. Self. Taunt. Be the only available target for 2 rounds."
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
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_potent_spore,
					_str_card_description : "ST. Ranged. Apply 3 Poison stacks to the selected target."
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
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [Linear] mag dmg (base 10)."
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
					_str_card_description : "ST. Melee. Deal [Linear] phy dmg (base 4). Apply 1 Bleed stack."
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
					_str_card_description : "EXHAUSTS. ST. Ranged. Gain 8 Armor at the end of each turn for 5 rounds."
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

					_str_card_description :
						"ST. Ranged. Sacrifice a corpse to generate 1 Mana. If no corpse is available, caster loses 10 HP instead."
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

					_str_card_description :
						"EXHAUSTS. ST. Self. Apply 20 Armor."
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
					_str_card_description : "EXHAUSTS. AoE-3. Ranged. Deal 8 dmg to each unit. Poisoned targets take 1 additional dmg per stack."
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

					_str_card_range : "ENEMY",
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

					_scr_card : scr_card_viridian_rotting_spores,

					_str_card_description :
						"EXHAUSTS. Trap. Place on an enemy Beast. The next time that Beast receives healing, cancel the healing, apply 1 Venom, and deal 5 magical damage."
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
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_savage_maul,
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] phy dmg (base 12)."
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
					_str_card_description : "EXHAUSTS. ST. Ranged. Second Life: The next time target would be defeated, restore it to 25% maximum HP instead. Lasts 4 turns."
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
					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_seed_barrage,
					_str_card_description : "Teamwide. Ranged. Deal [Linear] mag dmg 4 times to random targets on the selected team (base 4)."
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

					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,

					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_seed_the_field,

					_str_card_description :
						"Teamwide. Spawn one Dormant Seed in each available allied Minion slot."
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

					_str_card_description :
						"EXHAUSTS. ST. Self. Summon 3 Serpents (3/3). Each Serpent attacks a random enemy and applies 1 Venom each round."
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
					_str_card_stat : "MAG",
					_str_card_target_count : "SELF",
					_val_card_magnitude : 3,
					_str_card_scalar : "LINEAR",
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_sinewy_vines,
					_str_card_description : "ST. Self. Apply [Linear] Armor - scales with MAGPOW (base 3)."
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
					_str_card_description : "EXHAUSTS. ST. Melee. Deal [Linear] phy dmg (base 4). Apply Vulnerable if health is hit."
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
					_str_card_description : "EXHAUSTS. ST. Melee. Pierce armor and deal [Linear] phy dmg to overhp+health directly (Base 3)."
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
					_str_card_description : "ST. Ranged. Deal [Linear] phy dmg (base 4)."
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
					_str_card_description : "ST. Melee. Deal [Linear] mag dmg (base 4). Apply 1 Venom stack."
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
					_str_card_description : "EXHAUSTS. ST. Melee. Pierce armor and deal [Linear] mag dmg to overhp+health directly (Base 3)."
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
					_str_card_description : "ST. Ranged. Deal [Linear] phy dmg (base 3). Apply 1 Venom stack."
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
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal [%] mag dmg (base 12% of target max hp)."
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
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_stalking_swipe,
					_str_card_description : "ST. Flank. Deal [Linear] phy dmg (base 5)."
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
					_str_card_description : "EXHAUSTS. Teamwide. Deal [%] phy dmg (15% of target max hp)."
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
					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_steelfur,
					_str_card_description : "EXHAUSTS. ST. Self. Double Armor."
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
					_str_card_description : "EXHAUSTS. ST. Ranged. Link target with caster. Redirect the target's next incoming damage instance to the caster."
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
					_str_card_description : "ST. Self. Apply 6 Armor. Apply 1 additional Armor for each status hosted."
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

					_str_card_range : "ENEMY",
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

					_scr_card : scr_card_viridian_thorn_net,

					_str_card_description :
						"EXHAUSTS. Trap. Place on an enemy Beast. The next time that Beast attacks, cancel the Attack, deal 4 damage, and apply Vulnerable."
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
					_str_card_description : "EXHAUSTS. Teamwide. Ranged. Deal [Linear] mag dmg to the selected enemy team twice (base 8 per hit)."
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
					_str_card_description : "ST. Self. Apply 4 Armor. Gain Thorns."
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
					_str_card_description : "Teamwide. Consume all Poison from each target. Deal 2 neutral dmg per Poison stack consumed from that target."
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

					_str_card_range : "ENEMY",
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

					_scr_card : scr_card_viridian_toxic_snare,

					_str_card_description :
						"EXHAUSTS. Trap. Place on an enemy Beast. At 5 total DoT stacks or 3 different DoTs, Stun it and apply 2 Poison to adjacent enemies."
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

					_str_card_description :
						"EXHAUSTS. Teamwide. Add 1 Echo. Heal all allied Beasts for 3 HP."
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
					_str_card_description : "ST. Flank. Deal [Linear] mag dmg (base 5)."
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

					_str_card_range : "ENEMY",
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

					_str_card_description :
						"EXHAUSTS. Trap. Place on an enemy Beast. When it dies, apply Poison and summon a Sporeling on each adjacent Beast."
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
					_val_card_magnitude : 4,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_verdant_bolt,
					_str_card_description : "Ranged, ST, deal [linear] dmg, applies 1 dot stack at random (Poison, Bleed, Venom)."
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
					_str_card_description : "ST. Ranged. Deal [Linear] mag dmg 3 times."
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
					_str_card_description : "AoE-3. Ranged. Deal [Linear] phy dmg (base 5). Apply 1 Poison to each target."
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
					_str_card_description : "ST. Melee. Deal [Linear] mag dmg (base 5)."
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
					_str_card_description : "EXHAUSTS. Teamwide. Apply [Linear] Armor to all allied Beasts (base 12)."
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
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,
					_scr_card : scr_card_uncolored_artifact_hourglass,
					_str_card_description : "Exhausts. After this turn ends, take another full turn."
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
					_str_card_description : "Self, ST, Add 6 armor to self."
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
					_str_card_description : "Self, ST, Add 12 armor to self."
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
					_str_card_description : "Exhausts. Global, Clear all weather"
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
					_str_card_description : "Backline, ST, Deals [linear] damage, apply one bleed stack"
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
					_str_card_description : "Exhausts. Global, Increase echo count by 1, echo causes the next non-echo spell to cast X more times."
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
					_str_card_description : "Exhausts. Global. Draw a card."
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
					_str_card_description : "Exhausts. Global, Generates 1 bonus mana per turn, effect lasts 3 turns."
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
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
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
					_str_card_description : "Exhausts. The next spell cast by this unit ignores caster requirements."
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
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_power_strike,
					_str_card_description : "Melee, ST, Deals 8 melee damage."
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
					_str_card_description : "Ranged, ST, Deals 2 damage three times."
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
					_str_card_description : "Self, ST, Swap Positions with another team unit"
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
					_str_card_description : "Melee, ST, Deal [linear] damage, pierce armor and overhealth."
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
					_str_card_description : "Exhausts. Apply 5 random DoTs to a target."
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
					_str_card_description : "Melee, ST, Deals [linear] melee damage."
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
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_thoughtsteal,
					_str_card_description : "Exhausts. Select a revealed enemy card. Gain Mana equal to its cost and disable it for its next cast."
				};

			break;
			#endregion
		#endregion
	}
	
	if (_stct_return_card == undefined){
		return undefined;
	}
	
	_stct_return_card._uid_card = global.uid_next_card;
	global.uid_next_card++;
	
	return _stct_return_card;
}
