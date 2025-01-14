// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_create_creature(_name, _champion, _color1, _color2, _subtype, _team, _breed, _hp, _spec, _class, _gear, _markings, _sprite, _hurtsound, _deathsound, _defaultsound) {
    var _ref_new_creature = ds_map_create();
    ds_map_add(_ref_new_creature, "name", _name); //name of creature
    ds_map_add(_ref_new_creature, "champion", _champion); //is a champion or not
    ds_map_add(_ref_new_creature, "color1", _color1); //main color
    ds_map_add(_ref_new_creature, "color2", _color2); //secondary color (or "none")
    ds_map_add(_ref_new_creature, "subtype", _subtype); //subtype
    ds_map_add(_ref_new_creature, "team", _team); //ally or enemy
    ds_map_add(_ref_new_creature, "breed", _breed); //TO DO LATER
    ds_map_add(_ref_new_creature, "hp", _hp); //Total HP stat, based on a number of factors (see the spreadsheet)
    ds_map_add(_ref_new_creature, "spec", _spec); //martial, technical, or magical - certain ones can only use certain cards
    ds_map_add(_ref_new_creature, "class", _class); //solider, sailor, adventurer, hunter, merchant, engineer, mage, necromancer, priest
    ds_map_add(_ref_new_creature, "gearlist", _gear); //dslist of gear
    ds_map_add(_ref_new_creature, "markingslist", _markings); //dslist of markings
	ds_map_add(_ref_new_creature, "sprite", _sprite); //reference to the new creature's sprite
	ds_map_add(_ref_new_creature, "hurtsound", _hurtsound); //reference to the new creature's hurt sound
	ds_map_add(_ref_new_creature, "deathsound", _deathsound); //reference to the new creature's death sound
	ds_map_add(_ref_new_creature, "defaultsound", _defaultsound); //reference to the new creature's default sound	
    return _ref_new_creature;
}