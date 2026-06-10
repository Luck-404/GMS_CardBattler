function scr_draw_cards(_amount)
{
    var _base_x = 548;
    var _card_spacing = 15;
    var _card_width = 120;

    var _drawn = 0;

    while (_drawn < _amount)
    {
        //
        // Refill deck if needed
        //
        if (ds_list_size(obj_battle_player_controller._battle_deck) <= 0)
        {
            if (ds_list_size(obj_battle_player_controller._battle_discard) > 0)
            {
                scr_gather_discards();
            }
            else
            {
                break;
            }
        }

        //
        // Draw card
        //
        var _deck = obj_battle_player_controller._battle_deck;

        var _index = irandom(ds_list_size(_deck) - 1);
        var _ref_card = ds_list_find_value(_deck,_index);

        ds_list_add(
            obj_battle_player_controller._battle_hand,
            _ref_card
        );

        ds_list_delete(_deck,_index);

        _ref_card._location = "HAND";

        _drawn++;
    }

    //
    // Reposition hand
    //
    var _hand = obj_battle_player_controller._battle_hand;
    var _hand_size = ds_list_size(_hand);

    var _total_width =
        (_hand_size * _card_width)
        + ((_hand_size - 1) * _card_spacing);

    var _start_x =
        _base_x
        - (_total_width * 0.5)
        + (_card_width * 0.5);

    for (var _i = 0; _i < _hand_size; _i++)
    {
        var _card = ds_list_find_value(_hand,_i);

        _card.x =
            _start_x
            + (_i * (_card_width + _card_spacing));
		_card.y = room_height-100;
    }
}