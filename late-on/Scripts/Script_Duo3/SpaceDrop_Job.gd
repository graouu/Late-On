extends StaticBody2D

@export var is_inside_empty : bool
var soluce_ok = false
@export var name_inside : String

func _ready():
	modulate = Color(Color.SKY_BLUE, 0.7)

# L'espace est visible lors du drag
func _process(_delta):
	if global.is_dragging and global.type == "job" :
		visible = true
	else:
		visible = false
