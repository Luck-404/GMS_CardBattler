//check for game end
if (ds_list_size(global.player_party_in_play) == 0 && ds_list_size(global.player_party_dead) != 0){
	//player loss
	draw_text(750,600,"You've lost! confirm to exit game.");
} else if (instance_exists(obj_enemy_team) && ds_list_size(global.enemy_party_in_play) == 0 && ds_list_size(global.enemy_party_dead) != 0){
	//player win
	draw_text(750,300,"You've won! You've gained 2 cards!");
	draw_text(750,600,"Gold gained: " + string(global.gold_randomizer));
	draw_text(750,700,"Confirm to return to overworld.");		
}