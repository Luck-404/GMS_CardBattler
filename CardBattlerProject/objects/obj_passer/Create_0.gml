//////////////////////////////////////////////////////////////////////
//						OBJ_PASSER CREATE							//
//																	//
// > CARRIES VARIABLES FROM THE NEW GAME PANE IN THE MAIN MENU TO	//
//   THE OBJ_OVERWORLD_PIPELINE TO SPAWN IN THE PLAYER WITH THE		//
//   PROPER STARTING CREATURES, CARDS, GEAR, AND MARKINGS			//		
//////////////////////////////////////////////////////////////////////

//patron (string)
_pass_patron = undefined;

//starter creature (string)
_pass_starter = undefined;

//starting cards (array of strings)
_pass_cards = undefined;

//starting gear (array of strings)
_pass_gear = undefined;

//starting gold (integer)
_pass_gold = 0;

//starting blessing (string)
_pass_blessing = undefined;

// (FOR LOADING ONLY) - SAVEFILE TO LOAD THE GAME DATA FROM
_pass_savefile = undefined;