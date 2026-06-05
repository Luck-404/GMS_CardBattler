//
//
//
//
//
function scr_damage_target(_dmg,_tar){
//(FUTURE) shield buffs

//minions take damage

//Armor takes damage
if (_tar._armor != 0){
	_tar._armor -= _dmg;
	if (_tar.armor < 0){
		_dmg = abs(_tar.armor);
		_tar.armor = 0;
	}
}
//overhealth takes damage
if (_tar._overhealth != 0){
	_tar._overhealth -= _dmg;
	if (_tar._overhealth < 0){
		_dmg = abs(_tar._overhealth);
		_tar._overhealth = 0;
	}
}
//hp takes damage
_tar._cur_hp -= _dmg;
}