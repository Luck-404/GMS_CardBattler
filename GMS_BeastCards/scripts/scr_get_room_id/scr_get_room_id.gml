//
//
// SCR_GET_ROOM_ID
//
//
function scr_get_room_id(_to_id,_from_id){
	var _return_arr = ["DEFAULT_ROOM",0,0,"DEFAULT_BANNER_TEXT"];
	
	switch(_to_id){
		case "NORTHWEST":
			//room id
			_return_arr[0] = rm_northwest;
			//banner text
			_return_arr[1] = "NORTHWEST ROOM";
			
			//player coords
			_return_arr[2] = 0; //x
			_return_arr[3] = 0; //y

		break;
		
		case "NORTH":
			//room id
			_return_arr[0] = rm_north;
			//banner text
			_return_arr[1] = "NORTH ROOM";	
			
			//player coords
			_return_arr[2] = 530; //x
			_return_arr[3] = 980; //y
	
		break;
		
		case "NORTHEAST":
			//room id
			_return_arr[0] = rm_northeast;
			//banner text
			_return_arr[1] = "NORTHEAST ROOM";		
			
			//player coords
			_return_arr[2] = 0; //x
			_return_arr[3] = 0; //y

		break;
		
		case "WEST":
			//room id
			_return_arr[0] = rm_west;
			//banner text
			_return_arr[1] = "WEST ROOM";	
			
			//player coords
			_return_arr[2] = 980; //x
			_return_arr[3] = 530; //y
	
		break;
		
		case "CENTER":
			//room id
			_return_arr[0] = rm_center;
			//banner text
			_return_arr[1] = "CENTER ROOM";		
			
			//player coords
			_return_arr[2] = 0; //x
			_return_arr[3] = 0; //y

		break;
		
		case "EAST":
			//room id
			_return_arr[0] = rm_east;
			//banner text
			_return_arr[1] = "EAST ROOM";	
			
			//player coords
			_return_arr[2] = 80; //x
			_return_arr[3] = 530; //y
	
		break;
		
		case "SOUTHWEST":
			//room id
			_return_arr[0] = rm_southwest;
			//banner text
			_return_arr[1] = "SOUTHWEST ROOM";	
			
			//player coords
			_return_arr[2] = 0; //x
			_return_arr[3] = 0; //y
	
		break;
		
		case "SOUTH":
			//room id
			_return_arr[0] = rm_south;
			//banner text
			_return_arr[1] = "SOUTH ROOM";	
			
			//player coords
			_return_arr[2] = 530; //x
			_return_arr[3] = 80; //y
	
		break;		
		
		case "SOUTHEAST":
			//room id
			_return_arr[0] = rm_southeast;
			//banner text
			_return_arr[1] = "SOUTHEAST ROOM";		
			
			//player coords
			_return_arr[2] = 0; //x
			_return_arr[3] = 0; //y

		break;		
		
	}
	
	return _return_arr;
}