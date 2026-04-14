extends Place

func _ready() -> void:
	if global.bedroom_intro:
		dialogue_list = []
	super()
	global.bedroom_intro = true
