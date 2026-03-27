// on play effects (green, red, blue cards, etc)
function scr_check_on_play_passive(_passive_name,_channel,_card){
	switch (_passive_name){
		case "Verdant":
			scr_passive_verdant(_card,_channel);
		break;
	}

}