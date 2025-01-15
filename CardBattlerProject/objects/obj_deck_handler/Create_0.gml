show_debug_message("[== DECK_HANDLER CREATED ==]");		
///////////////
// VARIABLES //
///////////////
show_debug_message("[== DECK_HANDLER: CREATING HANDS... ==]");	
global.current_hand = ds_list_create();  // List to store the current hand
global.exhausted = ds_list_create();  // List to store the exhausted cards
global.card_selected = undefined;  // Variable to store the selected card
global.echo = false; //checks if there is an echo card active
global.echo_count = 0; //keeps track of how many times the next card will echo
global.casting_phase = false;
show_debug_message("[== DECK_HANDLER: CREATED HANDS! ==]");	

//draw your hand at the beginning of entry into the rm_encounter.
show_debug_message("[== DECK_HANDLER: DRAWING CARDS VIA SCR_DRAW_CARDS... ==]");	
scr_draw_cards();
show_debug_message("[== DECK_HANDLER: DONE DRAWING CARDS! ==]");	