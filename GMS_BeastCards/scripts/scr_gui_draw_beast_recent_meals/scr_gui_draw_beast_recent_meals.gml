//===============================================================================//
// SCRIPT: SCR_GUI_DRAW_BEAST_RECENT_MEALS
// FUNCTION: Compact dark-background-compatible meals display, inspired by the
//           provided screenshot: white header, gold food name, white bonus.
//           Draws newest meal at top and --- for unused slots.
// ARGUMENTS: Beast, left x, top y, optional row width.
// RETURNS: Total height drawn (148px).
//===============================================================================//
function scr_gui_draw_beast_recent_meals(_stct_beast,_val_x,_val_y,_val_width=230){
    var _arr_meals = scr_beast_feed_get_recent(_stct_beast);
    // Dedicated dark backing keeps names and bonuses readable on sprite GUIs.
    draw_set_colour(make_colour_rgb(12,16,20));
    draw_rectangle(_val_x-8,_val_y-5,_val_x+_val_width+8,_val_y+147,false);
    draw_set_font(fnt_gui_party_small);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_text(_val_x,_val_y,"Recent meals:");
    for (var _i=0;_i<3;_i++){
        var _val_row_y=_val_y+28+(_i*40);
        if (is_struct(_arr_meals[_i])){
            draw_set_colour(make_colour_rgb(245,204,81));
            draw_text(_val_x,_val_row_y,_arr_meals[_i]._str_food_name);
            draw_set_colour(c_white);
            draw_text_ext(_val_x+10,_val_row_y+15,_arr_meals[_i]._str_bonus_text,-1,_val_width-10);
        } else {
            draw_set_colour(c_gray);
            draw_text(_val_x,_val_row_y,"---");
        }
    }
    draw_set_colour(c_white);
    return 148;
}
