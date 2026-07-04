//===============================================================================//
//
// SCRIPT: SCR_MARKET_REGISTER_BATTLE_COMPLETE
// FUNCTION: Advances the global battle-based market restock counter.
//           Restocks all markets every configured number of completed battles.
//
//===============================================================================//
function scr_market_register_battle_complete(){

	global.ct_market_restock_battles++;

	if (global.ct_market_restock_battles >= global.ct_market_restock_battles_max){
		global.ct_market_restock_battles = 0;
		scr_market_restock_all();
	}
}