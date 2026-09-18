//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_MELTPLATE
// FUNCTION: Resolves Meltplate.
//           Destroys up to 10 Armor before dealing linear Magical damage.
//           If any Armor was destroyed, applies 1 Burn to the surviving target.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_meltplate(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//DESTROY ARMOR//
	//================//
	var _val_armor_before = _ref_target._val_armor;
	var _val_armor_destroyed = min(10,_ref_target._val_armor);

	if (_val_armor_destroyed > 0){

		_ref_target._val_armor -= _val_armor_destroyed;

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
		if (
			_val_armor_before > 0 &&
			_ref_target._val_armor <= 0
		){

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
		_stct_card._val_card_magnitude,
		_ref_target
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

		var _ref_original_target = global.ref_target_beast;

		global.ref_target_beast = _ref_target;

		scr_status_apply_dot("BURN");

		global.ref_target_beast = _ref_original_target;
	}
}