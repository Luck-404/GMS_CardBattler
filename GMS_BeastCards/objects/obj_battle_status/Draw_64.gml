//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_STATUS
// FUNCTION: Draws status icon, stack count, lifetime count, and tooltip.
//           Executes queued status commands independently of status visuals.
//           Supports repeat and death command callbacks.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	//================//
	//STATUS VISUALS//
	//================//
	if (_spr_status != undefined){

		//----------//
		//DRAW ICON//
		//----------//
		draw_sprite(_spr_status,0,x,y);

		draw_set_font(fnt_small_party_draw);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_colour(c_black);

		//----------------//
		//DRAW STACK COUNT//
		//----------------//
		draw_text(
			x + 5,
			y + 10,
			string(_ct_status_stacks)
		);

		//----------------//
		//DRAW LIFETIME//
		//----------------//
		if (!_flag_status_infinite){

			draw_text(
				x - 5,
				y + 10,
				string(_val_status_lifetime)
			);
		}

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		//-------------//
		//DRAW TOOLTIP//
		//-------------//
		if (
			keyboard_check(vk_lcontrol) &&
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				self
			)
		){

			//----------------//
			//TOOLTIP CONTENT//
			//----------------//
			var _str_line_1 =
				string(_str_status_name) +
				" | " +
				string(_str_status_desc);

			var _str_lifetime_text =
				_flag_status_infinite
				? "INFINITE"
				: string(_val_status_lifetime);

			var _str_line_2 =
				"LIFE: " +
				_str_lifetime_text +
				" | STACKS: " +
				string(_ct_status_stacks);

			var _str_line_3 = "";

			if (
				_str_trigger_region == undefined ||
				_str_trigger_region == "undefined"
			){

				_str_line_3 =
					"TRIGGERS AT: NEVER";
			}
			else{

				_str_line_3 =
					"TRIGGERS AT: " +
					string(_str_trigger_region);
			}

			//----------------//
			//PANEL DIMENSIONS//
			//----------------//
			var _val_panel_w =
				max(
					string_width(_str_line_1),
					max(
						string_width(_str_line_2),
						string_width(_str_line_3)
					)
				) +
				24;

			var _val_panel_h =
				70;

			var _val_panel_x =
				room_width * 0.5 -
				(_val_panel_w * 0.5);

			var _val_panel_y =
				20;

			//----------------//
			//DRAW PANEL//
			//----------------//
			draw_set_colour(c_dkgray);

			draw_rectangle(
				_val_panel_x,
				_val_panel_y,
				_val_panel_x + _val_panel_w,
				_val_panel_y + _val_panel_h,
				false
			);

			draw_set_colour(c_black);

			draw_rectangle(
				_val_panel_x,
				_val_panel_y,
				_val_panel_x + _val_panel_w,
				_val_panel_y + _val_panel_h,
				true
			);

			//----------------//
			//DRAW PANEL TEXT//
			//----------------//
			draw_set_colour(c_white);

			draw_text(
				_val_panel_x +
					(
						_val_panel_w -
						string_width(_str_line_1)
					) *
					0.5,
				_val_panel_y + 8,
				_str_line_1
			);

			draw_text(
				_val_panel_x +
					(
						_val_panel_w -
						string_width(_str_line_2)
					) *
					0.5,
				_val_panel_y + 26,
				_str_line_2
			);

			draw_text(
				_val_panel_x +
					(
						_val_panel_w -
						string_width(_str_line_3)
					) *
					0.5,
				_val_panel_y + 44,
				_str_line_3
			);

			//----------------//
			//RESTORE DRAW STATE//
			//----------------//
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		}
	}

	//================//
	//STATUS COMMANDS//
	//================//
	if (_scr_status != undefined){

		switch(_str_status_command){

			//----//
			//WAIT//
			//----//
			case "WAIT":
			break;


			//------//
			//REPEAT//
			//------//
			case "REPEAT":

				_scr_status(
					"REPEAT",
					self
				);

			break;


			//-----//
			//DEATH//
			//-----//
			case "DEATH":

				/*
					Clear the queued command before calling
					the Death callback so it cannot execute
					repeatedly if the callback does not
					immediately destroy this instance.
				*/
				_str_status_command =
					"WAIT";

				_scr_status(
					"DEATH",
					self
				);

			break;
		}
	}
	else{

		/*
			A status without a callback cannot process
			queued commands. Reset it rather than allowing
			REPEAT/DEATH to remain queued forever.
		*/
		_str_status_command =
			"WAIT";
	}
}