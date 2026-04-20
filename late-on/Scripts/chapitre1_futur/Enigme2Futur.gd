extends Node2D

#Sound
@export var scene_music: AudioStream
@export var computer_music: AudioStream
@export var silence_music: AudioStream
@export var arrows_SFX : AudioStreamPlayer
@export var error_SFX : AudioStreamPlayer
@export var success_SFX : AudioStreamPlayer
@export var ChronoVoice_SFX : AudioStreamPlayer
@export var ChronoVoice_timer : Timer
var tweenChronoVoice1 : Tween
var tweenChronoVoice2 : Tween

#ChronoPote
var chrono_happy = preload("res://Assets/Textures/ChronoPote/tongue.png")
var chrono_neutral = preload("res://Assets/Textures/ChronoPote/neutral.png")
var chrono_error = preload("res://Assets/Textures/ChronoPote/wtf.png")
var chrono_success = preload("res://Assets/Textures/ChronoPote/heart.png")
var first_talk = true

#positions
@onready var SpaceTypeMap1 = $SpaceTypeMap1
@onready var SpaceTypeMap2 = $SpaceTypeMap2
@onready var SpaceTypeMap3 = $SpaceTypeMap3
@onready var SpaceTypeMap4 = $SpaceTypeMap4
@onready var ButtonValidate = $Button_Validate
@onready var ButtonReturn = $Button_Return
@onready var PopUpText = $PopUp/TextPopUp
@onready var chronoPote = $ChronoPote

signal end_puzzle(dialogue : String)
signal quit_puzzle

@export var dialogue_to_play : Array[DialogueLine]

func _ready() -> void:
	AudioManager.play_music(scene_music)

func _process(delta: float) -> void:
	#LA premiere fois qu'il joue le chronopote parle
	if global.is_dragging and first_talk:
		first_talk = false
		ChronoVoice_timer.wait_time = 0.02 * "Je crois en toi! tu peux le faire! Pense à tous ces points que tu vas gagner!!!".length()
		chronoPote.texture = chrono_happy
		tweenChronoVoice1 = get_tree().create_tween()
		tweenChronoVoice1.tween_property(PopUpText,"text","Je crois en toi! tu peux le faire! Pense à tous ces points que tu vas gagner!!!", ChronoVoice_timer.wait_time)
		ChronoVoice_timer.start()
		ChronoVoice_SFX.play()
		await ChronoVoice_timer.timeout
		tweenChronoVoice1.kill()
		ChronoVoice_timer.stop()
		ChronoVoice_SFX.stop()
	
	#Si la partie menteur est complète, proposer de valider
	if SpaceTypeMap1.name_inside != "empty" and SpaceTypeMap2.name_inside != "empty" and SpaceTypeMap3.name_inside != "empty" and SpaceTypeMap4.name_inside != "empty":
		ButtonValidate.visible = true
	else:
		ButtonValidate.visible = false

func _on_button_return_pressed() -> void:
	arrows_SFX.play()
	AudioManager.play_music(computer_music)
	quit_puzzle.emit()

func _on_button_validate_pressed() -> void:
	arrows_SFX.play()
	if SpaceTypeMap1.name_inside == "TypeMap4" and SpaceTypeMap2.name_inside == "TypeMap3" and SpaceTypeMap3.name_inside == "TypeMap2" and SpaceTypeMap4.name_inside == "TypeMap1":
		
		#blabla Chronopote
		ChronoVoice_timer.wait_time = 0.02 * "Bravo c'est la bonne solution! Tu es vraiment trop fort! Tu as bien mérité ces 500 points! Je suis heureux de t'avoir comme employé".length()
		chronoPote.texture = chrono_success
		PopUpText.text = ""
		tweenChronoVoice2 = get_tree().create_tween()
		tweenChronoVoice2.tween_property(PopUpText,"text","Bravo c'est la bonne solution! Tu es vraiment trop fort! Tu as bien mérité ces 500 points! Je suis heureux de t'avoir comme employé", ChronoVoice_timer.wait_time)
		ChronoVoice_timer.start()
		ChronoVoice_SFX.play()
		await ChronoVoice_timer.timeout
		tweenChronoVoice2.kill()
		ChronoVoice_timer.stop()
		ChronoVoice_SFX.stop()
		
		#Fin du puzzle
		global.enigme2f_fini = true
		AudioManager.play_music(silence_music)
		success_SFX.play()
		await get_tree().create_timer(2).timeout
		AudioManager.play_music(computer_music)
		get_parent().get_parent().current_place.name = "desktop"
		AudioManager.play_music(computer_music)
		end_puzzle.emit(dialogue_to_play)

	else:
		global.enigme2f_Nbtry = global.enigme2f_Nbtry +1
		chronoPote.texture = chrono_error
		error_SFX.play()

		if global.enigme2f_Nbtry == 1:
			#blabla Chronopote
			ChronoVoice_timer.wait_time = 0.02 * "Ce n'est pas tout à fait ça. En relisant les consignes, je suis sûr que tu peux y arriver!".length()
			PopUpText.text = ""
			tweenChronoVoice2 = get_tree().create_tween()
			tweenChronoVoice2.tween_property(PopUpText,"text","Ce n'est pas tout à fait ça. En relisant les consignes, je suis sûr que tu peux y arriver!", ChronoVoice_timer.wait_time)
			ChronoVoice_timer.start()
			ChronoVoice_SFX.play()
			await ChronoVoice_timer.timeout
			tweenChronoVoice2.kill()
			ChronoVoice_timer.stop()
			ChronoVoice_SFX.stop()
			chronoPote.texture = chrono_neutral
			
		if global.enigme2f_Nbtry >= 2 and global.enigme2f_Nbtry <= 5:
			#blabla Chronopote
			ChronoVoice_timer.wait_time = 0.02 * "Ce n'est pas ça. Tu as besoin d'un coup de pouce? Le dossier des tenues est tout à gauche".length()
			PopUpText.text = ""
			tweenChronoVoice2 = get_tree().create_tween()
			tweenChronoVoice2.tween_property(PopUpText,"text","Ce n'est pas ça. Tu as besoin d'un coup de pouce? Le dossier des tenues est tout à gauche", ChronoVoice_timer.wait_time)
			ChronoVoice_timer.start()
			ChronoVoice_SFX.play()
			await ChronoVoice_timer.timeout
			tweenChronoVoice2.kill()
			ChronoVoice_timer.stop()
			ChronoVoice_SFX.stop()
			chronoPote.texture = chrono_neutral

		if global.enigme2f_Nbtry >= 5:
			#blabla Chronopote
			ChronoVoice_timer.wait_time = 0.02 * "Ce n'est pas tout à fait ça, mais il est temps que tu passes à la prochaine étape. Voici la solution: 1) Tenues // 2) Batiments // 3) documents // 4) maps".length()
			PopUpText.text = ""
			tweenChronoVoice2 = get_tree().create_tween()
			tweenChronoVoice2.tween_property(PopUpText,"text","Ce n'est pas tout à fait ça, mais il est temps que tu passes à la prochaine étape. Voici la solution: 1) Tenues // 2) Batiments // 3) documents // 4) maps", ChronoVoice_timer.wait_time)
			ChronoVoice_timer.start()
			ChronoVoice_SFX.play()
			await ChronoVoice_timer.timeout
			tweenChronoVoice2.kill()
			ChronoVoice_timer.stop()
			ChronoVoice_SFX.stop()
			chronoPote.texture = chrono_neutral
