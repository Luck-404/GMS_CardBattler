//
//
// SCRIPT: ROLL_RANDOM_BEAST | GETS ALL THE BEASTS FROM THE GIVEN POOL AND ROLLS ONE | RETURNS A DSMAP OF A BEAST
//
//
function scr_get_random_beast(_pool){
    var _weights = {
        "ARBRAWN"   : 5,   // R3
        "ARGENTBUD" : 20,  // R2
        "BEAVINE"   : 50,  // R1
		//BRYOBITE
		//CHITROOPER
		//CRUSABER
		//DRYADAE
		//FIGHTREE
        "FLITSAGE"  : 50,  // R1
        "FURN"      : 20   // R2
		//LEPOROOT
		//LUMBUCK
		//MAMBARK
		//MORELUSH
		//SPOROSE
		//STRIGIBLOOM
		//TURFRANTULA
		//AMMOMARSH
		//BLIZZDRIFT
		//CAUDAQUA
		//CEPHARIME
		//CHELONSEA
		//CORALLIARC
		//FROSTUSK
		//GALENATRIUM
		//GLACIMIGHT
		//GULFllOW
		//ISTIRAIN
		//KELPLATANI
		//LONTRIVER
		//MARITIMICE
		//SALTWAGG
		//SPHENISKIP
		//ASCHEMASS
		//CANIGNIS
		//DAIMONIS
		//DRAKOAL
		//EMBEROOST
		//HELLSHROOM
		//IMPARCH
		//INFERNUS
		//LAVAROWANA
		//PYREKNIGHT
		//PYROPLUME
		//SANGUINAUT
		//SLAGOLEM
		//SOLEMOLD
		//WRATHOOD
		//WYRMELTA
    };

    var _total_weight = 0;

    // Sum weights for beasts in pool
    for (var _i = 0; _i < array_length(_pool); _i++)
    {
        var _name = _pool[_i];

        if (variable_struct_exists(_weights, _name))
        {
            _total_weight += variable_struct_get(_weights, _name);
        }
    }

    // Roll
    var _roll = irandom_range(1, _total_weight);

    // Resolve roll
    var _running = 0;
    var _beast_name = "";

    for (var _i = 0; _i < array_length(_pool); _i++)
    {
        var _name = _pool[_i];

        if (variable_struct_exists(_weights, _name))
        {
            _running += variable_struct_get(_weights, _name);

            if (_roll <= _running)
            {
                _beast_name = _name;
                break;
            }
        }
    }

	//MAKE NEW UNIT OF THE ROLLED TYPE
	return scr_init_beast_random(_beast_name);
	
}