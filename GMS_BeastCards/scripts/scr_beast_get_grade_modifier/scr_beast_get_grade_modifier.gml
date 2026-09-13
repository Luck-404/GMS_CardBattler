//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_GRADE_MODIFIER
// FUNCTION: Converts a raw Beast stat into its gameplay modifier.
//           Increases by 0.1 for every 10 stat points.
//           Supports EX scaling above 210 up to a maximum modifier of 3.0.
//
// ARGUMENTS: _val_stat is the raw Beast stat value to convert.
// RETURNS: The gameplay modifier, clamped between 0.1 and 3.0.
//
//===============================================================================//

function scr_beast_get_grade_modifier(_val_stat){

	var _val_modifier = ceil(max(1,_val_stat) / 10) / 10;

	return clamp(_val_modifier,0.1,3.0);
}