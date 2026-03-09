extends AudioStreamPlayer

func _process(delta: float) -> void:
	if playing:
		pitch_scale = randf_range(0.7,1)
