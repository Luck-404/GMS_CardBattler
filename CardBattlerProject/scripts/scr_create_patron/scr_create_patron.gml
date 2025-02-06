//////////////////////////////////////////////////////////////////////
//					SCR_CREATE_PATRONS								//
//																	//
// > CREATE A MAPPED VALUE FOR EACH PATRON TO GO INTO THE PATRONS	//
//	 LIST															//
//////////////////////////////////////////////////////////////////////
function scr_create_patron(_name, _description, _sigil, _starter, _cards, _gear, _gold, _blessings) {
    var _ref_new_patron = ds_map_create();
    ds_map_add(_ref_new_patron, "Name", _name);
    ds_map_add(_ref_new_patron, "Description", _description);
	ds_map_add(_ref_new_patron, "Sigil", _sigil);
    ds_map_add(_ref_new_patron, "Starter", _starter);	
    ds_map_add(_ref_new_patron, "Cards", _cards);	
    ds_map_add(_ref_new_patron, "Gear", _gear);		
    ds_map_add(_ref_new_patron, "Bonus Gold", _gold);	
    ds_map_add(_ref_new_patron, "Blessings", _blessings);		
return _ref_new_patron;
}