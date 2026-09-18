//===============================================================================//
//
// STEP: OBJ_GUI_POPUP_TRIGGER_BANNER
// FUNCTION: Updates banner lifespan and destroys expired banners.
//
//===============================================================================//

//================//
//LIFESPAN//
//================//
_ct_life--;

if (_ct_life <= 0){
    instance_destroy();
}