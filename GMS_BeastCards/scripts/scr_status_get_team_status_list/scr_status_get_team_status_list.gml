//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_TEAM_STATUS_LIST
// FUNCTION: Returns the authoritative Team Status list for PLAYER or ENEMY.
//           Team Statuses are battle-level effects owned by one team rather than
//           attached to one Beast.
//
// ARGUMENTS: _str_team - PLAYER or ENEMY.
// RETURNS: Team Status DS list, or undefined when unavailable.
//
//===============================================================================//

function scr_status_get_team_status_list(_str_team){

	var _str_team_id =
		string_upper(
			string(_str_team)
		);

	switch(_str_team_id){

		case "PLAYER":

			if (
				variable_global_exists("list_statuses_player") &&
				global.list_statuses_player != undefined &&
				ds_exists(global.list_statuses_player,ds_type_list)
			){
				return global.list_statuses_player;
			}

		break;

		case "ENEMY":

			if (
				variable_global_exists("list_statuses_enemy") &&
				global.list_statuses_enemy != undefined &&
				ds_exists(global.list_statuses_enemy,ds_type_list)
			){
				return global.list_statuses_enemy;
			}

		break;
	}

	return undefined;
}