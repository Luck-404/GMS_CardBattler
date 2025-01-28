draw_self();
draw_set_color(c_white);

switch(_req_dir){
	case "Any":
		draw_circle(x,y,20,true);
	break;
	
	case "Left":
		draw_circle(x-64,y,20,true);
	break;
	
	case "Right":
		draw_circle(x+64,y,20,true);
	break;
	
	case "Up":
		draw_circle(x,y+64,20,true);
	break;
	
	case "Down":
		draw_circle(x,y-64,20,true);
	break;

}