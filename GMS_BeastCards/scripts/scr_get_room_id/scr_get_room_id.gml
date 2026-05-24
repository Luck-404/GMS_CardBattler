//
//
// SCR_GET_ROOM_ID
//
//
function scr_get_room_id(_to_id,_from_id){
	var _return_arr = ["DEFAULT_ROOM",0,0,"DEFAULT_BANNER_TEXT"];
	
	switch(_to_id){
		#region NORTHWEST
		case "NORTHWEST":
			//room id
			_return_arr[0] = rm_northwest;
			//banner text
			_return_arr[1] = "NORTHWEST ROOM";
			
			//player coords
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
			//room id
			_return_arr[0] = rm_north;
			//banner text
			_return_arr[1] = "NORTH ROOM";	
			
			//player coords
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
			//room id
			_return_arr[0] = rm_northeast;
			//banner text
			_return_arr[1] = "NORTHEAST ROOM";		
			
			//player coords
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
			//room id
			_return_arr[0] = rm_west;
			//banner text
			_return_arr[1] = "WEST ROOM";	
			
			//player coords
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
			//room id
			_return_arr[0] = rm_center;
			//banner text
			_return_arr[1] = "CENTER ROOM";		
			
			//player coords
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
			//room id
			_return_arr[0] = rm_east;
			//banner text
			_return_arr[1] = "EAST ROOM";	
			
			//player coords
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
			//room id
			_return_arr[0] = rm_southwest;
			//banner text
			_return_arr[1] = "SOUTHWEST ROOM";	
			
			//player coords
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
			//room id
			_return_arr[0] = rm_south;
			//banner text
			_return_arr[1] = "SOUTH ROOM";	
			
			//player coords
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
			//room id
			_return_arr[0] = rm_southeast;
			//banner text
			_return_arr[1] = "SOUTHEAST ROOM";		
			
			//player coords
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
			//room id
			_return_arr[0] = rm_ranch;
			//banner text
			_return_arr[1] = "RANCH ROOM";		
			
			//player coords
			_return_arr[2] = 530; //x
			_return_arr[3] = 980; //y

		break;		
		#endregion	
		
		#region MARKET
		case "MARKET":
			//room id
			_return_arr[0] = rm_market;
			//banner text
			_return_arr[1] = "MARKET ROOM";		
			
			//player coords
			_return_arr[2] = 530; //x
			_return_arr[3] = 80; //y

		break;		
		#endregion	
		
		#region LAKESIDE
		case "LAKESIDE":
			//room id
			_return_arr[0] = rm_lakeside;
			//banner text
			_return_arr[1] = "LAKESIDE ROOM";		
			
			//player coords
			_return_arr[2] = 80; //x
			_return_arr[3] = 530; //y

		break;		
		#endregion			
		
	}
	
	return _return_arr;
}