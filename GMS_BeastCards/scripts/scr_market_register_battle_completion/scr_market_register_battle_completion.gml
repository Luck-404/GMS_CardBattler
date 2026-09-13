//===============================================================================//
//
// SCRIPT: SCR_MARKET_REGISTER_BATTLE_COMPLETION
// FUNCTION: Advances the global battle-based market restock counter.
//           Logs restock progress after each completed battle.
//           Restocks all markets after the configured battle threshold.
//
// ARGUMENTS: None.
// RETURNS: True when markets are restocked; otherwise false.
//
//===============================================================================//

function scr_market_register_battle_completion(){

	//================//
	//VALIDATE COUNTER//
	//================//
	if (global.ct_market_restock_battles_max <= 0){

		scr_debug_log(
			"MARKET",
			"RESTOCK",
			undefined,
			"MARKET RESTOCK COUNTER INVALID" +
			" | MAX BATTLES: " +
			string(global.ct_market_restock_battles_max),
			"ERROR",
			"SCR_MARKET_REGISTER_BATTLE_COMPLETION"
		);

		return false;
	}

	//================//
	//ADVANCE COUNTER//
	//================//
	global.ct_market_restock_battles++;

	//================//
	//CHECK RESTOCK//
	//================//
	if (global.ct_market_restock_battles >= global.ct_market_restock_battles_max){

		var _ct_markets_restocked = scr_market_restock_all();

		global.ct_market_restock_battles = 0;

		scr_debug_log(
			"MARKET",
			"RESTOCK",
			undefined,
			"MARKET RESTOCK THRESHOLD REACHED" +
			" | MARKETS CLEARED: " +
			string(_ct_markets_restocked) +
			" | NEXT RESTOCK: " +
			string(global.ct_market_restock_battles_max) +
			" BATTLES",
			"INFO",
			"SCR_MARKET_REGISTER_BATTLE_COMPLETION"
		);

		return true;
	}

	//================//
	//DEBUG PROGRESS//
	//================//
	scr_debug_log(
		"MARKET",
		"RESTOCK",
		undefined,
		"MARKET RESTOCK PROGRESS" +
		" | BATTLES: " +
		string(global.ct_market_restock_battles) +
		"/" +
		string(global.ct_market_restock_battles_max),
		"INFO",
		"SCR_MARKET_REGISTER_BATTLE_COMPLETION"
	);

	return false;
}