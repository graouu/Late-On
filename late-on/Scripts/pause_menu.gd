extends Control

@export var pause_key: String = "pause"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/ResumeButton.pressed.connect(_on_resume_pressed)
	#$VBoxContainer/MusicHSlider = global.get_volume(global.music_bus_index)
	#$VBoxContainer/FXHSlider = global.get_volume(global.sfx_bus_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#A changer pour le bouton pause
	if Input.is_action_just_pressed(pause_key):
		toggle_pause()

func toggle_pause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused

func _on_resume_pressed():
	get_tree().paused = false
	
	visible = false
