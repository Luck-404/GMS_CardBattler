//
//
//
//
//
function scr_heal_target(_amt,_tar){
	if (_tar._cur_hp != _tar._max_hp){
		_tar._cur_hp += _amt;
		if (_tar._cur_hp > _tar._max_hp){
			_tar._cur_hp = _tar._max_hp;
		}
		//POPUP
		scr_spawn_popup_scrolling("TEXT","+" + string(_amt),undefined,c_green,_tar.x+irandom_range(-32,32),_tar.y-24+irandom_range(-32,32));					
	}
}