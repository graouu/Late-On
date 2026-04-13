extends Place

func _ready() -> void:
	if global.bed_intro:
		dialogue_list = []
	super()
	global.bed_intro = true
