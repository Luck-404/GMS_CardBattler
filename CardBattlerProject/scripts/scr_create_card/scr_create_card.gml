// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_create_card(_name, _description, _cost, _script, _sprite) {
    var card = ds_map_create();
    ds_map_add(card, "name", _name);
    ds_map_add(card, "description", _description);
    ds_map_add(card, "cost", _cost);
    ds_map_add(card, "script", _script);
    ds_map_add(card, "sprite", _sprite);
    return card;
}