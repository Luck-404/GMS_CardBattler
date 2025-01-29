if (place_meeting(x,y,obj_player) && obj_player.y-16 < self.y){
	depth = 199;
	image_alpha = 0.7;
} else {
	depth = 200;
	image_alpha = 1.0;	
}
draw_self();