//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_MELTPLATE
// FUNCTION: Destroys up to 10 target Armor before resolving standard MAG damage.
//           Applies Burn only if Armor was removed and the target survives.
//           Preserves independent Armor-break feedback and normal damage timing.
//
// ARGUMENTS: _stct_card - Meltplate Card struct.
//            _ref_caster - caster; _ref_target - target Beast.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_meltplate(_stct_card,_ref_caster,_ref_target){

	//================//
	//DESTROY ARMOR//
	//================//
	var _stct_armor_result = scr_battle_destroy_armor(_ref_target,10);
	var _val_armor_destroyed = _stct_armor_result._val_armor_removed;

	if (_val_armor_destroyed > 0){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_armor_destroyed) + " ARMOR",
			undefined,
			c_blue,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		//================//
		//ARMOR BREAK VFX//
		//================//
		if (_stct_armor_result._flag_armor_broken){

			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_armor_break,
				undefined,
				undefined,
				4,
				4,
				1,
				0,
				snd_battle_armor_break
			);
		}
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//APPLY BURN//
	//================//
	if (_val_armor_destroyed > 0){

		scr_status_apply_dot("BURN", _ref_target);

	}
}
