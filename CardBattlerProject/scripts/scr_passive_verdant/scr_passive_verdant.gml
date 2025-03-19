function scr_passive_verdant(_card,_caster){
	if (_card._card_color == "Green"){
		//roll 100
		var _rand = irandom_range(1,100);
		if (_rand > 90){
			//check if heal
			if (_card._card_type == "Heal" || _card._card_name == "Life Spirit" || _card._card_name == "Nature's Remedy"){
				//spawn a life spirit on the caster
				scr_create_combat_minion(_card,_caster,_caster,"Life Spirit",[""]);
			}
			else if (_card._card_name == "Verdant Bolt"){
				var _pick = choose(1,2){
					if (_pick == 1){
						scr_create_combat_minion(_card,_caster,_caster,"Wasp Drone",[""]);
					}
					else {
						scr_create_combat_minion(_card,_caster,_caster,"Serpent",[""]);
					}
				}
			}
			//check if 
			else if (_card._card_name == "Wasp Drone" || _card._card_name == "Deadseed" || _card._card_name == "Poison Ivy"){
				//spawn a wasp drone on the caster
				scr_create_combat_minion(_card,_caster,_caster,"Wasp Drone",[""]);
			}
		
			else if (_card._card_name == "Spirit Fang"){
				//spawn a serpent on the caster
				scr_create_combat_minion(_card,_caster,_caster,"Serpent",[""]);
			}
		}
		scr_create_combat_popup(undefined,"Passive: Verdant triggers","Default",_caster.x,_caster.y-200);
	}
}