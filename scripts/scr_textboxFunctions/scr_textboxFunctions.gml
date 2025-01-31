function scr_set_defaults_for_text() {
	line_break_pos[0, page_number] = 999;
	line_break_num[page_number] = 0;
	line_break_offset[page_number] = 0;
}

/// @param text
function scr_text(_text) {

	scr_set_defaults_for_text();
	
	text[page_number] = _text;

	page_number++;

}

/// @param option
/// @param link_id
/// @param source_id
function scr_option(_option, _link_id, _source_id) {
	
	option[option_number] = _option;
	option_link_id[option_number] = _link_id;
	option_source_id[option_number] = _source_id;
	
	option_number++;
}

function create_textbox(_text_id,_source_id) {
	with (instance_create_depth(0, 0, -9999, obj_textbox)) {
		global.textBoxRunning = true;
		global.pauseControl = false;
		scr_game_text(_text_id,_source_id);
	}
}

function scr_end_textbox() {
	global.textBoxRunning = false;
}

function read_data(json_data) {
	// Accessing values using struct notation
	var dialogue_text = json_data.text;
	var typing_sound = json_data.sound;

	var profile = json_data.profile; // Nested struct
	var character_name = profile.name;
	var profile_image = profile.image;
	var profile_animation = profile.animation;

	// Accessing array (list) of branches
	var branches = json_data.branches;
	var num_branches = array_length(branches);

	for (var i = 0; i < num_branches; i++) {
	    var option_text = branches[i].option;
	    var next_path = branches[i].next;
	    show_debug_message("Option: " + option_text + " -> " + next_path);
	}
}