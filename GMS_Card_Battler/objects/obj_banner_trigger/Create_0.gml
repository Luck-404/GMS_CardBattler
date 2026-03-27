//////////////////////////////////////////////////////////////////////
//					OBJ_BANNER_TRIGGER CREATE						//
//																	//
// > ESTABLISH EDITABLE INSTANCE VARIABLES							//
//////////////////////////////////////////////////////////////////////
if (is_undefined(_color)) {
    _color = c_white; 
}
if (is_undefined(_text)) {
    _text = "Default Banner Text";
}

_flag_triggered = false;
image_speed = 0;
image_index = 1;