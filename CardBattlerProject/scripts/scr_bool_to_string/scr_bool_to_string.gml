//////////////////////////////////////////////////////////////////////
//						SCR_BOOL_TO_STRING							//
//																	//
// > CONVERTS A 0 OR 1 TO TRUE/FALSE								//
//////////////////////////////////////////////////////////////////////
function scr_bool_to_string(_bool){
var _output = undefined;

	if (_bool == 1 || _bool == "true"){
		_output = "true";
	} else if (_bool == 0 || _bool == "false"){
		_output = "false";
	}
	
return _output;
}