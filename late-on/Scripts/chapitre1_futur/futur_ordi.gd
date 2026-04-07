extends Control

@onready var Button_Box = $Button_Boite
@onready var ScreenLock = $ColorRect
@onready var Button_Doc = $Button_Cartes
@onready var Button_Page = $Button_Page
var texture_initial = preload("res://Assets/Textures/Buttons_Proto/placeHolderScribe.png")
var texture_final = preload("res://Assets/Textures/Buttons_Proto/SmallMap.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.enigme1f_fini == false :
		Button_Box.visible = true
		ScreenLock.visible = true
		Button_Doc.visible = false
	else:
		Button_Box.visible = false
		ScreenLock.visible = false
		Button_Doc.visible = true
		if global.enigme2f_fini == false :
			Button_Doc.texture_normal = texture_initial
		else:
			if global.enigme3f_fini == false and global.enigme4f_fini == false:
				Button_Doc.texture_normal = texture_final
			if global.enigme3f_fini and global.enigme4f_fini == false:
				Button_Doc.texture_normal = texture_initial
			if global.enigme3f_fini and global.enigme4f_fini:
				Button_Doc.texture_normal = texture_final

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_page_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Futur/Page_Futur.tscn")

func _on_button_page_mouse_entered() -> void:
	Button_Page.scale = Vector2(1.05,1.05)

func _on_button_page_mouse_exited() -> void:
	Button_Page.scale = Vector2(1,1)

func _on_button_boite_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Futur/Futur_Enigme1.tscn")

func _on_button_boite_mouse_entered() -> void:
	Button_Box.scale = Vector2(1.05,1.05)

func _on_button_boite_mouse_exited() -> void:
	Button_Box.scale = Vector2(1,1)

func _on_button_cartes_pressed() -> void:
	if global.enigme2f_fini == false and global.enigme1f_fini:
		get_tree().change_scene_to_file("res://Scenes/Futur/Futur_Enigme2.tscn")
	if global.enigme4f_fini == false and global.enigme3f_fini:
		get_tree().change_scene_to_file("res://Scenes/Futur/Futur_Enigme4.tscn")

func _on_button_cartes_mouse_entered() -> void:
	if global.enigme1f_fini :
		Button_Doc.scale = Vector2(1.05,1.05)

func _on_button_cartes_mouse_exited() -> void:
	if global.enigme1f_fini :
		Button_Doc.scale = Vector2(1,1)
