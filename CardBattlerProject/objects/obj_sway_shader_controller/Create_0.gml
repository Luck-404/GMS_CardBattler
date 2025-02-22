//////////////////////////////////////////////////////////////////////
//			OBJ_SWAY_SHADER_CONTROLLER CREATE						//
//																	//
// > ESTABLISH VARIABLES FOR THE SWAYING GRASS SHADER				//
//////////////////////////////////////////////////////////////////////
self._shader_sway = sh_sway; //REFERENCE THE SHADER

 //SHADER CHECKER
self._u_time = shader_get_uniform(self._shader_sway, "u_time");
if (self._u_time == -1) {

}

//DEPTH
depth = 201;