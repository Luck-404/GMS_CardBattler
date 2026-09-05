//===============================================================================//
//
// SCR_DEGRADE_SHIELD
// FUNCTION: Reduces a beast's armor at the start of its turn.
//           Armor decay depends on the beast's archetype.
//
//===============================================================================//
function scr_degrade_shield(_ref_beast){

	var _str_archetype = _ref_beast._ref_unit._str_beast_archetype;

	switch (_str_archetype){

		case "MARTIAL":
			// Lose 10% of current armor
			_ref_beast._val_armor = floor(_ref_beast._val_armor * 0.9);
		break;

		case "TECHNICAL":
			// Lose 10% of current armor
			_ref_beast._val_armor = floor(_ref_beast._val_armor * 0.9);
		break;

		case "MAGICAL":
			// Lose 10% of current armor
			_ref_beast._val_armor = floor(_ref_beast._val_armor * 0.9);
		break;

		case "OTHER":
			// Lose 10% of current armor
			_ref_beast._val_armor = floor(_ref_beast._val_armor * 0.9);
		break;
	}
}