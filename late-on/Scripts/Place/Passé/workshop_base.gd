extends Place

func _ready() -> void:
	if global.enigme1_fini :
		button_right.show()
		interactable_list[0].interaction_type = 0
	super()
