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
	if BlockMenteur.name_inside == "Perso3" and JobMenteur.name_inside == "Job2":
		PopUp.visible = true
		PopUpText.text = "C'est bien l'intrus :)"
		print ("Réussit :) On passe à l'épilogue")
	else:
		global.Duo3_NbTry += 1
		PopUp.visible = true
		if global.Duo3_NbTry == 1 :
			PopUpText.text = "Ce n'est pas ça"
		if global.Duo3_NbTry >= 2 :
			PopUpText.text = "Tu agis de manière suspecte"
		if global.Duo3_NbTry >= 5 :
			PopUpText.text = "L'intrus t'a remarqué :("
			print ("Echec :( C'est le menteur qui nous détecte, on passe à l'épilogue")

func _on_mouse_entered() -> void:
	scale = Vector2(1.05,1.05)

func _on_mouse_exited() -> void:
	scale = Vector2(1,1)
