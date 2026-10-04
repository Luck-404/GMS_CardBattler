//===============================================================================//
//
// CREATE: OBJ_MATERIAL_NODE
// FUNCTION: Initializes one collectible wilderness Material node.
//           The owning Material Spawner assigns the node category after creation,
//           then calls HSCR_MATERIAL_NODE_REFRESH.
//
//===============================================================================//

#region VARIABLES

_str_material_node_type =
	"HERBS";

_ref_material_spawner =
	noone;

_flag_collected =
	false;

_val_interact_distance =
	48;

#endregion

#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_MATERIAL_NODE_REFRESH
// FUNCTION: Applies the correct sprite for this node's assigned Material type.
//-------------------------------------------------------------------------------//
hscr_material_node_refresh = function(){

	_str_material_node_type =
		string_upper(
			string(
				_str_material_node_type
			)
		);

	var _spr_node =
		scr_material_get_node_sprite(
			_str_material_node_type
		);

	if (_spr_node == undefined){

		scr_debug_log(
			"OVERWORLD",
			"MATERIAL_NODE",
			self,
			"MATERIAL NODE REFRESH FAILED" +
			" | TYPE: " +
			_str_material_node_type,
			"WARNING",
			"OBJ_MATERIAL_NODE:HSCR_MATERIAL_NODE_REFRESH"
		);

		return false;
	}

	sprite_index =
		_spr_node;

	image_index =
		0;

	image_speed =
		0;

	return true;
};

#endregion

#region INIT

hscr_material_node_refresh();

#endregion