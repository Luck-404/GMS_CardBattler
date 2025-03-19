// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_death_rearrangement(_creature){
	while (_creature._left_unit != undefined){
		//start unit
		var _start_pos = _creature._creature_position;
		var _start_x = _creature.x;
		var _start_left = _creature._left_unit;
		var _start_right = _creature._right_unit;
		
		// swap unit
		var _swap_unit = _creature._left_unit;
		var _swap_pos = _swap_unit._creature_position;
		var _swap_x = _swap_unit.x;
		var _swap_left = _swap_unit._left_unit;
		var _swap_right = _swap_unit._right_unit;
		
		//swap x values
		_swap_unit.x = _start_x;
		_creature.x = _swap_x;
		
		//swap positions
		_swap_unit._creature_position = _start_pos;
		_creature._creature_position = _swap_pos;
		
		//update left/right connections
		_swap_unit._left_unit = _creature; //swapped
		_swap_unit._right_unit = _start_right; //takes place of original
		if (_start_right != undefined){
			_start_right._left_unit = _swap_unit; //right unit references swapped now
		}
		_creature._left_unit = _swap_left; //original moves left
		if (_swap_left != undefined){
			_swap_left._right_unit = _creature; //swap left's new right is the original
		}
		_creature._right_unit = _swap_unit; //
	}
	
	//remove unit from living list
	
}