global.textBoxCooldown = 0;
global.cutSceneRunning = false;

var file_path = "sample.json"; // Name of your JSON file
var file_content = "";
if (file_exists(file_path)) {
    var file = file_text_open_read(file_path);
    while (!file_text_eof(file)) {
        file_content += file_text_read_string(file);
        file_text_readln(file); // Move to the next line
    }
    file_text_close(file);
} else {
    show_message("File not found: " + file_path);
}

// Parse JSON into a DS map
var json_data = json_parse(file_content);


read_data(json_data);