extends StaticBody2D

var is_inside_empty = true
var soluce_ok = false
var name_inside = "empty"

func _ready():
	modulate = Color(Color.SKY_BLUE, 0.7)

# L'espace est visible lors du drag
func _process(delta):
	if global.is_dragging and global.type == "job" :
		visible = true
	else:
		visible = false
