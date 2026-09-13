//===============================================================================//
//
// SCRIPT: SCR_MARKET_GET_PRISM_COST
// FUNCTION: Returns the current vendor cost for a prism offer.
//           Increases cost by 25% of base cost per previous purchase.
//           Rounds the result up to the nearest 25 gold.
//
// ARGUMENTS: _stct_offer is the prism market offer struct.
// RETURNS: Current prism purchase cost.
//
//===============================================================================//

function scr_market_get_prism_cost(_stct_offer){

	//================//
	//VALIDATE OFFER//
	//================//
	if (_stct_offer == undefined){
		return 9999;
	}

	//================//
	//CALCULATE COST//
	//================//
	var _val_base_cost = _stct_offer._val_base_cost;
	var _ct_bought = _stct_offer._ct_bought;

	var _val_cost = _val_base_cost + floor(_val_base_cost * 0.25 * _ct_bought);

	//================//
	//ROUND COST//
	//================//
	_val_cost = ceil(_val_cost / 25) * 25;

	return _val_cost;
}