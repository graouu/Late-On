extends Node2D

@onready var Sentence1 = $Sentence1
@onready var Sentence2 = $Sentence2
@onready var Sentence3 = $Sentence3
@onready var Sentence4 = $Sentence4
@onready var Sentence5 = $Sentence5
@onready var Sentence6 = $Sentence6
@onready var BlockMenteur = $BlockMenteur
@onready var JobMenteur = $JobMenteur
@onready var ButtonValidate = $Button_Validate

# Rendre les phrases visibles une fois qu'on a parlé au perso.
func _ready() -> void:
	if global.Duo3_sentence1 :
		Sentence1.visible = true 
	else:
		Sentence1.visible = false

	if global.Duo3_sentence2 :
		Sentence2.visible = true 
	else:
		Sentence2.visible = false

	if global.Duo3_sentence3 :
		Sentence3.visible = true 
	else:
		Sentence3.visible = false

	if global.Duo3_sentence4 :
		Sentence4.visible = true 
	else:
		Sentence4.visible = false

	if global.Duo3_sentence5 :
		Sentence5.visible = true 
	else:
		Sentence5.visible = false

	if global.Duo3_sentence6 :
		Sentence6.visible = true 
	else:
		Sentence6.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Si la partie menteur est complète, proposer de valider
	if BlockMenteur.name_inside != "empty" and JobMenteur.name_inside != "empty":
		ButtonValidate.visible = true
	else:
		ButtonValidate.visible = false
