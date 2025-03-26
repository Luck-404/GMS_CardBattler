function scr_find_new_creature_x(_team,_position){
	switch (_team){
		case "Player":
			var _unit_count = ds_list_size(global.player_party_in_play) + ds_list_size(global.player_party_dead);
			var _x_min = 70;
			var _x_max = 796;
			var _x_center = (_x_min + _x_max) / 2;
			var _spacing = 160; // Fixed spacing between units
			// Calculate x position based on center alignment
			var _offset = (_position - ((_unit_count - 1) / 2)) * _spacing;
			var _x_position = _x_center + _offset;
			return _x_position;
		break;
		
		case "Enemy":
			_unit_count = ds_list_size(global.enemy_party_in_play) + ds_list_size(global.enemy_party_dead);
			_x_min = 1124;
			_x_max = 1850;
			_x_center = (_x_min + _x_max) / 2;
			_spacing = 160; // Fixed spacing between units
			// Calculate x position based on center alignment
			_offset = (_position - ((_unit_count - 1) / 2)) * _spacing;
			_x_position = _x_center + _offset;
			return _x_position;
		break;
	}
}