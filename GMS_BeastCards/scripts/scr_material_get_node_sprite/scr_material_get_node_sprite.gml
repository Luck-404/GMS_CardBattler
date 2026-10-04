//===============================================================================//
//
// SCRIPT: SCR_MATERIAL_GET_NODE_SPRITE
// FUNCTION: Returns the overworld sprite associated with a Material-node type.
//
// ARGUMENTS: _str_material_type - Material-node category.
// RETURNS: Sprite asset, or undefined for an invalid category.
//
//===============================================================================//

function scr_material_get_node_sprite(_str_material_type){

	_str_material_type =
		string_upper(
			string(
				_str_material_type
			)
		);

	switch (_str_material_type){

		case "HERBS":
			return spr_overworld_material_node_herbs;

		case "WOOD":
			return spr_overworld_material_node_wood;

		case "STONE":
			return spr_overworld_material_node_stone;

		case "ORE":
			return spr_overworld_material_node_ore;

		case "HIDE":
			return spr_overworld_material_node_hide;

		case "FIBER":
			return spr_overworld_material_node_fiber;

		case "UNDERGROWTH":
			return spr_overworld_material_node_undergrowth;

		case "BONE":
			return spr_overworld_material_node_bone;
	}

	return undefined;
}