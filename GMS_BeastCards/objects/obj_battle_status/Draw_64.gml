
//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_STATUS
// FUNCTION: Draws the Status icon, stack count, lifetime, and tooltip.
//           Displays matching A-Z labels for linked Redirect statuses.
//           Executes queued Status commands independently of Status visuals.
//           Supports REPEAT and DEATH command callbacks.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	//================//
	//STATUS VISUALS//
	//================//
	if (_spr_status != undefined){

		//-------------//
		//DRAW ICON//
		//-------------//
		draw_sprite_ext(
			_spr_status,
			0,
			x,
			y,
			0.5,
			0.5,
			0,
			c_white,
			1.0
		);

		draw_set_font(fnt_gui_party_small);
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

		//======================//
		//REDIRECT LINK LABEL//
		//======================//
		var _flag_redirect_link =
			(
				_str_status_name == "REDIRECT" ||
				_str_status_name == "REDIRECT_GUARD"
			) &&
			variable_instance_exists(
				self,
				"_str_redirect_link_label"
			);

		if (_flag_redirect_link){

			//----------------//
			//LABEL BACKGROUND//
			//----------------//
			draw_set_colour(c_black);

			draw_rectangle(
				x - 8,
				y - 18,
				x + 8,
				y - 3,
				false
			);

			//-----------//
			//DRAW LABEL//
			//-----------//
			draw_set_colour(c_white);

			draw_text(
				x,
				y - 10,
				string(_str_redirect_link_label)
			);

			draw_set_colour(c_black);
		}

		//---------------//
		//DRAW LIFETIME//
		//---------------//
		if (!_flag_status_infinite){

			draw_text(
				x - 5,
				y + 10,
				string(_val_status_lifetime)
			);
		}

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		//================//
		//DRAW TOOLTIP//
		//================//
		if (
			keyboard_check(vk_lcontrol) &&
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				self
			)
		){

			//-----------------//
			//TOOLTIP CONTENT//
			//-----------------//
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

			//=======================//
			//REDIRECT LINK DETAILS//
			//=======================//
			if (_flag_redirect_link){

				_str_line_2 =
					"LINK: [" +
					string(_str_redirect_link_label) +
					"] | LIFETIME: INFINITE | USES: 1";
			}

			//==========================//
			//LIFETIME DECREMENT DISPLAY//
			//==========================//
			var _str_line_3 = "DECREMENTS: NEVER";

			//------------------------//
			//SPECIAL BANISH COUNTDOWN//
			//------------------------//
			if (_str_status_name == "BANISH"){

				_str_line_3 =
					"DECREMENTS: EACH SIDE TURN (CUSTOM)";
			}

			//----------------//
			//INFINITE STATUS//
			//----------------//
			else if (_flag_status_infinite){

				_str_line_3 =
					"DECREMENTS: NEVER (INFINITE)";
			}

			//----------------------//
			//NORMAL STATUS TIMING//
			//----------------------//
			else{

				switch (_str_trigger_region){

					//=======//
					//BEGIN//
					//=======//
					case "BEGIN":
					case "START":

						if (instance_exists(_ref_host)){

							_str_line_3 =
								"DECREMENTS: HOST BEGIN";
						}
						else{

							_str_line_3 =
								"DECREMENTS: PLAYER BEGIN";
						}

					break;

					//=====//
					//END//
					//=====//
					case "END":

						if (instance_exists(_ref_host)){

							_str_line_3 =
								"DECREMENTS: HOST END";
						}
						else{

							_str_line_3 =
								"DECREMENTS: PLAYER END";
						}

					break;

					//==================//
					//NO SCHEDULED TICK//
					//==================//
					default:

						_str_line_3 =
							"DECREMENTS: NEVER / SPECIAL";

					break;
				}
			}

			//=======================//
			//REDIRECT CONSUMPTION//
			//=======================//
			if (
				_str_status_name == "REDIRECT" ||
				_str_status_name == "REDIRECT_GUARD"
			){

				_str_line_3 =
					"CONSUMED WHEN THIS LINK REDIRECTS DAMAGE";
			}

			//------------------//
			//PANEL DIMENSIONS//
			//------------------//
			var _val_panel_w = max(
				string_width(_str_line_1),
				max(
					string_width(_str_line_2),
					string_width(_str_line_3)
				)
			) + 24;

			var _val_panel_h = 70;

			var _val_panel_x =
				(display_get_gui_width() * 0.5) -
				(_val_panel_w * 0.5);

			var _val_panel_y = 20;

			//--------------//
			//DRAW PANEL//
			//--------------//
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

			//-----------------//
			//DRAW PANEL TEXT//
			//-----------------//
			draw_set_colour(c_white);

			draw_text(
				_val_panel_x +
					((_val_panel_w - string_width(_str_line_1)) * 0.5),
				_val_panel_y + 8,
				_str_line_1
			);

			draw_text(
				_val_panel_x +
					((_val_panel_w - string_width(_str_line_2)) * 0.5),
				_val_panel_y + 26,
				_str_line_2
			);

			draw_text(
				_val_panel_x +
					((_val_panel_w - string_width(_str_line_3)) * 0.5),
				_val_panel_y + 44,
				_str_line_3
			);
		}

		//--------------------//
		//RESTORE DRAW STATE//
		//--------------------//
		draw_set_colour(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}

	//================//
	//STATUS COMMANDS//
	//================//
	if (_scr_status != undefined){

		switch (_str_status_command){

			//========//
			//WAIT//
			//========//
			case "WAIT":

			break;

			//========//
			//REPEAT//
			//========//
			case "REPEAT":

				//=====================//
				//SNAPSHOT HOST HP//
				//=====================//
				var _ref_repeat_host = _ref_host;
				var _val_hp_before = 0;

				if (instance_exists(_ref_repeat_host)){

					_val_hp_before =
						_ref_repeat_host._val_cur_hp;
				}

				//================//
				//RESOLVE STATUS//
				//================//
				_scr_status(
					"REPEAT",
					self
				);

				//================//
				//CHECK HP DAMAGE//
				//================//
				if (instance_exists(_ref_repeat_host)){

					var _val_hp_damage = max(
						0,
						_val_hp_before -
							_ref_repeat_host._val_cur_hp
					);

					if (_val_hp_damage > 0){

						scr_status_trigger_pain_response(
							_ref_repeat_host,
							_val_hp_damage
						);
					}
				}

			break;

			//=======//
			//DEATH//
			//=======//
			case "DEATH":

				/*
					Clear the queued command before calling DEATH
					so it cannot repeatedly execute if the callback
					does not immediately destroy this Status.
				*/

				_str_status_command = "WAIT";

				_scr_status(
					"DEATH",
					self
				);

			break;
		}
	}
	else{

		/*
			A Status without a callback cannot process queued commands.
			Reset the command rather than leaving it queued.
		*/

		_str_status_command = "WAIT";
	}
}