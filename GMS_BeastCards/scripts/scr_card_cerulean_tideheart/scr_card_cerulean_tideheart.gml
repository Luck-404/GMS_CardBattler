//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TIDEHEART
// FUNCTION: Resolves Tideheart.
//           Cleanses all negative statuses from the caster.
//           Adds 1 Echo through the shared Echo resource system.
//
//===============================================================================//

function scr_card_cerulean_tideheart(_stct_card,_ref_caster,_ref_target){

	//-------------------------//
	//CLEANSE NEGATIVE STATUSES//
	//-------------------------//
	scr_cleanse_negative(
		_ref_caster,
		ds_list_size(_ref_caster._list_statuses)
	);

	//-----------//
	//GAIN ECHO//
	//-----------//
	scr_gain_echo(1);
}