//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_STATUS
// FUNCTION: Draws the Status icon, stack count, lifetime, and hover tooltip.
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

		draw_set_font(
			fnt_gui_party_small
		);

		draw_set_halign(
			fa_center
		);

		draw_set_valign(
			fa_middle
		);

		draw_set_colour(
			c_black
		);

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
				_str_status_name ==
					"REDIRECT" ||
				_str_status_name ==
					"REDIRECT_GUARD"
			) &&
			variable_instance_exists(
				self,
				"_str_redirect_link_label"
			);

		if (_flag_redirect_link){

			//----------------//
			//LABEL BACKGROUND//
			//----------------//
			draw_set_colour(
				c_black
			);

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
			draw_set_colour(
				c_white
			);

			draw_text(
				x,
				y - 10,
				string(
					_str_redirect_link_label
				)
			);

			draw_set_colour(
				c_black
			);
		}

		//---------------//
		//DRAW LIFETIME//
		//---------------//
		if (!_flag_status_infinite){

			draw_text(
				x - 5,
				y + 10,
				string(
					_val_status_lifetime
				)
			);
		}

		draw_set_halign(
			fa_left
		);

		draw_set_valign(
			fa_top
		);

#region HOVER TOOLTIP

//================//
//CHECK HOVER//
//================//
var _flag_status_hover =
	position_meeting(
		device_mouse_x_to_gui(0),
		device_mouse_y_to_gui(0),
		self
	);

if (
	!scr_gui_check_cheats_active() &&
	_flag_status_hover
){

	//================//
	//CTRL INSPECTION//
	//================//
	if (
		keyboard_check(
			vk_lcontrol
		)
	){

		scr_gui_request_battle_inspection(
			"STATUS",
			self,
			50
		);
	}

	//================//
	//SIMPLE TOOLTIP//
	//================//
	else{

		scr_gui_set_hover_tooltip(
			_str_status_name,
			"",
			50
		);
	}
}

#endregion

		//--------------------//
		//RESTORE DRAW STATE//
		//--------------------//
		draw_set_colour(
			c_white
		);

		draw_set_halign(
			fa_left
		);

		draw_set_valign(
			fa_top
		);
	}

	//================//
	//STATUS COMMANDS//
	//================//
	if (_scr_status != undefined){

		switch (_str_status_command){

			//======//
			//WAIT//
			//======//
			case "WAIT":

			break;

			//========//
			//REPEAT//
			//========//
			case "REPEAT":

				//=====================//
				//SNAPSHOT HOST HP//
				//=====================//
				var _ref_repeat_host =
					_ref_host;

				var _val_hp_before =
					0;

				if (
					instance_exists(
						_ref_repeat_host
					)
				){

					_val_hp_before =
						_ref_repeat_host
							._val_cur_hp;
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
				if (
					instance_exists(
						_ref_repeat_host
					)
				){

					var _val_hp_damage =
						max(
							0,
							_val_hp_before -
								_ref_repeat_host
									._val_cur_hp
						);

					if (
						_val_hp_damage >
						0
					){

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
			A Status without a callback cannot process queued commands.
			Reset the command rather than leaving it queued.
		*/

		_str_status_command =
			"WAIT";
	}
}