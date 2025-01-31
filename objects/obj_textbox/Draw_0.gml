var accept_key = keyboard_check_pressed(vk_space);
//myState = textboxState.typing;
var textbox_x = 0;
var textbox_y = 240;


//--------------setup-------------------//
if (!setup) {
    setup = true;

    draw_set_font(global.font_main);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);

    for (var p = 0; p < page_number; p++) {
        text_length[p] = string_length(text[p]);
        text_x_offset[p] = 24;

        var current_line_width = 0;
        var current_line = 0;
        var last_space = 0;

        for (var c = 0; c < text_length[p]; c++) {
            var _char = string_char_at(text[p], c + 1);
            var char_width = string_width(_char);

            char[c, p] = _char;
            current_line_width += char_width;

            if (_char == " ") last_space = c;

            if (current_line_width > line_width) {
                line_break_pos[current_line, p] = last_space;
                current_line_width = 0;
                current_line++;
            }

            char_x[c, p] = textbox_x + text_x_offset[p] + current_line_width;
            char_y[c, p] = textbox_y + current_line * line_sep;
        }
        line_break_num[p] = current_line;
    }
}


//----------------typing the text---------//
if (draw_char < text_length[page]) {
	draw_char += text_spd;
	draw_char = clamp(draw_char, 0, text_length[page]);
}


//------------flip through the pages---------//
if (accept_key) {
	if (global.textBoxCooldown == 0) {
		global.textBoxCooldown = 10;
		//if the typing is done
		if (draw_char == text_length[page]) {
			
			//next pgae
			if (page < page_number-1) {
				page++;
				draw_char = 0;
			}
			else {
				if (global.textBoxRunning == false && global.cutSceneRunning == false) {
					global.playerControl = true;
					global.pauseControl = true;
				}
				//link text for options
				else if (option_number > 0) {
					//Select the appropriate option text unless the option in a quitting option
					if (option_link_id[option_pos] == "quit" ){
						scr_end_textbox();
						global.playerControl = true;
						global.pauseControl = true;
					}
					else {
						create_textbox(option_link_id[option_pos], option_source_id[option_pos]);
					}
				}
				instance_destroy();
				//alarm[0] = 1;
			}
		}
		else {
			draw_char = text_length[page];
		}
	}
}





//-----------------draw the textbox--------------//
var _txtb_x = textbox_x + text_x_offset[page];
var _txtb_y = textbox_y;
txtb_img += txtb_img_spd;
txtb_spr_w = sprite_get_width(txtb_spr);
txtb_spr_h = sprite_get_height(txtb_spr);
//back of the textbox
draw_sprite_ext(txtb_spr, txtb_img, _txtb_x, _txtb_y, textbox_width/txtb_spr_w, textbox_height/txtb_spr_h, 0, c_white, 1);

//-----------------options---------------//
if (draw_char == text_length[page] && page == page_number - 1) {
	
	//option selection
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	option_pos = clamp(option_pos, 0, option_number-1);
	

	
	//draw the options
	var _op_space = 32;
	var _op_bord = 8;
	for (var op = 0; op < option_number; op++) {
		//the option box
		var _o_w = string_width(option[op]) + _op_bord*2;
		draw_sprite_ext(txtb_spr, txtb_img, _txtb_x + 32, _txtb_y - _op_space*option_number + _op_space*op, _o_w/txtb_spr_w, (_op_space -1)/txtb_spr_h, 0, c_white, 1);
		
		//the arrow
		if (option_pos == op) {
		draw_sprite(spr_textbox_arrow, 0, _txtb_x, _txtb_y - _op_space*option_number + _op_space*op);
		}
		
		//the option text
		draw_text(_txtb_x + 32 + _op_bord,  _txtb_y - _op_space*option_number + _op_space*op+ 2, option[op]);
	}
}

//draw the text
for(var c = 0; c < draw_char; c++) {
	//the text
	draw_text(char_x[c, page], char_y[c, page], char[c, page] );
}
//var _drawtext = string_copy(text[page], 1, draw_char);
//draw_text_ext( _txtb_x + border, _txtb_y + border, _drawtext, line_sep, line_width);
