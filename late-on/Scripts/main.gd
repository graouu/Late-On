extends Control

#Parent de l'endroit actuel
@export var place_control : Control
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
	
	#On connecte le signal de mouvement de la place actuelle à la fonction qui déplace
	current_place.go_to.connect(move)
	
	#On connecte le signal de dialogue de la place actuelle à la fonction qui lance un dialogue
	current_place.open_dialogue.connect(dialogue_manager.play_dialogue_array)
	
	
	## TEST DE LA FONCTION DE DIALOGUE
	dialogue_manager.play_dialogue_array([load("res://Assets/Dialogue/test1.tres")])
	

#Charge toutes les scènes d'endroits dans le dossier Place
#dans un dictionnaire (clé : nom de l'endroit)
func load_places():
	for file_name in DirAccess.get_files_at("res://Place/"):
		place_dic[file_name.replace(".tscn","")] = (load("res://Place/" + file_name))
		#On retire '.tscn', l'extension du fichier

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
	current_place.open_dialogue.connect(dialogue_manager.play_dialogue_array)
	
	#On joue le 'fadeaway' inverse
	black_anim.play('detransition')
