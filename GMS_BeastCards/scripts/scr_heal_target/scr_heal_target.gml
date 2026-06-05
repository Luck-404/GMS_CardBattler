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
	}
}