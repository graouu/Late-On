extends Node2D

#Sound
@export var scene_music: AudioStream
@export var out_music: AudioStream
@export var silence_music: AudioStream
@export var arrows_SFX : AudioStreamPlayer
@export var error_SFX : AudioStreamPlayer
@export var success_SFX : AudioStreamPlayer

signal end_puzzle(dialogue : String)
signal quit_puzzle

var conditionOk = true
var conditionPb = 0
@onready var Epouv1 = $Epouv1/Epouv1
@onready var Epouv2 = $Epouv2/Epouv2
@onready var Epouv3 = $Epouv3/Epouv3
@onready var ButtonValidate = $Button_Validate
@onready var ButtonReturn = $Button_Return
@onready var PopUp = $PopUp
@onready var PopUpText = $PopUp/TextPopUp

#Valeur de toutes les tiltes :|
@onready var A1 = $PositionGrid/A1
@onready var A2 = $PositionGrid/A2
@onready var A3 = $PositionGrid/A3
@onready var A4 = $PositionGrid/A4
@onready var B1 = $PositionGrid/B1
@onready var B2 = $PositionGrid/B2
@onready var B3 = $PositionGrid/B3
@onready var B4 = $PositionGrid/B4
@onready var C1 = $PositionGrid/C1
@onready var C2 = $PositionGrid/C2
@onready var C3 = $PositionGrid/C3
@onready var C4 = $PositionGrid/C4
@onready var D1 = $PositionGrid/D1
@onready var D2 = $PositionGrid/D2
@onready var D3 = $PositionGrid/D3
@onready var D4 = $PositionGrid/D4
@onready var E1 = $PositionGrid/E1
@onready var E2 = $PositionGrid/E2
@onready var E3 = $PositionGrid/E3
@onready var E4 = $PositionGrid/E4
@onready var F1 = $PositionGrid/F1
@onready var F2 = $PositionGrid/F2
@onready var F3 = $PositionGrid/F3
@onready var F4 = $PositionGrid/F4

func _ready() -> void:
	#Gestion de la musique
	AudioManager.play_music(scene_music)

func _process(delta: float) -> void:
	#Si le joueur joue, la pop up disparait
	if global.is_dragging:
		PopUp.visible = false
	if Epouv1.placed == true and Epouv2.placed == true and Epouv3.placed == true:
		ButtonValidate.visible = true
	else:
		ButtonValidate.visible = false

func _on_button_return_pressed() -> void:
	arrows_SFX.play()
	AudioManager.play_music(out_music)
	quit_puzzle.emit()

func _on_button_validate_pressed() -> void:
	PopUp.visible = true
	conditionOk = true
	arrows_SFX.play()
	validate_conditions()
	if conditionOk :
		AudioManager.play_music(silence_music)
		success_SFX.play()
		PopUpText.text = "Cette combinaison correspond à l'attendu. Merci employé, tu as très bien travaillé. Tu as bien mérité 500 points!"
		global.enigme3f_fini = true
		await get_tree().create_timer(1.5).timeout
		AudioManager.play_music(out_music)
		end_puzzle.emit()
		quit_puzzle.emit()

	else:
		global.enigme3f_Nbtry += 1
		error_SFX.play()
		if conditionPb == 1 :
			PopUpText.text = "Le manoir manque de connection. C'est un membre de l'élite, on ne peux pas laisser la situation ainsi :("
		if conditionPb == 2 :
			PopUpText.text = "Il y a des entreprises sans réseaux. Fait en sorte que tous les employés reste en activité ;)"
		if conditionPb == 3 :
			PopUpText.text = "Il a des non-clients recevant du reseau. Ce n'est pas une situation acceptable"
		if global.enigme3f_Nbtry == 1:
			PopUpText.text += '\n' + "Mais tu vas y arriver :) "
		if global.enigme3f_Nbtry == 1 or global.enigme3f_Nbtry == 2 or global.enigme3f_Nbtry == 3 :
			PopUpText.text += '\n' + "petit indice: l'émetteur bleue va sur le manoir ;) "
		if global.enigme3f_Nbtry >= 4:
			PopUpText.text += '\n' + "Bleu sur manoir // Vert à gauche du bleu // Rouge 2 espaces à gauche du vert"

func validate_conditions():
	#Calcul de la somme pour chaque title utile
	A3.valueTot = A3.valueEp1 + A3.valueEp2 + A3.valueEp3
	A4.valueTot = A4.valueEp1 + A4.valueEp2 + A4.valueEp3
	B1.valueTot = B1.valueEp1 + B1.valueEp2 + B1.valueEp3
	B2.valueTot = B2.valueEp1 + B2.valueEp2 + B2.valueEp3
	B3.valueTot = B3.valueEp1 + B3.valueEp2 + B3.valueEp3
	B4.valueTot = B4.valueEp1 + B4.valueEp2 + B4.valueEp3
	C1.valueTot = C1.valueEp1 + C1.valueEp2 + C1.valueEp3
	C2.valueTot = C2.valueEp1 + C2.valueEp2 + C2.valueEp3
	D2.valueTot = D2.valueEp1 + D2.valueEp2 + D2.valueEp3
	D3.valueTot = D3.valueEp1 + D3.valueEp2 + D3.valueEp3
	D4.valueTot = D4.valueEp1 + D4.valueEp2 + D4.valueEp3
	E2.valueTot = E2.valueEp1 + E2.valueEp2 + E2.valueEp3
	E3.valueTot = E3.valueEp1 + E3.valueEp2 + E3.valueEp3
	E4.valueTot = E4.valueEp1 + E4.valueEp2 + E4.valueEp3
	F1.valueTot = F1.valueEp1 + F1.valueEp2 + F1.valueEp3
	F2.valueTot = F2.valueEp1 + F2.valueEp2 + F2.valueEp3

	# Cas blé
	if D3.valueTot <2 :
		conditionPb = 1
		conditionOk = false

	# Cas Vigne
	if A3.valueTot <1 or A4.valueTot <1 or B3.valueTot <1 or B4.valueTot <1 or D2.valueTot <1 or E2.valueTot <1 or E3.valueTot <1:
		conditionPb = 2
		conditionOk = false

	# Cas Vigne
	if B1.valueTot > 0 or B2.valueTot > 0 or C1.valueTot > 0 or C2.valueTot > 0 or D4.valueTot > 0 or E4.valueTot > 0 or F1.valueTot > 0 or F2.valueTot > 0 :
		conditionPb = 3
		conditionOk = false

#func _on_button_return_mouse_entered() -> void:
	#ButtonReturn.scale = Vector2(1.05,1.05)
#
#func _on_button_return_mouse_exited() -> void:
	#ButtonReturn.scale = Vector2(1,1)

#func _on_button_validate_mouse_entered() -> void:
	#ButtonValidate.scale = Vector2(1.05,1.05)
#
#func _on_button_validate_mouse_exited() -> void:
	#ButtonValidate.scale = Vector2(1,1)
