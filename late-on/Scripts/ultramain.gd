extends Control

@export var optionbutton : OptionButton

func _ready() -> void:
	for file_name in DirAccess.get_files_at("res://Place/Passé/"):
		optionbutton.add_item(file_name.replace(".tscn",""))

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Passé/Main.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Futur/Main2.tscn")



func _on_option_button_item_selected(index: int) -> void:
	var hello = preload("res://Scenes/Passé/Main.tscn").instantiate()
	hello.move(optionbutton.get_item_text(index))
	get_tree().get_root().add_child(hello)
	queue_free()
