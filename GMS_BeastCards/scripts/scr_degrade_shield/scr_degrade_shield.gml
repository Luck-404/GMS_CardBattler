function scr_degrade_shield(_unit){
	var _type = _unit._ref_unit[?"beast_archetype"];
	switch (_type){
		case "MARTIAL": //take 20% of the shields, rounded down
			_unit._armor = floor((_unit._armor)*0.8);
		break;
		
		case "TECHNICAL": //take 40% of the shields, rounded down
			_unit._armor = floor((_unit._armor)*0.6);
		break;
				
		case "MAGICAL": //take 60% of the shields, rounded down
			_unit._armor = floor((_unit._armor)*0.4);
		break;
				
		case "OTHER": //take 60% of the shields, rounded down
			_unit._armor = floor((_unit._armor)*0.4);
		break;
	}
}