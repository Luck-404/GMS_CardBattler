//
// scr_damage_target(_dmg, _tar)
// Minions absorb first (capped), remainder spills to host
//
function scr_damage_target(_dmg, _tar)
{
	var _dmg_left = _dmg;
	
	//ADJUST DAMAGE BASED ON ATTACKER ATK STAT
	if (global.cast_card._ref_card[?"card_stat"] == "PHY"){
		var _pdmg_stat = global.caster_beast._ref_unit[?"beast_ppow_stat"];
		var _pdmg_mod = scr_get_beast_grade_modifier(_pdmg_stat);
		_dmg_left = ceil(_dmg_left*_pdmg_mod);
	}
	if (global.cast_card._ref_card[?"card_stat"] == "MAG"){
		var _mdmg_stat = global.caster_beast._ref_unit[?"beast_mpow_stat"];
		var _mdmg_mod = scr_get_beast_grade_modifier(_mdmg_stat);
		_dmg_left = ceil(_dmg_left*_mdmg_mod);
	}
	
	//TARGET DODGE
	var _dod = global.target_beast._ref_unit[?"beast_dod_stat"];
	var _roll2 = irandom_range(0,100);
	if (_roll2 < _dod){
		scr_spawn_popup_scrolling("TEXT","DODGED",undefined,c_white,_tar.x+irandom_range(-32,32),_tar.y-24+irandom_range(-32,32));		
		exit;
	}	
	
	//crit bonus
	var _crit = global.caster_beast._ref_unit[?"beast_crit_stat"];

	var _roll = irandom_range(0,100);
	if (_roll < _crit){
		_dmg_left = _dmg_left * 2;		
		scr_spawn_popup_scrolling("TEXT","CRIT",undefined,c_maroon,_tar.x+irandom_range(-32,32),_tar.y-24+irandom_range(-32,32));		
	}	
	
	//RAPID GROWTH BONUS DMG
	var _status = scr_check_for_status("WEATHER: RAPID GROWTH",global.statuses);
	if (_status != -1){
		var _arr = global.cast_card._ref_card[?"card_colors"];
		if (_arr[0] = "VIRIDIAN"){
			_dmg_left = ceil(_dmg_left*1.25);	
		}	
	}	

	//check for weakness
	_status = scr_check_for_status("WEAKNESS",global.caster_beast);
	var _weak_stacks = 0;
	if (_status != -1){
		_weak_stacks = _status._status_stacks;
	}
	_dmg_left = _dmg_left-(_weak_stacks*2);
	if (_dmg_left <= 0){
		scr_spawn_popup_scrolling("TEXT","TOO WEAK",undefined,c_white,global.caster_beast.x+irandom_range(-32,32),global.caster_beast.y-24+irandom_range(-32,32));	
		exit;		
	}
	
	//REDUCE DAMAGE BASED ON DEFENDER DEF STAT
	if (global.cast_card._ref_card[?"card_stat"] == "PHY"){
		var _pdef_stat = global.target_beast._ref_unit[?"beast_pdef_stat"];
		var _pdef_mod = scr_get_beast_grade_modifier(_pdef_stat);
		_dmg_left = ceil(_dmg_left* (1 / _pdef_mod));
	}
	if (global.cast_card._ref_card[?"card_stat"] == "MAG"){
		var _mdef_stat = global.target_beast._ref_unit[?"beast_mdef_stat"];
		var _mdef_mod = scr_get_beast_grade_modifier(_mdef_stat);
		_dmg_left = ceil(_dmg_left* (1 / _mdef_mod));
	}	
	
	//----------------------------------------------------
	// PHASE 1: MINIONS SNAPSHOT + EVEN INTEGER SPLIT
	//----------------------------------------------------
	var _minions = _tar._minions;
	var _count = ds_list_size(_minions);

	if (_count > 0 && _dmg_left > 0)
	{
	    var _per = _dmg_left div _count;
	    var _remainder = _dmg_left mod _count;

	    // track how much damage is actually consumed
	    var _total_applied = 0;

	    // iterate backwards so we can safely delete dead minions
	    for (var i = _count - 1; i >= 0; i--)
	    {
	        var _m = ds_list_find_value(_minions, i);
	        if (!instance_exists(_m)) continue;

	        var _take = _per;

	        // distribute remainder to earliest units (stable ordering)
	        if (_remainder > 0)
	        {
	            _take += 1;
	            _remainder -= 1;
	        }

	        // cap by HP
	        var _actual = min(_take, _m._cur_hp);

	        _m._cur_hp -= _actual;
	        _total_applied += _actual;

	        // handle death immediately
	        if (_m._cur_hp <= 0)
	        {
	            _m._cur_hp = 0;
				scr_spawn_popup_scrolling("TEXT","-" + string(_actual),undefined,c_maroon,_tar.x+irandom_range(-32,32),_tar.y-24+irandom_range(-32,32));		
	            ds_list_delete(_minions, i);
	            instance_destroy(_m);
	        }
	    }

	    // reduce remaining damage after minion layer is resolved
	    _dmg_left -= _total_applied;

	    // re-sync minion positions once after cleanup
	    scr_reposition_minions(_tar);
		scr_reposition_statuses(_tar);
	}

    //----------------------------------------------------
    // PHASE 2: HOST ARMOR
    //----------------------------------------------------
    if (_dmg_left > 0 && _tar._armor > 0)
    {
        var _blocked = min(_tar._armor, _dmg_left);
		scr_spawn_popup_scrolling("TEXT","-" + string(_blocked),undefined,c_blue,_tar.x+irandom_range(-32,32),_tar.y-24+irandom_range(-32,32));	
        _tar._armor -= _blocked;
        _dmg_left -= _blocked;
    }

    //----------------------------------------------------
    // PHASE 3: HOST OVERHEALTH
    //----------------------------------------------------
    if (_dmg_left > 0 && _tar._overhealth > 0)
    {
        var _blocked = min(_tar._overhealth, _dmg_left);
		scr_spawn_popup_scrolling("TEXT","-" + string(_blocked),undefined,c_green,_tar.x+irandom_range(-32,32),_tar.y-24+irandom_range(-32,32));	
        _tar._overhealth -= _blocked;
        _dmg_left -= _blocked;
    }

    //----------------------------------------------------
    // PHASE 4: HOST HP
    //----------------------------------------------------
    if (_dmg_left > 0)
    {
		scr_spawn_popup_scrolling("TEXT","-" + string(_dmg_left),undefined,c_maroon,_tar.x+irandom_range(-32,32),_tar.y-24+irandom_range(-32,32));	
        _tar._cur_hp -= _dmg_left;
    }
	
		
}