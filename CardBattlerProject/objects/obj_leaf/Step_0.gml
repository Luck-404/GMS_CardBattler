if (_life > 0){
	x=x+hsp;
	y=y+vspd;
	
	_life--;
} else {
	instance_destroy();
}