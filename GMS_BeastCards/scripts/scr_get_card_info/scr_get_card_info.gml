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
	//                    WEATHER, CARD_DRAW, MANA, TURN, REPOSITION, EVENT
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

				_str_card_description :
					"EXHAUSTS. Teamwide. Summon a Grove Spirit (5/1) on each allied Beast. Each Grove Spirit heals its host for 3 HP per round. Whenever its host gains Armor, the Grove Spirit gains 1 Magnitude and 2 maximum HP. At 10 HP, it also deals 1 NEU dmg per Magnitude to the front enemy each round. At 20 HP, its attacks also Stun for 1 round."
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

				_str_card_description :
					"EXHAUSTS. ST. Self. Remove all DoTs, Debuffs, and CC from all allied Beasts. For each stack removed, permanently increase the caster’s linear damage by 2 and heal the caster for 2 HP."
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
					_str_card_archetype_req : undefined,
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

					_str_card_archetype_req : "MAGICAL",
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

					_str_card_description :
						"EXHAUSTS. Global. Begin the Bloomtide Event."
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

					_str_card_description :
						"ST. Ranged. Grant Thorns for 3 rounds. When attacked, deal 3 NEU dmg to the attacker."
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

					_str_card_description :
						"Self Aura. (+) When this Beast receives a healing effect, adjacent allied Beasts heal for 25% of that effect. (-) This Beast's Maximum HP is reduced by 15%."
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

					_str_card_description :
						"ST. Ranged. Apply Armorbreak for 2 rounds and Vulnerable for 1 round."
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

					_str_card_description :
						"EXHAUSTS. Global. Deal [Linear] MAG dmg 12 times to random enemy Beasts (base 6 per hit)."
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

					_str_card_description :
						"EXHAUSTS. Global. Expend all corpses. For each corpse expended, generate 1 Mana, heal all allied Beasts for 5 HP, and summon a Dormant Seed (1/0) in an available allied Minion slot. If no slot is available, increase an existing allied Minion’s current HP, maximum HP, and Magnitude by 1 instead."
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

					_str_card_description :
						"ST. Ranged. Reduce the target’s PHYPOW by 20 for 3 rounds and prevent repositioning."
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

					_val_card_magnitude : 2,
					_str_card_scalar : "LINEAR",

					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,

					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_cultivate,

					_str_card_description :
						"ST. Ranged. Increase the current HP, maximum HP, and Magnitude of all Minions on the target by 2 for the remainder of battle."
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

					_str_card_description :
						"EXHAUSTS. ST. Ranged. Remove all negative statuses from the target."
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

					_str_card_description :
						"ST. Ranged. Apply Wither for 3 rounds. If the target is Poisoned, Wither lasts 5 rounds instead."
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

					_str_card_description :
						"EXHAUSTS. ST. Ranged. Set a Trap on a Beast. The first Attack that targets it misses. Draw 1 card."
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

				_str_card_description :
					"ST. Ranged. Heal the caster for 5 HP. Apply Drained for 3 rounds. Drained reduces MAGPOW and MAGDEF by 20."
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

					_str_card_description :
						"ST. Melee. Stun the target for 1 round."
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
					_str_card_description : "EXHAUSTS. Global. Draw 2 additional cards per turn for 3 rounds."
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

					_str_card_description :
						"EXHAUSTS. Teamwide. For 6 rounds, whenever an allied Minion dies, replace it with a Dormant Seed (1/0). The Dormant Seed inherits the defeated Minion’s HP and Magnitude bonuses."
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

				_str_card_description :
					"EXHAUSTS. Teamwide. For 5 rounds, whenever an enemy gains Bleed, Poison, or Venom, summon a Sporeling (1/1) on that Beast. If necessary, replace an existing Minion. When a Sporeling is replaced or killed, apply 1 Poison to its host."
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

					_str_card_description :
						"EXHAUSTS. ST. Ranged. Stun the target for 1 round."
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
					_str_card_class_req : undefined,

					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,

					_scr_card : scr_card_viridian_for_the_throat,

					_str_card_description :
						"EXHAUSTS. ST. Melee. Deal [%] PHY dmg (base 30% of target’s maximum HP). Apply 5 Bleed. Stun the caster for 2 rounds. EXECUTE: Heal the caster for 30% of its maximum HP."
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

					_flag_allow_empty_corpse_target : true,
					
					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",

					_str_card_archetype_req : "MAGICAL",
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

					_val_card_magnitude : 0,
					_str_card_scalar : "LINEAR",

					_str_card_archetype_req : "MAGICAL",
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
					_flag_card_exhausts : true,
					_scr_card : scr_card_viridian_greenflow,
					_str_card_description : "EXHAUSTS. ST. Ranged. Deal 5 NEU dmg X times. X equals the number of Minions controlled by the caster."
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
						"ST. Ranged. Swap the caster’s position with the target allied Beast. Heal both Beasts for 3 HP."
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

					_str_card_description :
						"EXHAUSTS. Teamwide. For 5 rounds, whenever an allied Beast receives healing, it gains an equal amount of Armor and each Minion hosted by that Beast gains +1 maximum HP."
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

					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : "SUMMONER",

					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_honeyed_scent,

					_str_card_description :
						"Global. Teamwide Aura. (+) Whenever an allied Beast casts an Attack card, summon a Wasp Drone (2/1) on that Beast. Each Wasp Drone deals 1 NEU dmg per Magnitude to a random enemy each round and applies Weakness for 1 round to another random enemy. (-) The caster has 0 Dodge and takes 10% more damage while this Aura is active."
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
					_str_card_description : "ST. Melee. Deal [Linear] PHY dmg (base 4). Deal 4 additional dmg if the target is Bleeding."
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
					_str_card_rarity : "II",
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

					_str_card_description :
						"ST. Ranged. Heal [Linear] HP (base 6)."
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
						"EXHAUSTS. Global. Gain +1 maximum and current Mana for 3 rounds."
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
						"ST. Self. Gain [Linear] Overhealth for 3 rounds (base 3). Each round, regenerate up to 1 stack's worth of this Overhealth, up to the total granted by all stacks."
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
						"EXHAUSTS. ST. Ranged. Sacrifice the oldest Minion on the target allied Beast. Draw 2 cards and heal that Beast for 5 HP."
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
					_str_card_description : "ST. Ranged. Deal [Linear] MAG dmg (base 4). Deal 1 additional dmg per Poison stack on the target. POISONFLOW: Consume up to 2 Poison. Heal the caster for 2 HP per Poison consumed."
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

					_str_card_description :
						"ST. Self. Heal the caster for 5 HP. Gain Nature’s Bond for 5 rounds. Whenever the caster receives healing, gain 2 Armor per stack."
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

					_str_card_description :
						"ST. Ranged. Remove 1 stack from each DoT and Debuff on the target. Remove any status reduced to 0 stacks."
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

					_str_card_description :
						"Global. For 4 rounds, each allied Beast gains +2 damage and +2 maximum HP for each living Minion attached to it."
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
						"ST. Self. Taunt for 2 rounds. The caster is the only available target for attacks while Taunt is active."
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

					_str_card_description :
						"AoE-2. Ranged. Apply Regeneration to the target and the allied Beast behind it for 3 rounds. Heal [Scalar] HP immediately and each round."
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

					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,

					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_rejuvenate,

					_str_card_description :
						"ST. Ranged. Apply Regeneration for 3 rounds. Heal [Linear] HP at the start of each round (base 5)."
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

					_str_card_description :
						"EXHAUSTS. ST. Self. Gain Boost for 2 rounds. Boost increases damage dealt by 25%."
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
					_str_card_class_req : undefined,

					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_predators_mark,

					_str_card_description :
						"ST. Ranged. Apply Vulnerable. If the target has Bleed, Poison, or Venom, increase Vulnerable’s duration by 1 round."
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

					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,

					_str_card_rarity : "I",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_predatory_scent,

					_str_card_description :
						"ST. Ranged. Apply Focus for 3 rounds. Allied Minions prioritize the target. POISONFLOW: Consume 3 Poison to grow all Minions on the caster by 1."
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

					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,

					_str_card_rarity : "IV",
					_val_card_mana_cost : 3,
					_flag_card_exhausts : true,

					_scr_card : scr_card_viridian_proliferate,

					_str_card_description :
						"EXHAUSTS. Teamwide. Starting with the front enemy Beast, copy all of its DoTs onto the next Beast. Continue toward the back, copying each Beast’s current DoTs onto the next, then reverse direction and repeat until the effect returns to the front Beast."
				};

			break;
			#endregion

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
						"ST. Ranged. Sacrifice a corpse to generate 1 Mana. If no corpse is available, the caster loses 10 HP instead."
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
						"EXHAUSTS. ST. Self. Gain 20 Armor."
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

					_str_card_description :
						"EXHAUSTS. AoE-3. Ranged. Heal up to 3 selected allied Beasts for [Linear] HP (base 12)."
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

					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,

					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,

					_scr_card : scr_card_viridian_rotting_spores,

					_str_card_description :
						"EXHAUSTS. ST. Ranged. Set a Trap on a Beast. The next time that Beast receives healing, cancel the healing, apply 1 Venom, and deal 5 magical damage."
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
					_str_card_archetype_req : "MAGICAL",
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

					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,

					_str_card_rarity : "III",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_seed_the_field,

					_str_card_description :
						"Teamwide. Summon 1 Dormant Seed (1/0) in each available allied Minion slot."
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
						"EXHAUSTS. ST. Self. Summon 3 Serpents (3/1). Each Serpent applies 1 Venom per Magnitude to a random enemy each round."
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

				_str_card_description :
					"ST. Ranged. Blind the target for 3 rounds."
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

					_str_card_description :
						"ST. Ranged. Sleep the target for 3 rounds."
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

					_str_card_description :
						"EXHAUSTS. AoE-3. Ranged. Sleep up to 3 selected enemies for 2 rounds."
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
					_str_card_archetype_req : undefined,
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
					_str_card_rarity : "III",
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

					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,

					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,

					_scr_card : scr_card_viridian_thorn_net,

					_str_card_description :
						"EXHAUSTS. ST. Ranged. Set a Trap on a Beast. The next time that Beast attacks, cancel the Attack, deal 4 damage, and apply Vulnerable."
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

					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,

					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_toxic_hide,

					_str_card_description :
						"ST. Self. Gain Toxic Hide for 3 rounds. When an enemy successfully deals Melee damage to the caster, apply 1 Poison to that enemy per stack."
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

					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,

					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : true,

					_scr_card : scr_card_viridian_toxic_snare,

					_str_card_description :
						"EXHAUSTS. ST. Ranged. Set a Trap on a Beast. At 5 total DoT stacks or 3 different DoTs, Stun it for 1 round and apply 2 Poison to adjacent Beasts."
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
						"EXHAUSTS. Teamwide. Gain 1 Echo. Heal all allied Beasts for 3 HP."
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

					_str_card_description :
						"EXHAUSTS. ST. Ranged. Set a Trap on a Beast. When that Beast dies, apply Poison to adjacent Beasts and summon a Sporeling (1/1) on each. Each Sporeling applies 1 Poison per Magnitude to its host each round."
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

					_str_card_description :
						"EXHAUSTS. Teamwide. Ranged. Heal all allied Beasts for [Linear] HP (base 15)."
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

					_str_card_description :
						"ST. Ranged. Increase the target’s MAGPOW and MAGDEF by 20 for 3 rounds."
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

					_str_card_archetype_req : "MAGICAL",
					_str_card_class_req : undefined,

					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,

					_scr_card : scr_card_viridian_wild_vigor,

					_str_card_description :
						"ST. Ranged. Increase the target’s PHYPOW and PHYDEF by 20 for 3 rounds."
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

				_str_card_description :
					"ST. Ranged. Apply Wither for 3 rounds."
			};

		break;
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
					_str_card_description : "EXHAUSTS. ST. Self. The next card cast by this Beast ignores caster requirements."
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

					_str_card_description :
						"ST. Ranged. Cleanse all Auras from the target."
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
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_thoughtsteal,
					_str_card_description : "EXHAUSTS. ST. Card. Select a revealed enemy card. Gain Mana equal to its Mana cost and disable it for its next cast."
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