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
	// MAIN TYPE		- ATTACK, DEFENSE, SUPPORT, UTILITY, ARCHETYPE
	// STAT TYPE		- NEU, MAG, PHY
	// MAGNITUDE		- int
	// TARGETS			- int
	// ARCHETYPE REQ	- MAGICAL, MARTIAL, TECHNICAL
	// CLASS REQ		- MAGE, SUMMONER, PRIEST, SOLDIER, SAILOR, ADVENTURER, ENGINEER, MERCHANT, HUNTER
	// RARITY			- I, II, III, IV
	// MANA COST		- int
	// EXHAUSTS			- true or false
	// SCRIPT			- script index
	// DESC				- string
	
	var _stct_return_card = undefined;
	
	switch(_str_card_name){
		#region CERULEAN
		
		#endregion
		
		#region VERMILION
		
		#endregion
		
		#region VIRIDIAN
			#region LIFE_SPIRIT
			case "LIFE_SPIRIT":
				_stct_return_card = {
					_str_card_name : "LIFE SPIRIT",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_life_spirit,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "UTILITY",
					_str_card_stat : "NEU",
					_val_card_magnitude : undefined,
					_val_card_targets : 1,
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
			
			#region MIRACLE_MUSA
			case "MIRACLE_MUSA":
				_stct_return_card = {
					_str_card_name : "MIRACLE MUSA",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_miracle_musa,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "SUPPORT",
					_str_card_stat : "NEU",
					_val_card_magnitude : undefined,
					_val_card_targets : 1,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_viridian_miracle_musa,
					_str_card_description : "Ranged, ST, OVERHEALTH by [linear], lasts 3 turns."
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
					_str_card_stat : "NEU",
					_val_card_magnitude : undefined,
					_val_card_targets : 1,
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
			
			#region EMERALD_SLAM
			case "EMERALD_SLAM":
				_stct_return_card = {
					_str_card_name : "EMERALD SLAM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_emerald_slam,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_stat : "NEU",
					_val_card_magnitude : undefined,
					_val_card_targets : 1,
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
			
			#region GROWTH_SIGIL
			case "GROWTH_SIGIL":
				_stct_return_card = {
					_str_card_name : "GROWTH SIGIL",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_growth_sigil,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_stat : "NEU",
					_val_card_magnitude : undefined,
					_val_card_targets : 1,
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
			
			#region EMERALD_WISDOM
			case "EMERALD_WISDOM":
				_stct_return_card = {
					_str_card_name : "EMERALD WISDOM",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_viridian_emerald_wisdom,
					_arr_card_colors : ["VIRIDIAN",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_stat : "NEU",
					_val_card_magnitude : undefined,
					_val_card_targets : 1,
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
		#endregion
		
		#region UNCOLORED
			#region HIDDEN_CARD
			case "HIDDEN_CARD":
				_stct_return_card = {
					_str_card_name : "HIDDEN CARD",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_hidden_card,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_stat : "NEU",
					_val_card_magnitude : 1,
					_val_card_targets : 1,
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
			
			#region STRIKE
			case "STRIKE":
				_stct_return_card = {
					_str_card_name : "STRIKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_strike,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_stat : "NEU",
					_val_card_magnitude : 5,
					_val_card_targets : 1,
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
			
			#region POWER_STRIKE
			case "POWER_STRIKE":
				_stct_return_card = {
					_str_card_name : "POWER STRIKE",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_power_strike,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "MELEE",
					_str_card_type : "ATTACK",
					_str_card_stat : "NEU",
					_val_card_magnitude : 8,
					_val_card_targets : 1,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_power_strike,
					_str_card_description : "Melee, ST, Deals [linear] melee damage."
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
					_str_card_stat : "NEU",
					_val_card_magnitude : 6,
					_val_card_targets : 1,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "I",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_block,
					_str_card_description : "Self, ST, Add [linear] armor to self."
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
					_str_card_stat : "NEU",
					_val_card_magnitude : 12,
					_val_card_targets : 1,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 2,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_bulwark,
					_str_card_description : "Self, ST, Add [linear] armor to self."
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
					_str_card_stat : "NEU",
					_val_card_magnitude : undefined,
					_val_card_targets : 0,
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
			
			#region ECHO
			case "ECHO":
				_stct_return_card = {
					_str_card_name : "ECHO",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_echo,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_stat : "NEU",
					_val_card_magnitude : 1,
					_val_card_targets : 0,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "III",
					_val_card_mana_cost : 0,
					_flag_card_exhausts : true,
					_scr_card : scr_card_uncolored_echo,
					_str_card_description : "Exhausts. Global, Increase echo count by 1, echo causes the next non-echo spell to cast X more times."
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
					_str_card_stat : "NEU",
					_val_card_magnitude : 3,
					_val_card_targets : 1,
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
			
			#region REPOSITION
			case "REPOSITION":
				_stct_return_card = {
					_str_card_name : "REPOSITION",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_reposition,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "TEAM",
					_str_card_type : "UTILITY",
					_str_card_stat : "NEU",
					_val_card_magnitude : 0,
					_val_card_targets : 1,
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
			
			#region CLEARCAST
			case "CLEARCAST":
				_stct_return_card = {
					_str_card_name : "CLEARCAST",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_clearcast,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "GLOBAL",
					_str_card_type : "UTILITY",
					_str_card_stat : "NEU",
					_val_card_magnitude : 0,
					_val_card_targets : 0,
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
			
			#region RAPID_STRIKES
			case "RAPID_STRIKES":
				_stct_return_card = {
					_str_card_name : "RAPID STRIKES",
					_str_card_id : _str_card_name,
					_spr_card : spr_card_uncolored_rapid_strikes,
					_arr_card_colors : ["UNCOLORED",undefined],
					_str_card_range : "RANGED",
					_str_card_type : "ATTACK",
					_str_card_stat : "NEU",
					_val_card_magnitude : 2,
					_val_card_targets : 1,
					_str_card_archetype_req : undefined,
					_str_card_class_req : undefined,
					_str_card_rarity : "II",
					_val_card_mana_cost : 1,
					_flag_card_exhausts : false,
					_scr_card : scr_card_uncolored_rapid_strikes,
					_str_card_description : "Ranged, ST, Deals [linear] damage 3x."
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