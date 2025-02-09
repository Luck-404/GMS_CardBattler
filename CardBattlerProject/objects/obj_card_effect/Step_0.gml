////////////////////////
// COUNTDOWN TO DEATH //
////////////////////////
if (_count_lifetime <= 0){
	instance_destroy();
} else {
	_count_lifetime--;	
}

if (_vspd > 0){
	y+=_vspd;	
}