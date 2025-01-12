// Check if player is touching the grass and it's not already triggered
if (place_meeting(x, y, obj_player) && !_touched) {
    _touched = true;      // Mark grass as touched
	
	//var randnum = irandom(4);
	//for (i = 0; i < randnum; i++){
	//	var randx = irandom_range(-5,5);
	//	var randy = irandom_range(-5,5);
	//	var leaf = instance_create_layer(x+randx,y+randy,"Terrain",obj_leaf);
	//	leaf.hsp = randx;
	//	leaf.vspd = randy;
	//}
}