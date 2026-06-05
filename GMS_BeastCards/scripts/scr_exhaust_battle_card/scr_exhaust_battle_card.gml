//
//
//
//
//
function scr_exhaust_battle_card(_card){
var _hand = obj_battle_player_controller._battle_hand;
var _exhaust = obj_battle_player_controller._battle_exhaust;
//Remove card from hand
	var _index = ds_list_find_index(_hand,_card);
	ds_list_delete(_hand,_index);
//Add it to _exhaust
	ds_list_add(_exhaust,_card);
//Move its position
	_card.x = room_width-70;
	_card.y = room_height-100;	
//Update its location to _location = “_exhaust”
	_card._location = "EXHAUST";
}