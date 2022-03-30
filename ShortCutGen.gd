extends Panel

onready var name_txt = $VB1/HBoxContainer/VB2/VBoxContainer/HBoxContainer/app_name
onready var dir_txt = $VB1/HBoxContainer/VB2/VBoxContainer/HBoxContainer2/exe_dir
onready var ico_txt = $VB1/HBoxContainer/VB2/VBoxContainer/HBoxContainer4/ico_dir
onready var save_dir_txt = $VB1/HBoxContainer/VB2/VBoxContainer/HBoxContainer5/save_dir
onready var comment_txt = $VB1/HBoxContainer/VB2/VBoxContainer/HBoxContainer3/comment

onready var ico_image = $VB1/HBoxContainer/icon_preview

onready var exe_select_diag = $VB1/HBoxContainer/VB2/exe_select_diag
onready var icon_select_diag = $VB1/HBoxContainer/VB2/icon_select_diag
onready var save_select_diag = $VB1/HBoxContainer/VB2/save_select_diag2


#SAVE DATA VARIABLE
const SETTINGS_DIR = "user://saves/"
var file_path = SETTINGS_DIR + "/linuxshortcutmaker.config"
var settings= {
	"def_dir" : ""
}
#-------------
func _ready():
	Generator.connect("error", self, "show_error")
	Generator.connect("success",self,"show_success")
	load_settings()
	Generator.save_directory = settings.def_dir
	save_dir_txt.text = settings.def_dir

func _on_exe_button_pressed():
	exe_select_diag.popup()


func _on_icon_button_pressed():
	icon_select_diag.popup()

func _on_register_btn_pressed():
	$warning_diag.dialog_text = "Registering Not yet available"
	$warning_diag.popup()


func _on_create_btn_pressed():
	Generator.app_name = name_txt.text
	Generator.Comment = comment_txt.text
	print(Generator.Comment)
	Generator.create_shortcut()

func _on_save_button_pressed():
	save_select_diag.popup()


func _on_exe_select_diag_file_selected(path):
	Generator.directory = path
	dir_txt.text = path


func _on_icon_select_diag_file_selected(path):
	Generator.icon_directory = path
	ico_txt.text = path
	set_image(path)



func _on_save_select_diag2_dir_selected(dir):
	Generator.save_directory = dir
	save_dir_txt.text = dir
	settings.def_dir = dir

func show_error(error):
	$warning_diag.dialog_text = error
	$warning_diag.popup()
func show_success():
	$warning_diag.dialog_text = "SUCCESS\n"+name_txt.text+" shortcut created"
	$warning_diag.popup()
	
func set_image(path):
	var image = Image.new()
	image.load(path)
	var t = ImageTexture.new()
	t.create_from_image(image)
	ico_image.texture = t

func _on_sav_def_btn_pressed():
	if save_dir_txt.text == "":
		$warning_diag.dialog_text = "Save Directory not set"
		$warning_diag.popup()
		return
	save_settings()
	$warning_diag.dialog_text = "Default Directory Saved"
	$warning_diag.popup()


func load_settings():
	var save_file = File.new()
	if save_file.file_exists(file_path):
		save_file.open(file_path,File.READ)
		settings = save_file.get_var()
		save_file.close()
	

func save_settings():
	var dir = Directory.new()
	if !dir.dir_exists(SETTINGS_DIR):
		dir.make_dir_recursive(SETTINGS_DIR)
	var save_file = File.new()
	
	save_file.open(file_path,File.WRITE)
	save_file.store_var(settings)
	save_file.close()
	$warning_diag.dialog_text = "Default Save Directory set as \n"+ save_dir_txt.text
