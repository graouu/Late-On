extends StaticBody2D

var is_inside_empty = true
var soluce_ok = false
var name_inside = "empty"
var valueEp1 = 0
var valueEp2 = 0
var valueEp3 = 0
var valueTot = 0
var colorE = Color.SKY_BLUE

func _ready():
	modulate = Color(Color.SKY_BLUE, 0.2)

# L'espace est visible lors du drag
func _process(delta):
	if global.is_dragging:
		visible = true
	else:
		visible = false
