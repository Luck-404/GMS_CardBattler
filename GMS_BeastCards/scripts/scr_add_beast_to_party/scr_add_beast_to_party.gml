//===============================================================================//
//
// SCRIPT: SCR_ADD_BEAST_TO_PARTY
// FUNCTION: Adds a beast struct to the player party if there is room.
//           Adds the beast struct to the player ranch if the party is full.
//           Returns void.
//
//===============================================================================//

function scr_add_beast_to_party(_stct_new_beast){

	if (ds_list_size(global.player_party) < 5){
		ds_list_add(global.player_party,_stct_new_beast);
	}
	else{
		ds_list_add(global.player_ranch,_stct_new_beast);
	}
}