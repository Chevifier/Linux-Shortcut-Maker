extends Node
var save_directory =""
var directory = ""
var icon_directory = ""
var app_name = ""
var Comment = "None"
signal error; signal success

func create_shortcut():
	if directory == "" or app_name == "":
		emit_signal("error")
		print("ERROR Creating file")
		return
	var desktopfile = "#Created with Linux Shortcut Maker by Chevifier\n"\
	+"[Desktop Entry]\n"\
	+"Version=1.0\n"\
	+"Type=Application\n"\
	+"Terminal=false\n"\
	+"Exec="+directory+"\n"\
	+"Name="+app_name+"\n"\
	+"Comment="+Comment+"\n"\
	+"Icon="+icon_directory+"\n"\
	+"\n"\
	
	var file = File.new()
	file.open(save_directory+"/"+app_name+".desktop", File.WRITE)
	file.store_string(desktopfile)
	file.close()
	#Clear entered info after file created
	desktopfile = ""
	directory = ""
	app_name = ""
	emit_signal("success")
	

func load():
	var file = File.new()
	file.open(directory+"/"+app_name+".desktop", File.READ)
	var content = file.get_as_text()
	file.close()
	return content
