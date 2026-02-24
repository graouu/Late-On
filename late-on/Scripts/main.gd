extends Control

#Parent de l'endroit actuel
@export var place_control : Control
#Endroit actuel
@export var current_place : Place
#Dictionnaire des endroits
@export var place_dic : Dictionary[String, PackedScene]
#Animateur de la texture noire pour la transition
@export var black_anim : AnimationPlayer

func _ready() -> void:
	load_places()
	current_place = place_control.get_child(0)
	current_place.go_to.connect(move)
	

#Charge toutes les scènes d'endroits dans le dossier Place
#dans un dictionnaire (clé : nom de l'endroit)
func load_places():
	for file_name in DirAccess.get_files_at("res://Place/"):
		place_dic[file_name.replace(".tscn","")] = (load("res://Place/" + file_name))
		#On retire '.tscn', l'extension du fichier

#Retire l'endroit actuel et le remplace par l'endroit 'place'
func move(place : String):
	
	black_anim.play('transition')
	await black_anim.animation_finished
	
	place_control.get_child(0).queue_free()
	current_place = place_dic[place].instantiate()
	place_control.add_child(current_place)
	current_place.go_to.connect(move)
	
	black_anim.play('detransition')
