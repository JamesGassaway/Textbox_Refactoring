/******GAME TEXT MANAGER**********/
function scr_game_text(_text_id,_source_id){

	
	switch(_source_id) {
		case "illari":
			scr_game_text_illari(_text_id);
			break;
		case "inv":
			scr_game_text_items(_text_id);
			break;
		case "jasper":
			scr_game_text_jasper(_text_id);
			break;
		case "mint":
			scr_game_text_mint(_text_id);
			break;
		case "elysia":
			scr_game_text_elysia(_text_id);
			break;
		case "thorne":
			scr_game_text_thorne(_text_id);
			break;
		case "inter":
			scr_game_text_interactive(_text_id);
			break;
		case "cutscene":
			scr_game_text_cutscenes(_text_id);
			break;
	
	}
	switch(_text_id){
		case "":
			scr_text("(Blank Text.)");
			scr_end_textbox();
			break;
		case "def":
			scr_text("(Default text provided.)");
			scr_end_textbox();
			break;
	}
	
}