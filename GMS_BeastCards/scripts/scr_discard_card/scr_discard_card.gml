//
//
//
//
//
function scr_discard_card(_card){
var _hand = obj_battle_player_controller._battle_hand;
var _discard = obj_battle_player_controller._battle_discard;
//Remove card from hand
	var _index = ds_list_find_index(_hand,_card);
	ds_list_delete(_hand,_index);
//Add it to discard
	ds_list_add(_discard,_card);
//Move its position
	_card.x = room_width-150;
	_card.y = room_height-100;
//Update its location to _location = “DISCARD”
	_card._location = "DISCARD";
	scr_reposition_cards();
}