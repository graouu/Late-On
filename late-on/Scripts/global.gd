extends Node

#Savoir si le joueur utilise l'option dragdrop
var is_dragging = false
var type = "empty"

#Chapitre1 passé
var enigme1_fini = false
var enigme2_fini = false
var enigme3_fini = false
var enigme4_fini = false
var enigme5_fini = false
var enigme6_fini = false

#Pharses pour l'énigme 4
var enigme4_sentence1 = false
var enigme4_sentence2 = false
var enigme4_sentence3 = false
var enigme4_sentence4 = false

#Pharses de l'énigme 3 en Duo
var Duo3_sentence1 = false
var Duo3_sentence2 = false
var Duo3_sentence3 = false
var Duo3_sentence4 = false
var Duo3_sentence5 = false
var Duo3_sentence6 = false
var Duo3_NbTry = 0

#Chapitre1 futur
var enigme1f_fini = false
var enigme2f_fini = false
var enigme3f_fini = false
var enigme4f_fini = false
var enigme5f_fini = false
var enigme6f_fini = false
var enigme2f_Nbtry = 0
var enigme4f_Nbtry = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
