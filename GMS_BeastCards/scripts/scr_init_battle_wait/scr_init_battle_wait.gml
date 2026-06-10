//
//
// SCRIPT: SCT_INIT_BATTLE_WAIT | CREATES A NEW WAITING OBJECT THAT WILL PREVENT THE GAME FROM FLOWING FOR ITS LIFE | RETURNS VOID
//
//
function scr_init_battle_wait(_lifespan){
	var _new_waiter = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_wait);
	_new_waiter._life = _lifespan;
}