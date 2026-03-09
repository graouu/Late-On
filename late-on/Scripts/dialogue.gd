class_name Dialogue extends Control

#Le Label qui affiche le texte
@export var dialogue_label : RichTextLabel
#Le Label qui affiche le nom de la personne
@export var name_label : Label
#La texture de l'objet/personne du dialogue
@export var dialogue_texture : TextureRect
#Le Node qui joue les Sons
@export var sound_player : AudioStreamPlayer
#Le Timer qui gère le temps que prend le dialogue à se jouer
@export var dialogue_timer : Timer

var next_dialogue : String
var tween : Tween

func play_dialogue(text : String, character : String, texture : Texture2D = null):
	dialogue_timer.wait_time = 0.02*text.length()
	dialogue_label.text = ""
	name_label.text = character
	next_dialogue = text
	if texture != null:
		dialogue_texture.texture = texture
	else:
		dialogue_texture.texture = null
	show()
	tween = create_tween()
	tween.tween_property(dialogue_label, "text", next_dialogue, dialogue_timer.wait_time)
	dialogue_timer.start()
	sound_player.play()
	await dialogue_timer.timeout
	dialogue_timer.stop()
	sound_player.stop()
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		if dialogue_timer.is_stopped():
			hide()
		else:
			tween.kill()
			dialogue_label.text = next_dialogue
			dialogue_timer.stop()
			sound_player.stop()
