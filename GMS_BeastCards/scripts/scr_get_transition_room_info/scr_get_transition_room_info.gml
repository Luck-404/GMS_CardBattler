//
//
// SCRIPT: SCR_GET_TRANSITION_ROOM_INFO | BASED ON THE PASSED DESTINATION AND SOURCE, RETRIEVE THE DESIRED ROOM INFO (ID AND DESCRIPTION) AS WELL AS WHERE TO PLACE THE PLAYER (x,y) | RETURNS ARRAY WITH TRANSITION INFO
//
//
function scr_get_transition_room_info(_to_id,_from_id){
	//INIT RETURN ARRAY
	var _return_arr = ["DEFAULT_ROOM",0,0,"DEFAULT_BANNER_TEXT"];
	
	switch(_to_id){
		#region NORTHWEST
		case "NORTHWEST":
			//ROOM ID
			_return_arr[0] = rm_ow_northwest;
			
			//BANNER TEXT
			_return_arr[1] = "NORTHWEST ROOM";
			
			//PLAYER COORDS
			switch(_from_id){
				case "WEST":
					_return_arr[2] = 530; //x
					_return_arr[3] = 980; //y				
				break;

				case "NORTH":
					_return_arr[2] = 980; //x
					_return_arr[3] = 530; //y					
				break;
			}

		break;
		#endregion
		
		#region NORTH
		case "NORTH":
			//ROOM ID
			_return_arr[0] = rm_ow_north;
			
			//BANNER TEXT
			_return_arr[1] = "NORTH ROOM";	
			
			//PLAYER COORDS
			switch(_from_id){
				case "CENTER":
					_return_arr[2] = 530; //x
					_return_arr[3] = 980; //y				
				break;
				
				case "NORTHWEST":
					_return_arr[2] = 80; //x
					_return_arr[3] = 530; //y					
				break;
				
				case "RANCH":
					_return_arr[2] = 530; //x
					_return_arr[3] = 80; //y					
				break;
				
				case "NORTHEAST":
					_return_arr[2] = 980; //x
					_return_arr[3] = 530; //y					
				break;
			}

		break;
		#endregion
		
		#region NORTHEAST
		case "NORTHEAST":
			//ROOM ID
			_return_arr[0] = rm_ow_northeast;
			
			//BANNER TEXT
			_return_arr[1] = "NORTHEAST ROOM";		
			
			//PLAYER COORDS
			switch(_from_id){
				case "NORTH":
					_return_arr[2] = 80; //x
					_return_arr[3] = 530; //y				
				break;
				
				case "EAST":
					_return_arr[2] = 530; //x
					_return_arr[3] = 980; //y					
				break;
			}


		break;
		#endregion
		
		#region WEST
		case "WEST":
			//ROOM ID
			_return_arr[0] = rm_ow_west;
			
			//BANNER TEXT
			_return_arr[1] = "WEST ROOM";	
			
			//PLAYER COORDS
			switch(_from_id){
				//case "CLOSEDROAD":
				//	_return_arr[2] = 80; //x
				//	_return_arr[3] = 530; //y				
				//break;
				
				case "NORTHWEST":
					_return_arr[2] = 530; //x
					_return_arr[3] = 80; //y					
				break;
				
				case "SOUTHWEST":
					_return_arr[2] = 530; //x
					_return_arr[3] = 980; //y					
				break;
				
				case "CENTER":
					_return_arr[2] = 980; //x
					_return_arr[3] = 530; //y					
				break;
			}
	
		break;
		#endregion
		
		#region CENTER
		case "CENTER":
			//ROOM ID
			_return_arr[0] = rm_ow_center;
			
			//BANNER TEXT
			_return_arr[1] = "CENTER ROOM";		
			
			//PLAYER COORDS
			switch(_from_id){
				case "SOUTH":
					_return_arr[2] = 530; //x
					_return_arr[3] = 980; //y				
				break;
				
				case "WEST":
					_return_arr[2] = 80; //x
					_return_arr[3] = 530; //y					
				break;
				
				case "NORTH":
					_return_arr[2] = 530; //x
					_return_arr[3] = 80; //y					
				break;
				
				case "EAST":
					_return_arr[2] = 980; //x
					_return_arr[3] = 530; //y					
				break;
			}

		break;
		#endregion
		
		#region EAST
		case "EAST":
			//ROOM ID
			_return_arr[0] = rm_ow_east;
			
			//BANNER TEXT
			_return_arr[1] = "EAST ROOM";	
			
			//PLAYER COORDS
			switch(_from_id){
				case "CENTER":
					_return_arr[2] = 80; //x
					_return_arr[3] = 530; //y				
				break;
				
				case "NORTHEAST":
					_return_arr[2] = 530; //x
					_return_arr[3] = 80; //y					
				break;
				
				case "SOUTHEAST":
					_return_arr[2] = 530; //x
					_return_arr[3] = 980; //y					
				break;
				
				case "LAKESIDE":
					_return_arr[2] = 980; //x
					_return_arr[3] = 530; //y					
				break;
			}
	
		break;
		#endregion
		
		#region SOUTHWEST
		case "SOUTHWEST":
			//ROOM ID
			_return_arr[0] = rm_ow_southwest;
			
			//BANNER TEXT
			_return_arr[1] = "SOUTHWEST ROOM";	
			
			//PLAYER COORDS
			switch(_from_id){
				case "WEST":
					_return_arr[2] = 530; //x
					_return_arr[3] = 80; //y				
				break;
				
				case "SOUTH":
					_return_arr[2] = 980; //x
					_return_arr[3] = 530; //y					
				break;
			}
	
		break;
		#endregion
		
		#region SOUTH
		case "SOUTH":
			//ROOM ID
			_return_arr[0] = rm_ow_south;
			
			//BANNER TEXT
			_return_arr[1] = "SOUTH ROOM";	
			
			//PLAYER COORDS
			switch(_from_id){
				case "CENTER":
					_return_arr[2] = 530; //x
					_return_arr[3] = 80; //y				
				break;
				
				case "SOUTHWEST":
					_return_arr[2] = 80; //x
					_return_arr[3] = 530; //y					
				break;
				
				case "SOUTHEAST":
					_return_arr[2] = 980; //x
					_return_arr[3] = 530; //y					
				break;
			}
	
		break;		
		#endregion
		
		#region SOUTHEAST
		case "SOUTHEAST":
			//ROOM ID
			_return_arr[0] = rm_ow_southeast;
			
			//BANNER TEXT
			_return_arr[1] = "SOUTHEAST ROOM";		
			
			//PLAYER COORDS
			switch(_from_id){
				case "SOUTH":
					_return_arr[2] = 80; //x
					_return_arr[3] = 530; //y				
				break;
				
				case "EAST":
					_return_arr[2] = 530; //x
					_return_arr[3] = 80; //y					
				break;
				
				case "MARKET":
					_return_arr[2] = 530; //x
					_return_arr[3] = 980; //y					
				break;
			}

		break;		
		#endregion
		
		#region RANCH
		case "RANCH":
			//ROOM ID
			_return_arr[0] = rm_ow_ranch;
			
			//BANNER TEXT
			_return_arr[1] = "RANCH ROOM";		
			
			//PLAYER COORDS
			_return_arr[2] = 530; //x
			_return_arr[3] = 980; //y

		break;		
		#endregion	
		
		#region MARKET
		case "MARKET":
			//ROOM ID
			_return_arr[0] = rm_ow_market;
			
			//BANNER TEXT
			_return_arr[1] = "MARKET ROOM";		
			
			//PLAYER COORDS
			_return_arr[2] = 530; //x
			_return_arr[3] = 80; //y

		break;		
		#endregion	
		
		#region LAKESIDE
		case "LAKESIDE":
			//ROOM ID
			_return_arr[0] = rm_ow_lakeside;
			
			//BANNER TEXT
			_return_arr[1] = "LAKESIDE ROOM";		
			
			//PLAYER COORDS
			_return_arr[2] = 80; //x
			_return_arr[3] = 530; //y

		break;		
		#endregion			
	}
	
	//RETURN ARRAY
	return _return_arr;
}