extends Place

func _ready() -> void:
	if global.desktop_intro :
		dialogue_list = []
	super()
	global.desktop_intro = true
