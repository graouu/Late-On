extends Button

@onready var BlockMenteur = $"../BlockMenteur"
@onready var JobMenteur = $"../JobMenteur"
@onready var PopUp = $"../PopUp"
@onready var PopUpText = $"../PopUp/TextPopUp"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PopUp.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global.is_dragging:
		PopUp.visible = false

func _on_pressed() -> void:
	PopUp.visible = true
	if BlockMenteur.name_inside == "Perso3" and JobMenteur.name_inside == "Job2":
		PopUpText.text = "C'est bien l'intrus :)"
	else:
		global.Duo3_NbTry += 1
		if global.Duo3_NbTry == 1 :
			PopUpText.text = "Ce n'est pas ça"
			await get_tree().create_timer(5).timeout
			PopUp.visible = false
		if global.Duo3_NbTry >= 2 :
			PopUpText.text = "Tu agis de manière suspecte"
			await get_tree().create_timer(5).timeout
			PopUp.visible = false
		if global.Duo3_NbTry >= 5 :
			PopUpText.text = "L'intrus t'a remarqué :("
			await get_tree().create_timer(5).timeout
			PopUp.visible = false

func _on_mouse_entered() -> void:
	scale = Vector2(1.05,1.05)

func _on_mouse_exited() -> void:
	scale = Vector2(1,1)
