extends Place

func _ready() -> void:
	if global.enigme1f_fini :
		place_up = "desktop"
	super()
