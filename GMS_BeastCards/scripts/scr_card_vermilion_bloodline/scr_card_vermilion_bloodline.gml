//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODLINE
// FUNCTION: Requests one Attack Card from the player's draw pile.
//           Attack Cards of every color are eligible.
//
//===============================================================================//

function scr_card_vermilion_bloodline(_stct_card,_ref_caster,_ref_target){

	//================//
	//REQUEST TUTOR//
	//================//
	obj_battle_player_controller.hscr_battle_request_utility_tutor(
		_stct_card._val_card_magnitude,
		"ATTACK",
		"BLOODLINE"
	);
}