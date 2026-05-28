//
//
// SCRIPT: SCR_GET_BEAST_TYPE_SHADOW | SWITCH TO RETRIEVE THE SHADOW OF THE INPUT TYPE | RETURNS SPRITE REF OF APPROPRIATE TYPE
//
//
function scr_get_beast_type_shadow(_type){

	//
	// TYPE SWITCH | SWITCH BETWEEN INPUT TYPE
	//
	switch(_type){
		#region CERULEAN
			
		#endregion
		
		#region VERMILION
			
		#endregion
		
		#region VIRIDIAN
			case "BOTANICAL":
				return spr_beast_viridian_shadow_botanical;
			
			case "NATURAL":
				return spr_beast_viridian_shadow_natural;
			
			case "WILD":
				return spr_beast_viridian_shadow_wild;
		#endregion
	}
}