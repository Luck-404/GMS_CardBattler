//===============================================================================//
//
// SCRIPT: SCR_ROLL_MATERIAL
// FUNCTION: Rolls one Material ID from a wilderness Material-node category.
//
//           Paired Material nodes use a 90% common / 10% rare distribution.
//           BONE has only one current Material and always returns ROUGH BONE.
//
// ARGUMENTS: _str_material_type - Material-node category.
// RETURNS: Material Item ID, or undefined for an invalid category.
//
//===============================================================================//

function scr_roll_material(_str_material_type){

	#region VARIABLES

	_str_material_type =
		string_upper(
			string(
				_str_material_type
			)
		);

	var _flag_rare =
		random(100) <
		10;

	#endregion

	#region MATERIAL ROLL

	switch (_str_material_type){

		//=======//
		//HERBS//
		//=======//
		case "HERBS":

			return
				_flag_rare
				? "MATERIAL_LIFEPETAL"
				: "MATERIAL_BLADE_GRASS";

		//======//
		//WOOD//
		//======//
		case "WOOD":

			return
				_flag_rare
				? "MATERIAL_DARKWOOD"
				: "MATERIAL_LIGHTWOOD";

		//=======//
		//STONE//
		//=======//
		case "STONE":

			return
				_flag_rare
				? "MATERIAL_HARDSTONE"
				: "MATERIAL_SOFTSTONE";

		//=====//
		//ORE//
		//=====//
		case "ORE":

			return
				_flag_rare
				? "MATERIAL_CRIMSITE"
				: "MATERIAL_IRON";

		//======//
		//HIDE//
		//======//
		case "HIDE":

			return
				_flag_rare
				? "MATERIAL_DAZZLING_HIDE"
				: "MATERIAL_SIMPLE_HIDE";

		//=======//
		//FIBER//
		//=======//
		case "FIBER":

			return
				_flag_rare
				? "MATERIAL_SILK"
				: "MATERIAL_LINEN";

		//=============//
		//UNDERGROWTH//
		//=============//
		case "UNDERGROWTH":

			return
				_flag_rare
				? "MATERIAL_VINES"
				: "MATERIAL_LEAF_LITTER";

		//======//
		//BONE//
		//======//
		case "BONE":

			return "MATERIAL_ROUGH_BONE";
	}

	#endregion

	#region INVALID

	scr_debug_log(
		"OVERWORLD",
		"MATERIAL",
		undefined,
		"MATERIAL ROLL FAILED" +
		" | TYPE: " +
		_str_material_type +
		" | REASON: INVALID MATERIAL NODE TYPE",
		"WARNING",
		"SCR_ROLL_MATERIAL"
	);

	return undefined;

	#endregion
}