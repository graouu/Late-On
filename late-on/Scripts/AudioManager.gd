extends Node

var current_music: AudioStreamPlayer

@export var music_bus_index: int = 1
@export var sfx_bus_index: int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func play_music(music_stream: AudioStream):
	if current_music:
		current_music.stop()
		remove_child(current_music)
	
	current_music = AudioStreamPlayer.new()
	current_music.stream = music_stream
	current_music.bus = "Music"
	current_music.autoplay = true
	current_music.volume_db = 0
	add_child (current_music)
	current_music.play()

func set_volume(bus_index: int, linear_value: float):
	var db = linear_to_db(linear_value)
	AudioServer.set_bus_volume_db(bus_index, db)

func get_volume(bus_index: int) -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(bus_index))
