//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_SACRIFICIAL_PYRE
// FUNCTION: Sacrifices every allied Minion while suppressing Endless Bloom
//           replacement for those sacrifices, then summons an Ash Phoenix and
//           grants +1 Maximum HP and +1 Magnitude per Minion sacrificed.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is unused for this Self-target Card.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_vermilion_sacrificial_pyre(_stct_card,_ref_caster,_ref_target){

	#region VALIDATION

	
	if (
		_ref_caster._str_list != "ALIVE" ||
		_ref_caster._val_cur_hp <= 0
	){
		return;
	}

	//================//
	//GET ALLIED TEAM//
	//================//
	var _list_allies = scr_battle_get_target_team_list(
		_ref_caster
	);

	if (
		_list_allies == undefined ||
		!ds_exists(_list_allies,ds_type_list)
	){
		return;
	}

	#endregion

	#region SACRIFICE MINIONS

	//================//
	//SACRIFICE ALL ALLIED MINIONS//
	//================//
	var _stct_sacrifice = scr_battle_sacrifice(
		"MINION",
		_ref_caster,
		"ALL",
		{
			teamwide : true,
			suppress_endless_bloom : true
		}
	);

	var _ct_sacrificed = _stct_sacrifice._ct_sacrificed;

	#endregion

	#region SUMMON ASH PHOENIX

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (
		_ref_caster._str_list != "ALIVE" ||
		_ref_caster._val_cur_hp <= 0
	){
		return;
	}

	//================//
	//SUMMON PHOENIX//
	//================//
	var _ref_phoenix = scr_minion_init(
		"ASH_PHOENIX",
		_stct_card,
		_ref_caster,
		_ref_caster
	);

	if (!instance_exists(_ref_phoenix)){
		return;
	}

	//================//
	//GAIN MAX HP//
	//================//
	_ref_phoenix._val_max_hp += _ct_sacrificed;

	//================//
	//GAIN CURRENT HP//
	//================//
	_ref_phoenix._val_cur_hp = _ref_phoenix._val_max_hp;

	//================//
	//GAIN MAGNITUDE//
	//================//
	_ref_phoenix._val_magnitude += _ct_sacrificed;

	//================//
	//UPDATE MINION//
	//================//
	scr_minion_reposition(_ref_caster);

	//================//
	//SUMMON FEEDBACK//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"ASH PHOENIX +" + string(_ct_sacrificed),
		undefined,
		c_red,
		_ref_phoenix.x,
		_ref_phoenix.y - 32
	);

	#endregion
}