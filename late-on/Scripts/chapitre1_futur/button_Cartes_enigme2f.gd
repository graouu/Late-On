extends TextureButton

var texture_initial = preload("res://Assets/Buttons_Proto/placeHolderScribe.png")
var texture_final = preload("res://Assets/Buttons_Proto/SmallMap.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.enigme2f_fini :
		texture_normal = texture_final
	else:
		texture_normal = texture_initial

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	if global.enigme2f_fini == false and global.enigme1f_fini:
		get_tree().change_scene_to_file("res://Scenes/Futur/Futur_Enigme2.tscn")

func _on_mouse_entered() -> void:
	if global.enigme2f_fini == false:
		scale = Vector2(1.05,1.05)

func _on_mouse_exited() -> void:
	if global.enigme2f_fini == false:
		scale = Vector2(1,1)
