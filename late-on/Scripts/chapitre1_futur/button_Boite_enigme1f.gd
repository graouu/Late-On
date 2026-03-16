extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	#A changer quand je fais l'énigme1
	#get_tree().change_scene_to_file("res://Scenes/Passé/Passé_Enigme2.tscn")
	global.enigme1f_fini = true

func _on_mouse_entered() -> void:
	scale = Vector2(1.05,1.05)

func _on_mouse_exited() -> void:
	scale = Vector2(1,1)
