extends Control

@export var pause_key: String = "pause"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/ResumeButton.pressed.connect(_on_resume_pressed)
	$VBoxContainer/MusicHSlider.value = AudioManager.get_volume(AudioManager.music_bus_index)
	$VBoxContainer/FXHSlider.value = AudioManager.get_volume(AudioManager.sfx_bus_index)

	$VBoxContainer/MusicHSlider.value_changed.connect(_on_music_volume_changed)
	$VBoxContainer/FXHSlider.value_changed.connect(_on_sfx_volume_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#A changer pour le bouton pause
	if Input.is_action_just_pressed(pause_key):
		toggle_pause()

func toggle_pause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused

func _on_resume_pressed():
	get_tree().paused = false
	
	visible = false

func _on_music_volume_changed(value):
	AudioManager.set_volume(AudioManager.music_bus_index, value)

func _on_sfx_volume_changed(value):
	AudioManager.set_volume(AudioManager.sfx_bus_index, value)
