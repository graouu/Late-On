extends Place

func _ready() -> void:
	if global.enigme1f_fini:
		dialogue_list = []
	super()
