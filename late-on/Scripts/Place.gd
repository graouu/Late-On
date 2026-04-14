class_name Place extends Control

signal go_to
signal open_dialogue(array_dialogue : Array[DialogueLine])
signal open_puzzle(puzzle : String)
@export_category("Miscellaneous")
@export var place_name : String
@export var map_texture : Texture2D

@export_category("MOVEMENT PROPERTIES")
#Leave the Place
@export var button_left : Button
@export var place_left : String

@export var button_right : Button
@export var place_right : String

@export var button_up : Button
@export var place_up : String

@export var button_down : Button
@export var place_down : String

@export_category("INTERACTABLES")

@export var interactable_list : Array[Interactable]

@export var dialogue_list : Array[DialogueLine]

func _ready() -> void:
	var functions : Array[Callable] = [pressed_button_left,pressed_button_right,pressed_button_up,pressed_button_down]
	var buttons : Array[Button] = [button_left, button_right, button_up, button_down]
	var i := 0
	while i < buttons.size() :
		if buttons[i]:
			buttons[i].pressed.connect(functions[i])
		i+=1
	for interactable in interactable_list:
		interactable.open_dialogue.connect(send_dialogue_request)
		interactable.open_puzzle.connect(send_puzzle_request)
	
	await get_tree().create_timer(1).timeout
	if dialogue_list:
		open_dialogue.emit(dialogue_list)

func pressed_button_left():
	go_to.emit(place_left)

func pressed_button_right():
	go_to.emit(place_right)
	
func pressed_button_up():
	go_to.emit(place_up)
	
func pressed_button_down():
	go_to.emit(place_down)

func send_dialogue_request(dialogue_array : Array[DialogueLine]):
	open_dialogue.emit(dialogue_array)

func send_puzzle_request(puzzle : String):
	open_puzzle.emit(puzzle)
