//
//
//
//
//
function scr_gather_battle_discards ()
{
    var _deck = obj_battle_player_controller._battle_deck;
    var _discard = obj_battle_player_controller._battle_discard;

    while (ds_list_size(_discard) > 0)
    {
        var _card = ds_list_find_value(_discard,0);

        ds_list_delete(_discard,0);
        ds_list_add(_deck,_card);

        _card.x = 70;
		_card.y = room_height-100;
        _card._location = "DECK";
    }

    ds_list_shuffle(_deck);
}