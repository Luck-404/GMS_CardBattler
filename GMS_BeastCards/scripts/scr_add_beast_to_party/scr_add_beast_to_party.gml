//
//
// SCRIPT: SCR_ADD_BEAST_TO_PARTY | ADDS BEAST TO PARTY IF THERE IS ROOM, OTHERWISE ADDS TO RANCH | RETURNS VOID
//
//
function scr_add_beast_to_party(_new_beast){
	//ATTEMPT TO ADD TO PARTY
	if (ds_list_size(global.player_party) < 5){
		ds_list_add(global.player_party,_new_beast);
	}

	//ADD TO RANCH
	else {
		ds_list_add(global.player_ranch,_new_beast);	
	}
}