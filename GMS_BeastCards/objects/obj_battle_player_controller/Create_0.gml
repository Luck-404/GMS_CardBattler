//
//
// CREATE: OBJ_BATTLE_PLAYER_CONTROLLER
//
//

//
//VARIABLES
//
_cur_mana = 3;
_max_mana = 3;
_saved_max_mana = 3;
_hand_size = 5;
_draw_amount = 2;


#region BATTLE
	//CARD CASTING
	global.cast_card = undefined;
	global.caster_beast = undefined;
	global.target_beast = undefined;

	global.echo_counter = 0;

	//MINIONS
	_minions_init = false;

	//STATUSES
	global.statuses = ds_list_create();
	_statuses_init = false;
#endregion

//BEASTS
_beasts_list = ds_list_create();
_beasts_alive = ds_list_create();
_beasts_graveyard = ds_list_create();

//DECK
_battle_deck = ds_list_create();
_battle_hand = ds_list_create();
_battle_discard = ds_list_create();
_battle_exhaust = ds_list_create();

//SELECTIONS



//PLAYER STATE
enum PLAYER_STATE{
	INIT_BEASTS,
	INIT_CARDS,
	TRIGGER_ENTRY_EFFECTS,
	WAIT,
	TURN_START,
	TRIGGER_MINIONS,
	SELECT_CARD,
	SELECT_CASTER,
	SELECT_TARGET,
	CARD_EXECUTE,
	TURN_END,
	DISCARD_DOWN
}

_player_state = PLAYER_STATE.INIT_BEASTS;

//CLICK COOLDOWNS
_flag_clicked = false;
_cooldown = 10;

//
//INIT
//

//
//METHODS
//

//
//
//
function scr_check_battle_card_oom(_list){
	for (var _i = 0; _i < ds_list_size(_list); _i++){
		var _card = ds_list_find_value(_list,_i);
		var _card_cost = _card._ref_card[?"card_mana_cost"];
			
		if (_card_cost <= _cur_mana){
			_card._card_oom_check = false;	
		} else {
			_card._card_oom_check = true;	
		}
	}	
}

//
//
//
function scr_check_battle_beast_color(_list)
{
    var _card_color_arr = global.cast_card._ref_card[?"card_colors"];
    var _c1 = _card_color_arr[0];
    var _c2 = _card_color_arr[1];

    for (var _b = 0; _b < ds_list_size(_list); _b++)
    {
        var _beast = ds_list_find_value(_list, _b);
        var _colors = _beast._ref_unit[?"beast_colors"];

        var _b1 = _colors[0];
        var _b2 = _colors[1];

        // default assumption: fail
        var _match = false;

        // UNCOLORED = always valid
        if (_c1 == "UNCOLORED" || _b1 == "UNCOLORED" || _b2 == "UNCOLORED")
        {
            _match = true;
        }
        else
        {
            // check c1
            if (_c1 != undefined && (_c1 == _b1 || _c1 == _b2))
            {
                _match = true;
            }

            // check c2 only if needed
            if (_c2 != undefined && (_c2 == _b1 || _c2 == _b2))
            {
                _match = true;
            }
        }

        _beast._beast_color_check = _match;
    }
}

//
//
//
function scr_check_battle_beast_archetype(_list){
	for (var _b = 0; _b < ds_list_size(_list); _b++){
		var _card_archetype = global.cast_card._ref_card[?"card_archetype_req"];
			
		var _beast = ds_list_find_value(_list,_b);
		var _beast_archetype = _beast._ref_unit[?"beast_archetype"];
		
		_beast._beast_archetype_check = false;	
			
		if (_card_archetype == undefined || _card_archetype == _beast_archetype){
				_beast._beast_archetype_check = true;	
			} else {
				_beast._beast_archetype_check = false;	
		}	
	}
}

//
//
//
function scr_check_battle_beast_class(_list){
		for (var _b = 0; _b < ds_list_size(_list); _b++){
			var _card_class = global.cast_card._ref_card[?"card_class_req"];
			
			var _beast = ds_list_find_value(_list,_b);
			var _beast_class = _beast._ref_unit[?"beast_class"];

			
			if (_card_class == undefined || _card_class == _beast_class){
					_beast._beast_class_check = true;	
				} else {
					_beast._beast_class_check = false;	
				}	
			}
}

//
//
//
function scr_check_battle_beast_range(_list,_range){
// RANGE: SELF, MELEE, RANGED, BACK, GLOBAL
			
	//
	// PLAYER TEAM
	//
	for (var _b = 0; _b < ds_list_size(_list); _b++){
		var _beast_player = ds_list_find_value(_list,_b);
		switch (_range){
			case "SELF":
				//CAN ONLY CAST ON SELF
				if (_beast_player == global.caster_beast){
					_beast_player._beast_range_check = true;	
				} else {
					_beast_player._beast_range_check = false;
				}
			break;
			
			case "MELEE":
				//CAN HIT ANY ALLY WITH A MELEE ATTACK (STAB IN BACK)
				_beast_player._beast_range_check = true;
			break;
					
			case "TEAM":
				//CAN SELECT ANY ALLY FOR TEAM CARD
				if (_beast_player != self){
					_beast_player._beast_range_check = true;
				}
			break;					
			
			case "RANGED":
				//CAN HIT ANY ALLY WITH RANGED ATTACK (STAB IN BACK)
				_beast_player._beast_range_check = true;
			break;
			
			case "BACK":
				//CAN HIT ANY ALLY WITH BACK ATTACK (STAB IN BACK)
				_beast_player._beast_range_check = true;
			break;
		}
	}
			
	//
	// ENEMY TEAM
	//
	for (var _b = 0; _b < ds_list_size(obj_battle_enemy_controller._beasts_alive); _b++){
		var _beast_enemy = ds_list_find_value(obj_battle_enemy_controller._beasts_alive,_b);
		switch (_range){
			case "SELF":
				//CAN ONLY CAST ON SELF
				_beast_enemy._beast_range_check = false;
			break;
			
			case "MELEE":
				//CAN ONLY HIT THE FIRST UNIT
				if (_b == 0){
					_beast_enemy._beast_range_check = true;
				}
				else {
					_beast_enemy._beast_range_check = false;	
				}
			break;
			
			case "RANGED":
				//CAN HIT ANY UNIT WITH A RANGED ATTACK
				_beast_enemy._beast_range_check = true;
			break;
					
			case "TEAM":
				//CAN SELECT NO ENEMY
				_beast_enemy._beast_range_check = false;
			break;						
			
			case "BACK":
				//CAN ONLY HIT THE BACK UNIT
				if (_b == ds_list_size(obj_battle_enemy_controller._beasts_alive)-1){
					_beast_enemy._beast_range_check = true;
				} else {
					_beast_enemy._beast_range_check = false;	
				}
			break;
		}
	}			
}

//
//
//
function scr_reroll_hand()
{
    while (ds_list_size(_battle_hand) > 0)
    {
        var _card = ds_list_find_value(_battle_hand, 0);
        scr_discard_card(_card);
    }

    scr_draw_cards(_draw_amount);

    scr_check_battle_card_oom(_battle_hand);
}

//
//
//
function scr_check_battle_beast_able(_list)
{
    for (var _b = 0; _b < ds_list_size(_list); _b++)
    {
        var _beast = ds_list_find_value(_list, _b);
		
		var _status = scr_check_for_status("STUN",_beast);
		if (_status != -1){
			_beast._beast_able_check = false;
		} else {
			_beast._beast_able_check = true;
		}
    }
}