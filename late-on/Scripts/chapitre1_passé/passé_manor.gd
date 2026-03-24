extends Control

@onready var ButtonBook = $Button_Book
@onready var PopUp = $PopUp
@onready var PopUpText = $PopUp/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#A modifier en fonction du systeme de dialogue de Balthazar
func _on_button_perso_1_pressed() -> void:
	global.enigme4_sentence1 = true
	PopUp.visible = true
	PopUpText.text = "blabla perso 1. Je ne suis pas en charge des dialogues"
	await get_tree().create_timer(5).timeout
	PopUp.visible = false

func _on_button_perso_1_mouse_entered() -> void:
	print("hello")
	ButtonBook.scale = Vector2(1.05,1.05)

func _on_button_perso_1_mouse_exited() -> void:
	ButtonBook.scale = Vector2(1,1)

func _on_button_perso_2_pressed() -> void:
	global.enigme4_sentence2 = true
	PopUp.visible = true
	PopUpText.text = "blabla perso 2. Je ne suis pas en charge des dialogues"
	await get_tree().create_timer(5).timeout
	PopUp.visible = false

func _on_button_perso_3_pressed() -> void:
	global.enigme4_sentence3 = true
	PopUp.visible = true
	PopUpText.text = "blabla perso 3. Je ne suis pas en charge des dialogues"
	await get_tree().create_timer(5).timeout
	PopUp.visible = false

func _on_button_perso_4_pressed() -> void:
	global.enigme4_sentence4 = true
	PopUp.visible = true
	PopUpText.text = "blabla perso 4. Je ne suis pas en charge des dialogues"
	await get_tree().create_timer(5).timeout
	PopUp.visible = false

#Ca il faut garder pour aller à l'énigme
func _on_button_book_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Passé/Passé_Enigme4.tscn")
