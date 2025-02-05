//////////////////////////////////////////////////////////////////////
//					SCR_CREATE_BLESSINGS							//
//																	//
// > CREATE A MAPPED VALUE FOR A BLESSING THAT A PATRON HAS.		//
//////////////////////////////////////////////////////////////////////
function scr_create_blessing(_name, _description) {
    var _ref_new_blessing = ds_map_create();
    ds_map_add(_ref_new_blessing, "Name", _name);
    ds_map_add(_ref_new_blessing, "Descripion", _description);	
	return _ref_new_blessing;
}