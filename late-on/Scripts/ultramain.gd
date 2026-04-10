extends Control

@export var optionbutton : OptionButton
@export var optionbutton2 : OptionButton
@export var optionbutton3 : OptionButton

func _ready() -> void:
	for file_name in DirAccess.get_files_at("res://Place/Passé/"):
		optionbutton.add_item(file_name.replace(".tscn","").replace(".remap",""))
	for file_name in DirAccess.get_files_at("res://Place/Futur/"):
		optionbutton2.add_item(file_name.replace(".tscn","").replace(".remap",""))
	for file_name in DirAccess.get_files_at("res://Scenes/Futur/"):
		if file_name.contains("Enigme"):
			optionbutton3.add_item("res://Scenes/Futur/"+file_name.replace(".remap",""))
	for file_name in DirAccess.get_files_at("res://Scenes/Passé/"):
		if file_name.contains("Enigme"):
			optionbutton3.add_item("res://Scenes/Passé/"+file_name.replace(".remap",""))

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Passé/Main.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Futur/Main2.tscn")



func _on_option_button_item_selected(index: int) -> void:
	var hello = preload("res://Scenes/Passé/Main.tscn").instantiate()
	hello.move(optionbutton.get_item_text(index))
	get_tree().get_root().add_child(hello)
	queue_free()

func _on_option_button2_item_selected(index: int) -> void:
	var hello = preload("res://Scenes/Futur/Main2.tscn").instantiate()
	hello.move(optionbutton2.get_item_text(index))
	get_tree().get_root().add_child(hello)
	queue_free()


func _on_option_button_3_item_selected(index: int) -> void:
	get_tree().change_scene_to_file(optionbutton3.get_item_text(index))
