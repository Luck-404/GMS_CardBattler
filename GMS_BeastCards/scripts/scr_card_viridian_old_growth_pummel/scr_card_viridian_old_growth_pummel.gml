//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_OLD_GROWTH_PUMMEL
// FUNCTION: Resolves Old Growth Pummel.
//           Deals 3 separate physical damage hits.
//           Each hit gains +1 damage for every 5 Armor on the caster.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_old_growth_pummel(_stct_card,_ref_caster,_ref_target){

	//======================//
	//CALCULATE ARMOR BONUS//
	//======================//
	var _val_armor_bonus = floor(_ref_caster._val_armor / 5);
	var _val_damage = _stct_card._val_card_magnitude + _val_armor_bonus;

	//====================//
	//DEAL DAMAGE 3 TIMES//
	//====================//
	repeat (3){

		if (!instance_exists(_ref_target) || _ref_target._val_cur_hp <= 0){
			break;
		}

		scr_battle_damage_target(_val_damage,_ref_target);
	}
}