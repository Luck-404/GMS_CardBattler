//standardize writing everything to a logfile AND the outline... eventually I will have it print to an in-game scroll log too.
function scr_log(_system,_sender,_ref_sender,_message){

	var _logfile_date_and_time = "x";
	
	//make a new log file
	
	//_output_dest = newfile: _logfile_date_and_time + "C:\logfile.txt";
	
	var _str_front = "";
	
	switch(_system){
		case "PLAYER":
		
		break;
		case "CARDS":
			switch(_sender){
				case "LIBRARY":
					
				break;
				
				case "DECK":
					
				break;
				
				case "CARD":
					//get sender's card name
					
					//append "CARD SYSTEM - CARD: [NAME]"
					_str_front = "CARD SYSTEM" + _message;

				break;
			}
		break;
	
	}
	
					
//write to logfile
					
//write to show_debug_message	

}