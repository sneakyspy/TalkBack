extends Node2D
var Conversation = preload("res://Conversation.gd");

func _ready() -> void:
	var NAME = Names[rand_range(0, Names.len)]
	var Actor = {
		"Name":
			NAME,
		"sprite":
			sprite,
		"Dialoge":
			Conversation.TakeLines,
	}

var Names = [
	"James",
	"Stevan",
	"Joe",
	"Moe",
	"Terrance",
	"Tony",
	"Amber",
	"Ariana",
	"Terry",
	"Pam",
	"Josephine"
]

var sprite = [
	PackedScene
	#does not mean anything at the moment
]




