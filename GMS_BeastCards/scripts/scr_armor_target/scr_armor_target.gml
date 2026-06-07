// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_armor_target(_amt,_tar){
	_tar._armor += _amt;
	//POPUP
	scr_spawn_scrolling_popup("TEXT","+" + string(_amt),undefined,c_blue,_tar.x+irandom_range(-32,32),_tar.y-24+irandom_range(-32,32));		
	
}