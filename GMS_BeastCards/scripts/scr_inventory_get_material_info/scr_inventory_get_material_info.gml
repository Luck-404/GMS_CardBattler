//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_GET_MATERIAL_INFO
// FUNCTION: Returns display data for a Material item ID.
//           Materials are stackable inventory resources used by quests,
//           construction, upgrades, and other progression systems.
//
// ARGUMENTS: _str_item_id - Material item ID to resolve.
// RETURNS: Material information struct, or undefined when the ID is invalid.
//
//===============================================================================//

function scr_inventory_get_material_info(_str_item_id){

	#region MATERIAL DATA

	switch (_str_item_id){

		case "MATERIAL_BLADE_GRASS":

			return {
				_str_item_id : "MATERIAL_BLADE_GRASS",
				_str_item_name : "BLADE GRASS",
				_spr_item : spr_item_material_blade_grass,
				_str_item_desc : "A tough grass with sharp, blade-like leaves. Used as a crafting material."
			};

		case "MATERIAL_CRIMSITE":

			return {
				_str_item_id : "MATERIAL_CRIMSITE",
				_str_item_name : "CRIMSITE",
				_spr_item : spr_item_material_crimsite,
				_str_item_desc : "A dense crimson mineral. Used for specialized crafting and upgrades."
			};

		case "MATERIAL_DARKWOOD":

			return {
				_str_item_id : "MATERIAL_DARKWOOD",
				_str_item_name : "DARKWOOD",
				_spr_item : spr_item_material_darkwood,
				_str_item_desc : "Dense, dark timber from hardy trees. Used for construction and crafting."
			};

		case "MATERIAL_DAZZLING_HIDE":

			return {
				_str_item_id : "MATERIAL_DAZZLING_HIDE",
				_str_item_name : "DAZZLING HIDE",
				_spr_item : spr_item_material_dazzling_hide,
				_str_item_desc : "A lustrous and unusually patterned hide. Used for high-grade crafting."
			};

		case "MATERIAL_HARDSTONE":

			return {
				_str_item_id : "MATERIAL_HARDSTONE",
				_str_item_name : "HARDSTONE",
				_spr_item : spr_item_material_hardstone,
				_str_item_desc : "Dense, durable stone. Used for sturdy construction and upgrades."
			};

		case "MATERIAL_IRON":

			return {
				_str_item_id : "MATERIAL_IRON",
				_str_item_name : "IRON",
				_spr_item : spr_item_material_iron,
				_str_item_desc : "A common workable metal. Used for tools, construction, and upgrades."
			};

		case "MATERIAL_LEAF_LITTER":

			return {
				_str_item_id : "MATERIAL_LEAF_LITTER",
				_str_item_name : "LEAF LITTER",
				_spr_item : spr_item_material_leaf_litter,
				_str_item_desc : "Fallen leaves and forest debris gathered for use as an organic material."
			};

		case "MATERIAL_LIFEPETAL":

			return {
				_str_item_id : "MATERIAL_LIFEPETAL",
				_str_item_name : "LIFEPETAL",
				_spr_item : spr_item_material_lifepetal,
				_str_item_desc : "A vibrant petal rich with natural energy. Used in natural crafting and upgrades."
			};

		case "MATERIAL_LIGHTWOOD":

			return {
				_str_item_id : "MATERIAL_LIGHTWOOD",
				_str_item_name : "LIGHTWOOD",
				_spr_item : spr_item_material_lightwood,
				_str_item_desc : "Light, workable timber. Used for construction and crafting."
			};

		case "MATERIAL_LINEN":

			return {
				_str_item_id : "MATERIAL_LINEN",
				_str_item_name : "LINEN",
				_spr_item : spr_item_material_linen,
				_str_item_desc : "A sturdy woven plant fiber. Used for clothwork and crafting."
			};

		case "MATERIAL_ROUGH_BONE":

			return {
				_str_item_id : "MATERIAL_ROUGH_BONE",
				_str_item_name : "ROUGH BONE",
				_spr_item : spr_item_material_rough_bone,
				_str_item_desc : "Unrefined bone gathered from Beasts. Used as a crafting material."
			};

		case "MATERIAL_SILK":

			return {
				_str_item_id : "MATERIAL_SILK",
				_str_item_name : "SILK",
				_spr_item : spr_item_material_silk,
				_str_item_desc : "A fine, durable fiber. Used for high-quality clothwork and crafting."
			};

		case "MATERIAL_SIMPLE_HIDE":

			return {
				_str_item_id : "MATERIAL_SIMPLE_HIDE",
				_str_item_name : "SIMPLE HIDE",
				_spr_item : spr_item_material_simple_hide,
				_str_item_desc : "A basic Beast hide. Used for leatherwork and crafting."
			};

		case "MATERIAL_SOFTSTONE":

			return {
				_str_item_id : "MATERIAL_SOFTSTONE",
				_str_item_name : "SOFTSTONE",
				_spr_item : spr_item_material_softstone,
				_str_item_desc : "A softer, easily worked stone. Used for construction and crafting."
			};

		case "MATERIAL_VINES":

			return {
				_str_item_id : "MATERIAL_VINES",
				_str_item_name : "VINES",
				_spr_item : spr_item_material_vines,
				_str_item_desc : "Tough plant fibers useful for binding and natural crafting."
			};
	}

	#endregion

	return undefined;
}