//===============================================================================//
//
// SCRIPT: SCR_GET_TRANSITION_ROOM_INFO
// FUNCTION: Returns destination room transition data.
//           Resolves room id, banner text, and player spawn coordinates.
//           Uses destination id and source id to place player correctly.
//
//===============================================================================//
function scr_get_transition_room_info(_str_to_id,_str_from_id){
	//INIT RETURN ARRAY
	var _arr_return = ["DEFAULT_ROOM",0,0,"DEFAULT_BANNER_TEXT"];
	
	switch(_str_to_id){
		#region NORTHWEST
		case "NORTHWEST":
			//ROOM ID
			_arr_return[0] = rm_ow_northwest;
			
			//BANNER TEXT
			_arr_return[1] = "NORTHWEST ROOM";
			
			//PLAYER COORDS
			switch(_str_from_id){
				case "WEST":
					_arr_return[2] = 530; //x
					_arr_return[3] = 980; //y				
				break;

				case "NORTH":
					_arr_return[2] = 980; //x
					_arr_return[3] = 530; //y					
				break;
			}

		break;
		#endregion
		
		#region NORTH
		case "NORTH":
			//ROOM ID
			_arr_return[0] = rm_ow_north;
			
			//BANNER TEXT
			_arr_return[1] = "NORTH ROOM";	
			
			//PLAYER COORDS
			switch(_str_from_id){
				case "CENTER":
					_arr_return[2] = 530; //x
					_arr_return[3] = 980; //y				
				break;
				
				case "NORTHWEST":
					_arr_return[2] = 80; //x
					_arr_return[3] = 530; //y					
				break;
				
				case "RANCH":
					_arr_return[2] = 530; //x
					_arr_return[3] = 80; //y					
				break;
				
				case "NORTHEAST":
					_arr_return[2] = 980; //x
					_arr_return[3] = 530; //y					
				break;
			}

		break;
		#endregion
		
		#region NORTHEAST
		case "NORTHEAST":
			//ROOM ID
			_arr_return[0] = rm_ow_northeast;
			
			//BANNER TEXT
			_arr_return[1] = "NORTHEAST ROOM";		
			
			//PLAYER COORDS
			switch(_str_from_id){
				case "NORTH":
					_arr_return[2] = 80; //x
					_arr_return[3] = 530; //y				
				break;
				
				case "EAST":
					_arr_return[2] = 530; //x
					_arr_return[3] = 980; //y					
				break;
			}


		break;
		#endregion
		
		#region WEST
		case "WEST":
			//ROOM ID
			_arr_return[0] = rm_ow_west;
			
			//BANNER TEXT
			_arr_return[1] = "WEST ROOM";	
			
			//PLAYER COORDS
			switch(_str_from_id){
				//case "CLOSEDROAD":
				//	_arr_return[2] = 80; //x
				//	_arr_return[3] = 530; //y				
				//break;
				
				case "NORTHWEST":
					_arr_return[2] = 530; //x
					_arr_return[3] = 80; //y					
				break;
				
				case "SOUTHWEST":
					_arr_return[2] = 530; //x
					_arr_return[3] = 980; //y					
				break;
				
				case "CENTER":
					_arr_return[2] = 980; //x
					_arr_return[3] = 530; //y					
				break;
			}
	
		break;
		#endregion
		
		#region CENTER
		case "CENTER":
			//ROOM ID
			_arr_return[0] = rm_ow_center;
			
			//BANNER TEXT
			_arr_return[1] = "CENTER ROOM";		
			
			//PLAYER COORDS
			switch(_str_from_id){
				case "SOUTH":
					_arr_return[2] = 530; //x
					_arr_return[3] = 980; //y				
				break;
				
				case "WEST":
					_arr_return[2] = 80; //x
					_arr_return[3] = 530; //y					
				break;
				
				case "NORTH":
					_arr_return[2] = 530; //x
					_arr_return[3] = 80; //y					
				break;
				
				case "EAST":
					_arr_return[2] = 980; //x
					_arr_return[3] = 530; //y					
				break;
			}

		break;
		#endregion
		
		#region EAST
		case "EAST":
			//ROOM ID
			_arr_return[0] = rm_ow_east;
			
			//BANNER TEXT
			_arr_return[1] = "EAST ROOM";	
			
			//PLAYER COORDS
			switch(_str_from_id){
				case "CENTER":
					_arr_return[2] = 80; //x
					_arr_return[3] = 530; //y				
				break;
				
				case "NORTHEAST":
					_arr_return[2] = 530; //x
					_arr_return[3] = 80; //y					
				break;
				
				case "SOUTHEAST":
					_arr_return[2] = 530; //x
					_arr_return[3] = 980; //y					
				break;
				
				case "LAKESIDE":
					_arr_return[2] = 980; //x
					_arr_return[3] = 530; //y					
				break;
			}
	
		break;
		#endregion
		
		#region SOUTHWEST
		case "SOUTHWEST":
			//ROOM ID
			_arr_return[0] = rm_ow_southwest;
			
			//BANNER TEXT
			_arr_return[1] = "SOUTHWEST ROOM";	
			
			//PLAYER COORDS
			switch(_str_from_id){
				case "WEST":
					_arr_return[2] = 530; //x
					_arr_return[3] = 80; //y				
				break;
				
				case "SOUTH":
					_arr_return[2] = 980; //x
					_arr_return[3] = 530; //y					
				break;
			}
	
		break;
		#endregion
		
		#region SOUTH
		case "SOUTH":
			//ROOM ID
			_arr_return[0] = rm_ow_south;
			
			//BANNER TEXT
			_arr_return[1] = "SOUTH ROOM";	
			
			//PLAYER COORDS
			switch(_str_from_id){
				case "CENTER":
					_arr_return[2] = 530; //x
					_arr_return[3] = 80; //y				
				break;
				
				case "SOUTHWEST":
					_arr_return[2] = 80; //x
					_arr_return[3] = 530; //y					
				break;
				
				case "SOUTHEAST":
					_arr_return[2] = 980; //x
					_arr_return[3] = 530; //y					
				break;
			}
	
		break;		
		#endregion
		
		#region SOUTHEAST
		case "SOUTHEAST":
			//ROOM ID
			_arr_return[0] = rm_ow_southeast;
			
			//BANNER TEXT
			_arr_return[1] = "SOUTHEAST ROOM";		
			
			//PLAYER COORDS
			switch(_str_from_id){
				case "SOUTH":
					_arr_return[2] = 80; //x
					_arr_return[3] = 530; //y				
				break;
				
				case "EAST":
					_arr_return[2] = 530; //x
					_arr_return[3] = 80; //y					
				break;
				
				case "MARKET":
					_arr_return[2] = 530; //x
					_arr_return[3] = 980; //y					
				break;
			}

		break;		
		#endregion
		
		#region RANCH
		case "RANCH":
			//ROOM ID
			_arr_return[0] = rm_ow_ranch;
			
			//BANNER TEXT
			_arr_return[1] = "RANCH ROOM";		
			
			//PLAYER COORDS
			_arr_return[2] = 530; //x
			_arr_return[3] = 980; //y

		break;		
		#endregion	
		
		#region MARKET
		case "MARKET":
			//ROOM ID
			_arr_return[0] = rm_ow_market;
			
			//BANNER TEXT
			_arr_return[1] = "MARKET ROOM";		
			
			//PLAYER COORDS
			_arr_return[2] = 530; //x
			_arr_return[3] = 80; //y

		break;		
		#endregion	
		
		#region LAKESIDE
		case "LAKESIDE":
			//ROOM ID
			_arr_return[0] = rm_ow_lakeside;
			
			//BANNER TEXT
			_arr_return[1] = "LAKESIDE ROOM";		
			
			//PLAYER COORDS
			_arr_return[2] = 80; //x
			_arr_return[3] = 530; //y

		break;		
		#endregion			
	}
	
	//RETURN ARRAY
	return _arr_return;
}