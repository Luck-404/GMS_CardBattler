//===============================================================================//
//
// SCRIPT: SCR_MARKET_GET_BEAST_EGG_VALUE
// FUNCTION: Determines the gold value of a Beast egg offer.
//           Uses Beast stat totals, archetype traits, and secondary stats.
//           Returns the purchase cost shown in the Beast egg market.
//
// ARGUMENTS: _stct_beast is the Beast information struct.
// RETURNS: Calculated egg market value with a minimum cost of 100 gold.
//
//===============================================================================//

function scr_market_get_beast_egg_value(_stct_beast){

	//================//
	//VALIDATE BEAST//
	//================//
	if (_stct_beast == undefined){
		return 100;
	}

	//================//
	//BASE STAT VALUE//
	//================//
	var _val_stat_total =
		_stct_beast._val_beast_hp_stat +
		_stct_beast._val_beast_con_stat +
		_stct_beast._val_beast_ppow_stat +
		_stct_beast._val_beast_mpow_stat +
		_stct_beast._val_beast_pdef_stat +
		_stct_beast._val_beast_mdef_stat;

	var _val_cost = 75 + floor(_val_stat_total * 0.75);

	//================//
	//SECONDARY STATS//
	//================//
	_val_cost += _stct_beast._val_beast_min_stat * 15;
	_val_cost += _stct_beast._val_beast_crit_stat * 4;
	_val_cost += _stct_beast._val_beast_dod_stat * 4;

	//================//
	//ARCHETYPE VALUE//
	//================//
	switch (_stct_beast._str_beast_archetype){

		case "MAGICAL":
			_val_cost += 40;
		break;

		case "TECHNICAL":
			_val_cost += 25;
		break;

		case "MARTIAL":
			_val_cost += 10;
		break;
	}

	//================//
	//FINALIZE VALUE//
	//================//
	_val_cost = ceil(_val_cost / 25) * 25;

	return max(100,_val_cost);
}