extends TextureButton

@onready var PopUp = $"../PopUp"
@onready var PopUpText = $"../PopUp/RichTextLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	global.Duo3_sentence5 = true
	PopUp.visible = true
	PopUpText.text = "blabla perso 5. Je ne suis pas en charge des dialogues"
	await get_tree().create_timer(10).timeout
	PopUp.visible = false

func _on_mouse_entered() -> void:
	scale = Vector2(1.05,1.05)

func _on_mouse_exited() -> void:
	scale = Vector2(1,1)
