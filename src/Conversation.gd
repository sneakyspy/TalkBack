extends Node

func MakeLine():
	var file = File.new
	file.open('res//Save.json', File.READ)
	var dict = parse_json(file.get_as_text())
	return dict


func _ready() -> void:
	print(MakeLine() + "BlankText")


