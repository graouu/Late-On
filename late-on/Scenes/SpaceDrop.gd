extends StaticBody2D

var is_inside_empty = true
var soluce_ok = false

func _ready():
	modulate = Color(Color.GRAY, 0.7)

# L'espace est visible lors du drag
func _process(delta):
	if global.is_dragging:
		visible = true
	else:
		visible = false
