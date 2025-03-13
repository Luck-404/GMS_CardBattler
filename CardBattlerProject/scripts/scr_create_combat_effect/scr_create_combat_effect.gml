//////////////////////////////////////////////////////////////////////
//						SCR_CREATE_COMBAT_EFFECT					//
//																	//
// > CREATES A COMBAT EFFECT AT THE DESIRED LOCATION				//	
//////////////////////////////////////////////////////////////////////
function scr_create_combat_effect(_tar_obj,_sprite,_tar_x,_tar_y){
	////////////
	// TARGET //
	////////////	
	if (_tar_obj != undefined){
		var _ref_effect = instance_create_layer(_tar_obj.x,_tar_obj.y,"Effects",obj_card_effect);
		_ref_effect.sprite_index = _sprite;
	}
	
	////////////////
	// X/Y COORDS //
	////////////////	
	else {
		var _ref_effect = instance_create_layer(_tar_x,_tar_y,"Effects",obj_card_effect);
		_ref_effect.sprite_index = _sprite;
	}
}