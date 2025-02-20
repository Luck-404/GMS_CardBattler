function scr_get_ui_scalar(){
	var _scalar = 1.0;
	if (global.res_index == 0){
		_scalar = 0.1;	
	}
	if (global.res_index == 1){
		_scalar = 0.5;	
	}
	return _scalar;
}