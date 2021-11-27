extends KinematicBody2D
onready var dialogs = load_json_file('res://PossibleDialog.json.tres')
var respect = 0

func load_json_file(path):#not gonna touch that
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	var result_json = JSON.parse(text)
	if result_json.error != OK:
		print("[load_json_file] Error loading JSON file '" + str(path) + "'.")
		print("\tError: ", result_json.error)
		print("\tError Line: ", result_json.error_line)
		print("\tError String: ", result_json.error_string)
		return null
	var obj = result_json.result
	return obj

func _ready() -> void:
	pass
