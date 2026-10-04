//===============================================================================//
//
// DRAW GUI BEGIN: OBJ_BATTLE_VFX
// FUNCTION: Draws battle VFX below hp bar battle rendering.
//           Suppresses all battle VFX while the end-battle pane is active.
//
//===============================================================================//

//==================//
//END BATTLE HIDDEN//
//==================//
if (instance_exists(obj_gui_end_battle_pane)){
	exit;
}

//================//
//LOWER BATTLE VFX//
//================//
if (sprite_index == spr_battle_vfx_thorns){
	draw_self();
}