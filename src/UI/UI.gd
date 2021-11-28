extends Control
onready var json = load_json_file("res://PossibleDialog.json.tres")
onready var button0 = $MainVertDiv/ButtonsDiv/Button0
onready var button1 = $MainVertDiv/ButtonsDiv/Button1
onready var button2 = $MainVertDiv/ButtonsDiv/Button2
onready var label = $MainVertDiv/TopPanel/Label
onready var label2 = $MainVertDiv/MidHorDiv/RepDiv/ReputationLabel
var rep = 0

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



func QnA(Question, QorA):
	var Q = json[Question]['Question']
	var A = []
	for x in range(0, json[Question]['answers'].size()):
		A.append(json[Question]['answers'][x]["Reply"])
	if QorA == "question":
		return Q
	elif QorA == "answers":
		return A
	else:
		return false

func _ready() -> void:
	var random = rand_range(0, json.size())
	if json[random]['used'] == false:
		GiveText(random)
	else:
		json = rand_range(0, json.size())
		return

func GiveText(Value):
	var Answers = QnA(Value, 'answers')
	var Q = json[Value]
	button0.text = Answers[0]
	if button0.pressed == true:
		rep += Q['Net Worth']
	button1.text = Answers[1]
	if button1.pressed == true:
		rep += Q['Net Worth']
	button2.text = Answers[2]
	if button2.pressed == true:
		rep += Q['Net Worth']
	var Question = QnA(Value, 'question')
	label.text = Question
	label2.text = str(rep)
	print(Answers)
	print(button1.text)
