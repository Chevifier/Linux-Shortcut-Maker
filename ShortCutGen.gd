extends Panel

onready var name_txt = $VBoxContainer/HBoxContainer/app_name
onready var dir_txt = $VBoxContainer/HBoxContainer2/exe_dir
onready var ico_txt = $VBoxContainer/HBoxContainer4/ico_dir
onready var save_dir_txt = $VBoxContainer/HBoxContainer5/save_dir

onready var ico_image = $VBoxContainer/icon_preview

onready var exe_select_diag = $exe_select_diag
onready var icon_select_diag = $icon_select_diag
onready var save_select_diag = $save_select_diag2

func _ready():
	Generator.connect("error", self, "show_error")
	Generator.connect("success",self,"show_success")

func _on_exe_button_pressed():
	exe_select_diag.popup()


func _on_icon_button_pressed():
	icon_select_diag.popup()

func _on_register_btn_pressed():
	$warning_diag.dialog_text = "Registering Not yet available"
	$warning_diag.popup()


func _on_create_btn_pressed():
	Generator.app_name = name_txt.text
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
	save_dir_txt.text = dir
	print(dir)
	Generator.save_directory = dir

func show_error():
	$warning_diag.dialog_text = "Error: Directory and/or Program name not set"
	$warning_diag.popup()
func show_success():
	$warning_diag.dialog_text = "SUCCESS\n"+name_txt.text+" shortcut created"
	$warning_diag.popup()
	
func set_image(path):
	var image = Image.new()
	image.load(path)
	var t = ImageTexture.new()
	t.create_from_image(image)
	$VBoxContainer/icon_preview.texture = t





