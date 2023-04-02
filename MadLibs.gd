extends Control

var answers = []
var storie

onready var Text = $VBoxContainer/Text
onready var TextInput = $VBoxContainer/HBoxContainer/TextInput

func _ready():
	select_random_storie()
	verify_end()

func select_random_storie():
	randomize()
	
	var stories_len = $Stories.get_child_count()
	storie = $Stories.get_child(randi() % stories_len)
	

func verify_end():
	if len(answers) == len(storie.questions):
		show_story()
	
	elif len(answers) < len(storie.questions):
		next_question()

func show_story():
	Text.text = storie.storie % answers
	TextInput.queue_free()
	$VBoxContainer/HBoxContainer/Label.text = "Jogar novamente"

func next_question():
	Text.text += "Por favor, me diga " + storie.questions[len(answers)]
	TextInput.grab_focus()

func get_answer(text):
	answers.append(text)
	TextInput.clear()
	Text.text = ""
	verify_end()
	
func _on_Input_text_entered(new_text):
	get_answer(new_text)

func _on_TextureButton_pressed():
	if len(answers) == len(storie.questions):
		get_tree().reload_current_scene()
		
	else:
		get_answer(TextInput.text)

