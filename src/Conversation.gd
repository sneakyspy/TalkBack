extends Node

func MakeLine():
	var file = File.new()
	file.open('res://Save.json', File.READ)
	var dictionary = parse_json(file.get_as_text())

var dict = {}

func load_json_file(path):
	"""Loads a JSON file from the given res path and return the loaded JSON object."""
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
	print(text)
	return obj

func _ready() -> void:
	print(load_json_file('res//Save.json'))
