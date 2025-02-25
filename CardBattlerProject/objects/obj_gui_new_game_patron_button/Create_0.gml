//////////////////////////////////////////////////////////////////////
//				OBJ_GUI_MNEW_GAME_PATRON_BUTTON CREATE				//
//																	//
// > WHEN CLICKED (HANDLED IN NEW GAME OBJ), SPAWN BLESSINGS		//
//////////////////////////////////////////////////////////////////////
image_speed = 0;
depth = -101;

_tar_sprite = undefined; //SPRITE TO DRAW SELF AS
_selection_patron = undefined; //THE NAME OF THE PATRON SPAWNED AS
_ref_to_patron = undefined; //OBJECTUAL REF TO THE PATRON
_flag_selected = false; //HAVE I BEEN SELECTED?
_hover = false; //AM I BEING HOVERED
_spawned_blessings = false; //HAVE I SPAWNED BLESSINGS?