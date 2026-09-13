//===============================================================================//
//
// SCRIPT: SCR_TRANSITION_GET_ROOM_INFO
// FUNCTION: Returns destination room transition data.
//           Resolves room, banner text, and player spawn coordinates.
//           Uses destination and source ids to place the player correctly.
//
// ARGUMENTS: _str_to_id is the destination room id.
//            _str_from_id is the source room id.
// RETURNS: Array formatted as [room,banner,x,y].
//
//===============================================================================//

function scr_transition_get_room_info(_str_to_id,_str_from_id){

	//================//
	//INIT RETURN DATA//
	//================//
	var _arr_room_info = [undefined,"DEFAULT_BANNER_TEXT",0,0];

	switch (_str_to_id){

		#region NORTHWEST
		case "NORTHWEST":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_northwest;
			_arr_room_info[1] = "NORTHWEST ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			switch (_str_from_id){

				case "WEST":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 980;
				break;

				case "NORTH":
					_arr_room_info[2] = 980;
					_arr_room_info[3] = 530;
				break;
			}
		break;
		#endregion

		#region NORTH
		case "NORTH":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_north;
			_arr_room_info[1] = "NORTH ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			switch (_str_from_id){

				case "CENTER":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 980;
				break;

				case "NORTHWEST":
					_arr_room_info[2] = 80;
					_arr_room_info[3] = 530;
				break;

				case "RANCH":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 80;
				break;

				case "NORTHEAST":
					_arr_room_info[2] = 980;
					_arr_room_info[3] = 530;
				break;
			}
		break;
		#endregion

		#region NORTHEAST
		case "NORTHEAST":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_northeast;
			_arr_room_info[1] = "NORTHEAST ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			switch (_str_from_id){

				case "NORTH":
					_arr_room_info[2] = 80;
					_arr_room_info[3] = 530;
				break;

				case "EAST":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 980;
				break;
			}
		break;
		#endregion

		#region WEST
		case "WEST":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_west;
			_arr_room_info[1] = "WEST ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			switch (_str_from_id){

				case "NORTHWEST":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 80;
				break;

				case "SOUTHWEST":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 980;
				break;

				case "CENTER":
					_arr_room_info[2] = 980;
					_arr_room_info[3] = 530;
				break;
			}
		break;
		#endregion

		#region CENTER
		case "CENTER":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_center;
			_arr_room_info[1] = "CENTER ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			switch (_str_from_id){

				case "SOUTH":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 980;
				break;

				case "WEST":
					_arr_room_info[2] = 80;
					_arr_room_info[3] = 530;
				break;

				case "NORTH":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 80;
				break;

				case "EAST":
					_arr_room_info[2] = 980;
					_arr_room_info[3] = 530;
				break;
			}
		break;
		#endregion

		#region EAST
		case "EAST":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_east;
			_arr_room_info[1] = "EAST ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			switch (_str_from_id){

				case "CENTER":
					_arr_room_info[2] = 80;
					_arr_room_info[3] = 530;
				break;

				case "NORTHEAST":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 80;
				break;

				case "SOUTHEAST":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 980;
				break;

				case "LAKESIDE":
					_arr_room_info[2] = 980;
					_arr_room_info[3] = 530;
				break;
			}
		break;
		#endregion

		#region SOUTHWEST
		case "SOUTHWEST":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_southwest;
			_arr_room_info[1] = "SOUTHWEST ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			switch (_str_from_id){

				case "WEST":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 80;
				break;

				case "SOUTH":
					_arr_room_info[2] = 980;
					_arr_room_info[3] = 530;
				break;
			}
		break;
		#endregion

		#region SOUTH
		case "SOUTH":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_south;
			_arr_room_info[1] = "SOUTH ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			switch (_str_from_id){

				case "CENTER":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 80;
				break;

				case "SOUTHWEST":
					_arr_room_info[2] = 80;
					_arr_room_info[3] = 530;
				break;

				case "SOUTHEAST":
					_arr_room_info[2] = 980;
					_arr_room_info[3] = 530;
				break;
			}
		break;
		#endregion

		#region SOUTHEAST
		case "SOUTHEAST":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_southeast;
			_arr_room_info[1] = "SOUTHEAST ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			switch (_str_from_id){

				case "SOUTH":
					_arr_room_info[2] = 80;
					_arr_room_info[3] = 530;
				break;

				case "EAST":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 80;
				break;

				case "MARKET":
					_arr_room_info[2] = 530;
					_arr_room_info[3] = 980;
				break;
			}
		break;
		#endregion

		#region RANCH
		case "RANCH":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_ranch;
			_arr_room_info[1] = "RANCH ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			_arr_room_info[2] = 530;
			_arr_room_info[3] = 980;
		break;
		#endregion

		#region MARKET
		case "MARKET":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_market;
			_arr_room_info[1] = "MARKET ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			_arr_room_info[2] = 530;
			_arr_room_info[3] = 80;
		break;
		#endregion

		#region LAKESIDE
		case "LAKESIDE":

			//================//
			//ROOM INFO//
			//================//
			_arr_room_info[0] = rm_ow_lakeside;
			_arr_room_info[1] = "LAKESIDE ROOM";

			//================//
			//PLAYER SPAWN//
			//================//
			_arr_room_info[2] = 80;
			_arr_room_info[3] = 530;
		break;
		#endregion
	}

	//================//
	//RETURN ROOM INFO//
	//================//
	return _arr_room_info;
}