extends Control

#Parent de l'endroit actuel
@export var place_control : Control

@export var is_past : bool

@export var label_place : Label

@export var puzzle_control : Control
var loaded_puzzle
#Endroit actuel
@export var current_place : Place
#Dictionnaire des endroits
@export var place_dic : Dictionary[String, PackedScene]
#Animateur de la texture noire pour la transition
@export var black_anim : AnimationPlayer
#Node qui gère les dialogue_manager
@export var dialogue_manager : DialogueManager

func _ready() -> void:
	
	#On utilise la fonction qui charge tous les endroits
	load_places()
	
	#On définit la place actuelle (celle présente actuellement)
	current_place = place_control.get_child(0)
	
	current_place.open_dialogue.connect(dialogue_manager.play_dialogue_array)
	
	#On connecte le signal de mouvement de la place actuelle à la fonction qui déplace
	current_place.go_to.connect(move)
	current_place.open_puzzle.connect(load_puzzle)
	
	label_place.text = current_place.place_name
	
	#On connecte le signal de dialogue de la place actuelle à la fonction qui lance un dialogue
	

#Charge toutes les scènes d'endroits dans le dossier Place
#dans un dictionnaire (clé : nom de l'endroit)
func load_places():
	if is_past:
		for file_name in DirAccess.get_files_at("res://Place/Passé/"):
			place_dic[file_name.replace(".tscn","").replace(".remap","")] = (load("res://Place/Passé/" + file_name.replace(".remap","")))
			#On retire '.tscn', l'extension du fichier
	else:
		for file_name in DirAccess.get_files_at("res://Place/Futur/"):
			place_dic[file_name.replace(".tscn","").replace(".remap","")] = (load("res://Place/Futur/" + file_name.replace(".remap","")))

#Retire l'endroit actuel et le remplace par l'endroit 'place'
func move(place : String):
	
	#Animation 'fadeaway'
	black_anim.play('transition')
	#On attend qu'elle finisse
	await black_anim.animation_finished
	
	#On supprime la place actuelle
	place_control.get_child(0).queue_free()
	
	#On instancie la nouvelle place
	current_place = place_dic[place].instantiate()
	
	#On la met au bon endroit dans l'arborescence
	place_control.add_child(current_place)
	
	#On la met à la bonne position
	current_place.position = Vector2(0,0)
	
	#On connecte ses signaux
	current_place.go_to.connect(move)
	current_place.open_puzzle.connect(load_puzzle)
	current_place.open_dialogue.connect(dialogue_manager.play_dialogue_array)
	label_place.text = current_place.place_name
	
	#On joue le 'fadeaway' inverse
	black_anim.play('detransition')

func load_puzzle(puzzle : String):
	puzzle_control.show()
	loaded_puzzle = load(puzzle).instantiate()
	puzzle_control.add_child(loaded_puzzle)
	loaded_puzzle.end_puzzle.connect(end_puzzle)
	loaded_puzzle.quit_puzzle.connect(quit_puzzle)

func end_puzzle(dialogue : Array[DialogueLine]):
	puzzle_control.hide()
	puzzle_control.get_child(0).queue_free()
	move(current_place.name)
	if !dialogue.is_empty():
		dialogue_manager.play_dialogue_array(dialogue)

func quit_puzzle():
	puzzle_control.hide()
	puzzle_control.get_child(0).queue_free()
	


func _on_go_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/ULTRAMAIN.tscn")
	queue_free()
