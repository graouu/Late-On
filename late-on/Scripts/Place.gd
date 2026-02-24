class_name Place extends Control

signal go_to

@export var place_name : String

#Leave the Place
@export var button_left : Button
@export var place_left : String

@export var button_right : Button
@export var place_right : String

@export var button_up : Button
@export var place_up : String

@export var button_down : Button
@export var place_down : String

func _ready() -> void:
	var functions : Array[Callable] = [pressed_button_left,pressed_button_right,pressed_button_up,pressed_button_down]
	var buttons : Array[Button] = [button_left, button_right, button_up, button_down]
	var i := 0
	while i < buttons.size() :
		if buttons[i]:
			buttons[i].pressed.connect(functions[i])
		i+=1

func pressed_button_left():
	go_to.emit(place_left)

func pressed_button_right():
	go_to.emit(place_right)
	
func pressed_button_up():
	go_to.emit(place_up)
	
func pressed_button_down():
	go_to.emit(place_down)
