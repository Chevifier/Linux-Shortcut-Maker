extends Node
var save_directory =""
var ver = "1.0"
var type = "Application"
var terminal = "false"
var directory = ""
var icon_directory = ""
var app_name = ""
var Comment = "None"
signal error; signal success

func create_shortcut():
	if directory == "" or app_name == "":
		emit_signal("error","Error: Directory and/or Program name not set")
		return
	var n = directory.find(" ")
	if n > 0:
		directory = "\""+ directory + "\""
	var desktopfile = "#Created with Linux Shortcut Maker by Chevifier\n"\
	+"[Desktop Entry]\n"\
	+"Version="+ver+"\n"\
	+"Type="+type+"\n"\
	+"Terminal="+terminal+"\n"\
	+"Exec="+directory+"\n"\
	+"Name="+app_name+"\n"\
	+"Comment="+Comment+"\n"\
	+"Icon="+icon_directory+"\n"
		
	var file = File.new()
	var file_path = save_directory+"/"+app_name+".desktop"
	file.open(file_path, File.WRITE)
	file.store_string(desktopfile)
	file.close()
	var e1 = OS.execute("gio",["set",file_path, "metadata::trusted", "true"])
	var e2 = OS.execute("chmod",["a+x",file_path])
	print("Trusted: "+str(e1) +"\nExecutable:" + str(e2))
	register(file_path,app_name+".desktop")
	#TO Do report Errors
	emit_signal("success")
	print(desktopfile)

func register(file,file_name):
	var e1 = OS.execute("cp",["\""+file+"\"","\"/usr/share/applications/"+file_name+"\""])
	print("Copy status: "+ str(e1))
	#NOTE error 1 = failed


#TO-DO Edit previously created shortcut
func load_shortcut():
	var file = File.new()
	file.open(directory+"/"+app_name+".desktop", File.READ)
	var content = file.get_as_text()
	file.close()
	return content
