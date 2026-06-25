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
					card_name : "LIFE SPIRIT",
					card_sprite : spr_card_viridian_life_spirit,
					card_colors : ["VIRIDIAN",undefined],
					card_range : "RANGED",
					card_type : "UTILITY",
					card_stat : "NEU",
					card_magnitude : undefined,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "II",
					card_mana_cost : 1,
					card_exhausts : false,
					card_script : scr_card_viridian_life_spirit,
					card_description : "Ranged, ST, Summons 2/2 Life Spirit that heals host for +2 each round."
				};
			break;
			#endregion
			
			#region MIRACLE_MUSA
			case "MIRACLE_MUSA":
				_stct_return_card = {
					card_name : "MIRACLE MUSA",
					card_sprite : spr_card_viridian_miracle_musa,
					card_colors : ["VIRIDIAN",undefined],
					card_range : "RANGED",
					card_type : "SUPPORT",
					card_stat : "NEU",
					card_magnitude : undefined,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "II",
					card_mana_cost : 1,
					card_exhausts : false,
					card_script : scr_card_viridian_miracle_musa,
					card_description : "Ranged, ST, OVERHEALTH by [linear], lasts 3 turns."
				};
			break;
			#endregion
			
			#region DISEASE
			case "DISEASE":
				_stct_return_card = {
					card_name : "DISEASE",
					card_sprite : spr_card_viridian_disease,
					card_colors : ["VIRIDIAN",undefined],
					card_range : "RANGED",
					card_type : "ATTACK",
					card_stat : "NEU",
					card_magnitude : undefined,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "II",
					card_mana_cost : 2,
					card_exhausts : false,
					card_script : scr_card_viridian_disease,
					card_description : "Ranged, ST, Weaken for 3 rounds"
				};
			break;
			#endregion
			
			#region EMERALD_SLAM
			case "EMERALD_SLAM":
				_stct_return_card = {
					card_name : "EMERALD SLAM",
					card_sprite : spr_card_viridian_emerald_slam,
					card_colors : ["VIRIDIAN",undefined],
					card_range : "MELEE",
					card_type : "ATTACK",
					card_stat : "NEU",
					card_magnitude : undefined,
					card_targets : 1,
					card_archetype_req : "MARTIAL",
					card_class_req : undefined,
					card_rarity : "I",
					card_mana_cost : 2,
					card_exhausts : false,
					card_script : scr_card_viridian_emerald_slam,
					card_description : "Melee, ST, Stun for 1 turn"
				};
			break;
			#endregion
			
			#region GROWTH_SIGIL
			case "GROWTH_SIGIL":
				_stct_return_card = {
					card_name : "GROWTH SIGIL",
					card_sprite : spr_card_viridian_growth_sigil,
					card_colors : ["VIRIDIAN",undefined],
					card_range : "GLOBAL",
					card_type : "UTILITY",
					card_stat : "NEU",
					card_magnitude : undefined,
					card_targets : 1,
					card_archetype_req : "MAGICAL",
					card_class_req : undefined,
					card_rarity : "III",
					card_mana_cost : 3,
					card_exhausts : true,
					card_script : scr_card_viridian_growth_sigil,
					card_description : "Exhausts. Global. Set up rapid growth weather."
				};
			break;
			#endregion
			
			#region EMERALD_WISDOM
			case "EMERALD_WISDOM":
				_stct_return_card = {
					card_name : "EMERALD WISDOM",
					card_sprite : spr_card_viridian_emerald_wisdom,
					card_colors : ["VIRIDIAN",undefined],
					card_range : "GLOBAL",
					card_type : "UTILITY",
					card_stat : "NEU",
					card_magnitude : undefined,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "III",
					card_mana_cost : 3,
					card_exhausts : true,
					card_script : scr_card_viridian_emerald_wisdom,
					card_description : "Exhausts. Global. Draw 2 more cards per turn, also heal lowest beast."
				};
			break;
			#endregion
		#endregion
		
		#region UNCOLORED
			#region HIDDEN_CARD
			case "HIDDEN_CARD":
				_stct_return_card = {
					card_name : "HIDDEN CARD",
					card_sprite : spr_card_uncolored_hidden_card,
					card_colors : ["UNCOLORED",undefined],
					card_range : "GLOBAL",
					card_type : "UTILITY",
					card_stat : "NEU",
					card_magnitude : 1,
					card_targets : 1,
					card_archetype_req : "TECHNICAL",
					card_class_req : undefined,
					card_rarity : "I",
					card_mana_cost : 0,
					card_exhausts : true,
					card_script : scr_card_uncolored_hidden_card,
					card_description : "Exhausts. Global. Draw a card."
				};
			break;
			#endregion
			
			#region STRIKE
			case "STRIKE":
				_stct_return_card = {
					card_name : "STRIKE",
					card_sprite : spr_card_uncolored_strike,
					card_colors : ["UNCOLORED",undefined],
					card_range : "MELEE",
					card_type : "ATTACK",
					card_stat : "NEU",
					card_magnitude : 5,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "I",
					card_mana_cost : 1,
					card_exhausts : false,
					card_script : scr_card_uncolored_strike,
					card_description : "Melee, ST, Deals [linear] melee damage."
				};
			break;
			#endregion
			
			#region POWER_STRIKE
			case "POWER_STRIKE":
				_stct_return_card = {
					card_name : "POWER STRIKE",
					card_sprite : spr_card_uncolored_power_strike,
					card_colors : ["UNCOLORED",undefined],
					card_range : "MELEE",
					card_type : "ATTACK",
					card_stat : "NEU",
					card_magnitude : 8,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "II",
					card_mana_cost : 1,
					card_exhausts : false,
					card_script : scr_card_uncolored_power_strike,
					card_description : "Melee, ST, Deals [linear] melee damage."
				};
			break;
			#endregion
			
			#region BLOCK
			case "BLOCK":
				_stct_return_card = {
					card_name : "BLOCK",
					card_sprite : spr_card_uncolored_block,
					card_colors : ["UNCOLORED",undefined],
					card_range : "SELF",
					card_type : "DEFENSE",
					card_stat : "NEU",
					card_magnitude : 6,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "I",
					card_mana_cost : 1,
					card_exhausts : false,
					card_script : scr_card_uncolored_block,
					card_description : "Self, ST, Add [linear] armor to self."
				};
			break;
			#endregion
			
			#region BULWARK
			case "BULWARK":
				_stct_return_card = {
					card_name : "BULWARK",
					card_sprite : spr_card_uncolored_bulwark,
					card_colors : ["UNCOLORED",undefined],
					card_range : "SELF",
					card_type : "DEFENSE",
					card_stat : "NEU",
					card_magnitude : 12,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "II",
					card_mana_cost : 2,
					card_exhausts : false,
					card_script : scr_card_uncolored_bulwark,
					card_description : "Self, ST, Add [linear] armor to self."
				};
			break;
			#endregion
			
			#region INSPIRATION
			case "INSPIRATION":
				_stct_return_card = {
					card_name : "INSPIRATION",
					card_sprite : spr_card_uncolored_inspiration,
					card_colors : ["UNCOLORED",undefined],
					card_range : "GLOBAL",
					card_type : "UTILITY",
					card_stat : "NEU",
					card_magnitude : undefined,
					card_targets : 0,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "II",
					card_mana_cost : 1,
					card_exhausts : true,
					card_script : scr_card_uncolored_inspiration,
					card_description : "Exhausts. Global, Generates 1 bonus mana per turn, effect lasts 3 turns."
				};
			break;
			#endregion
			
			#region ECHO
			case "ECHO":
				_stct_return_card = {
					card_name : "ECHO",
					card_sprite : spr_card_uncolored_echo,
					card_colors : ["UNCOLORED",undefined],
					card_range : "GLOBAL",
					card_type : "UTILITY",
					card_stat : "NEU",
					card_magnitude : 1,
					card_targets : 0,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "III",
					card_mana_cost : 0,
					card_exhausts : true,
					card_script : scr_card_uncolored_echo,
					card_description : "Exhausts. Global, Increase echo count by 1, echo causes the next non-echo spell to cast X more times."
				};
			break;
			#endregion
			
			#region DEFT_STRIKE
			case "DEFT_STRIKE":
				_stct_return_card = {
					card_name : "DEFT STRIKE",
					card_sprite : spr_card_uncolored_deft_strike,
					card_colors : ["UNCOLORED",undefined],
					card_range : "BACK",
					card_type : "ATTACK",
					card_stat : "NEU",
					card_magnitude : 3,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "II",
					card_mana_cost : 1,
					card_exhausts : false,
					card_script : scr_card_uncolored_deft_strike,
					card_description : "Backline, ST, Deals [linear] damage, apply one bleed stack"
				};
			break;
			#endregion
			
			#region RESPOSITION
			case "RESPOSITION":
				_stct_return_card = {
					card_name : "RESPOSITION",
					card_sprite : spr_card_uncolored_reposition,
					card_colors : ["UNCOLORED",undefined],
					card_range : "TEAM",
					card_type : "UTILITY",
					card_stat : "NEU",
					card_magnitude : 0,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "I",
					card_mana_cost : 0,
					card_exhausts : false,
					card_script : scr_card_uncolored_reposition,
					card_description : "Self, ST, Swap Positions with another team unit"
				};
			break;
			#endregion
			
			#region CLEARCAST
			case "CLEARCAST":
				_stct_return_card = {
					card_name : "CLEARCAST",
					card_sprite : spr_card_uncolored_clearcast,
					card_colors : ["UNCOLORED",undefined],
					card_range : "GLOBAL",
					card_type : "UTILITY",
					card_stat : "NEU",
					card_magnitude : 0,
					card_targets : 0,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "I",
					card_mana_cost : 1,
					card_exhausts : true,
					card_script : scr_card_uncolored_clearcast,
					card_description : "Exhausts. Global, Clear all weather"
				};
			break;
			#endregion
			
			#region RAPID_STRIKES
			case "RAPID_STRIKES":
				_stct_return_card = {
					card_name : "RAPID STRIKES",
					card_sprite : spr_card_uncolored_rapid_strikes,
					card_colors : ["UNCOLORED",undefined],
					card_range : "RANGED",
					card_type : "ATTACK",
					card_stat : "NEU",
					card_magnitude : 2,
					card_targets : 1,
					card_archetype_req : undefined,
					card_class_req : undefined,
					card_rarity : "II",
					card_mana_cost : 1,
					card_exhausts : false,
					card_script : scr_card_uncolored_rapid_strikes,
					card_description : "Ranged, ST, Deals [linear] damage 3x."
				};
			break;
			#endregion
		#endregion
	}
	
	if (_stct_return_card == undefined){
		return undefined;
	}
	
	_stct_return_card.card_uid = global.card_uid;
	global.card_uid++;
	
	return _stct_return_card;
}