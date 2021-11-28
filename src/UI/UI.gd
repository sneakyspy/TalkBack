extends Control
onready var json = load_json_file("res://PossibleDialog.json.tres")
onready var button0 = $MainVertDiv/ButtonsDiv/Button0
onready var button1 = $MainVertDiv/ButtonsDiv/Button1
onready var button2 = $MainVertDiv/ButtonsDiv/Button2
onready var label = $MainVertDiv/TopPanel/Label
onready var label2 = $MainVertDiv/MidHorDiv/RepDiv/ReputationLabel
onready var buttonsdiv = $MainVertDiv/ButtonsDiv
var match_text_characters = RegEx.new()
var match_non_text_characters = RegEx.new()
var rep = 0
var currentQuestion = -1
var all_words = {}
var known_words = {}

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
	for q in obj:
		var new_answers = []
		while q['answers'].size() > 0:
			var x = int(rand_range(0,q['answers'].size()))
			new_answers.append(q['answers'][x])
			q['answers'].remove(x)
		q['answers'] = new_answers
	return obj

func alien_text(text):
	return match_text_characters.sub(text, "#", true)

func ReplaceUnknown(text):
	var words_in = text.split(' ')
	var words_out = []
	for word in words_in:
		if normalize_word(word) in known_words:
			words_out.append(word)
		else:
			words_out.append(alien_text(word))
	var text_out = ''
	for word in words_out:
		text_out += word
		text_out += ' '
	return text_out

func normalize_word(word):
	return match_non_text_characters.sub(word.to_lower(), '', 1)

func list_all_words():
	for x in range(0, json.size()):
		var q = json[x]['Question']
		for word in q.split(" ", false):
			all_words[normalize_word(word)] = 1
		for y in range(0, json[x]['answers'].size()):
			var a = json[x]['answers'][y]['Reply']
			for word in a.split(" ", false):
				all_words[normalize_word(word)] = 1

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
	match_non_text_characters.compile('[^a-z]')
	match_text_characters.compile('[A-Za-z]')
	GiveText()
	list_all_words()

func GiveText():
	currentQuestion = int(rand_range(0, json.size()))
	for word in all_words:
		if rand_range(0, 1) > 0.9:
			known_words[word] = 1
	if json[currentQuestion]['used']:
		for x in range(0,json.size()):
			var q = json[x]
			if !q['used']:
				return GiveText()
		# if we got here, there are no more questions to take
		label.text = ""
		if rep < 50:
			label2.text = "You Lose"
		else:
			label2.text = "You Win"
		buttonsdiv.visible = false
		return
	var Answers = QnA(currentQuestion, 'answers')
	var Question = QnA(currentQuestion, 'question')
	button0.text = ReplaceUnknown(Answers[0])
	button1.text = ReplaceUnknown(Answers[1])
	button2.text = ReplaceUnknown(Answers[2])
	label.text = ReplaceUnknown(Question)
	label2.text = str(rep)
	json[currentQuestion]['used'] = true
	print(Question)
	print(json[currentQuestion]['answers'])


func _on_Button0_pressed() -> void:
	rep += json[currentQuestion]['answers'][0]['Net outcome']
	GiveText()


func _on_Button1_pressed() -> void:
	rep += json[currentQuestion]['answers'][1]['Net outcome']
	GiveText()


func _on_Button2_pressed() -> void:
	rep += json[currentQuestion]['answers'][2]['Net outcome']
	GiveText()
