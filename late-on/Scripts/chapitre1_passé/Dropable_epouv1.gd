extends Area2D

var draggable = false
var is_inside_dropable = false
var body_ref
var current_body
var placed = false
var initialPos: Vector2
var offset: Vector2
@export var poc_SFX : AudioStreamPlayer

#La zone couverte
@onready var Ep1A = $Sprite2D/Ep1A
@onready var Ep1C = $Sprite2D/Ep1C
@onready var Ep1D = $Sprite2D/Ep1D

# Lien avec toutes les cases:
@onready var A1 = $"../../PositionGrid/A1"
@onready var A2 = $"../../PositionGrid/A2"
@onready var A3 = $"../../PositionGrid/A3"
@onready var A4 = $"../../PositionGrid/A4"
@onready var B1 = $"../../PositionGrid/B1"
@onready var B2 = $"../../PositionGrid/B2"
@onready var B3 = $"../../PositionGrid/B3"
@onready var B4 = $"../../PositionGrid/B4"
@onready var C1 = $"../../PositionGrid/C1"
@onready var C2 = $"../../PositionGrid/C2"
@onready var C3 = $"../../PositionGrid/C3"
@onready var C4 = $"../../PositionGrid/C4"
@onready var D1 = $"../../PositionGrid/D1"
@onready var D2 = $"../../PositionGrid/D2"
@onready var D3 = $"../../PositionGrid/D3"
@onready var D4 = $"../../PositionGrid/D4"
@onready var E1 = $"../../PositionGrid/E1"
@onready var E2 = $"../../PositionGrid/E2"
@onready var E3 = $"../../PositionGrid/E3"
@onready var E4 = $"../../PositionGrid/E4"
@onready var F1 = $"../../PositionGrid/F1"
@onready var F2 = $"../../PositionGrid/F2"
@onready var F3 = $"../../PositionGrid/F3"
@onready var F4 = $"../../PositionGrid/F4"

# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	if draggable:
		# Makes the object follow the mouse cursor
		if Input.is_action_just_pressed("click"):
			poc_SFX.play()
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
			global.type = "job"
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			#Snap inside area when released inside droppable area
			if is_inside_dropable:
				valeur_tilte()
				tween.tween_property(self,"global_position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
				poc_SFX.play()
				body_ref.is_inside_empty = false
				body_ref.name_inside = self.name
				global.type = "empty"
				current_body = body_ref
			#Return to original pos when released outside droppable area
			else:
				tween.tween_property(self,"global_position",initialPos, 0.2).set_ease(Tween.EASE_OUT)
				poc_SFX.play()

#Change le scale de l'icon et le rend drag
func _on_area_2d_mouse_entered():
	print("dans draggable")
	if not global.is_dragging:
		print("dragging")
		draggable = true
		scale = Vector2(1.05,1.05)
		Ep1A.visible = true
		Ep1C.visible = true
		Ep1D.visible = true

func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		draggable = false
		scale = Vector2(1,1)
		if placed == false:
			Ep1A.visible = false
			Ep1C.visible = false
			Ep1D.visible = false

 #Quand l icon est sur une zone de drop
func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_inside_empty:
		is_inside_dropable = true
		body.modulate = Color(Color.SKY_BLUE, 0.5)
		body_ref = body
		# libérer les cases vides
		if current_body and current_body != body_ref:
			current_body.is_inside_empty = true
			current_body.name_inside = "empty"

func _on_area_2d_body_exited(body):
	if body.is_in_group('dropable_job'):
		is_inside_dropable = false
		body.modulate = Color(Color.SKY_BLUE, 0.3)

func valeur_tilte() :
	# Mettre à 0 toutes les valeurs de title pour l'épouvantaile 1 car déplacement:
	A1.valueEp1 = 0
	A2.valueEp1 = 0
	A3.valueEp1 = 0
	A4.valueEp1 = 0
	B1.valueEp1 = 0
	B2.valueEp1 = 0
	B3.valueEp1 = 0
	B4.valueEp1 = 0
	C1.valueEp1 = 0
	C2.valueEp1 = 0
	C3.valueEp1 = 0
	C4.valueEp1 = 0
	D1.valueEp1 = 0
	D2.valueEp1 = 0
	D3.valueEp1 = 0
	D4.valueEp1 = 0
	E1.valueEp1 = 0
	E2.valueEp1 = 0
	E3.valueEp1 = 0
	E4.valueEp1 = 0
	F1.valueEp1 = 0
	F2.valueEp1 = 0
	F3.valueEp1 = 0
	F4.valueEp1 = 0

# Visibilité à chaque title + valur de l'épouvantail
	if body_ref.name == "01" or body_ref.name == "02" or body_ref.name == "03":
			placed = false
			Ep1A.visible = false
			Ep1C.visible = false
			Ep1D.visible = false

	if body_ref.name == "A1":
			placed = true
			Ep1A.visible = false
			A1.valueEp1 = 1
			A2.valueEp1 = 1
			B2.valueEp1 = 1
	if body_ref.name == "A2":
			placed = true
			A1.valueEp1 = 1
			A2.valueEp1 = 1
			A3.valueEp1 = 1
			B3.valueEp1 = 1
	if body_ref.name == "A3":
			placed = true
			A2.valueEp1 = 1
			A3.valueEp1 = 1
			A4.valueEp1 = 1
			B4.valueEp1 = 1
	if body_ref.name == "A4":
			placed = true
			Ep1C.visible = false
			Ep1D.visible = false
			A3.valueEp1 = 1
			A4.valueEp1 = 1

	if body_ref.name == "B1":
			placed = true
			Ep1A.visible = false
			B1.valueEp1 = 1
			B2.valueEp1 = 1
			C2.valueEp1 = 1
	if body_ref.name == "B2":
			placed = true
			B1.valueEp1 = 1
			B2.valueEp1 = 1
			B3.valueEp1 = 1
			C3.valueEp1 = 1
	if body_ref.name == "B3":
			placed = true
			B2.valueEp1 = 1
			B3.valueEp1 = 1
			B4.valueEp1 = 1
			C4.valueEp1 = 1
	if body_ref.name == "B4":
			placed = true
			Ep1C.visible = false
			Ep1D.visible = false
			B3.valueEp1 = 1
			B4.valueEp1 = 1

	if body_ref.name == "C1":
			placed = true
			Ep1A.visible = false
			C1.valueEp1 = 1
			C2.valueEp1 = 1
			D2.valueEp1 = 1
	if body_ref.name == "C2":
			placed = true
			C1.valueEp1 = 1
			C2.valueEp1 = 1
			C3.valueEp1 = 1
			D3.valueEp1 = 1
	if body_ref.name == "C3":
			placed = true
			C2.valueEp1 = 1
			C3.valueEp1 = 1
			C4.valueEp1 = 1
			D4.valueEp1 = 1
	if body_ref.name == "C4":
			placed = true
			Ep1C.visible = false
			Ep1D.visible = false
			C3.valueEp1 = 1
			C4.valueEp1 = 1

	if body_ref.name == "D1":
			placed = true
			Ep1A.visible = false
			D1.valueEp1 = 1
			D2.valueEp1 = 1
			E2.valueEp1 = 1
	if body_ref.name == "D2":
			placed = true
			D1.valueEp1 = 1
			D2.valueEp1 = 1
			D3.valueEp1 = 1
			E3.valueEp1 = 1
	if body_ref.name == "D3":
			placed = true
			D2.valueEp1 = 1
			D3.valueEp1 = 1
			D4.valueEp1 = 1
			E4.valueEp1 = 1
	if body_ref.name == "D4":
			placed = true
			Ep1C.visible = false
			Ep1D.visible = false
			D3.valueEp1 = 1
			D4.valueEp1 = 1

	if body_ref.name == "E1":
			placed = true
			Ep1A.visible = false
			E1.valueEp1 = 1
			E2.valueEp1 = 1
			F2.valueEp1 = 1
	if body_ref.name == "E2":
			placed = true
			E1.valueEp1 = 1
			E2.valueEp1 = 1
			E3.valueEp1 = 1
			F3.valueEp1 = 1
	if body_ref.name == "E3":
			placed = true
			E2.valueEp1 = 1
			E3.valueEp1 = 1
			E4.valueEp1 = 1
			F4.valueEp1 = 1
	if body_ref.name == "E4":
			placed = true
			Ep1C.visible = false
			Ep1D.visible = false
			E3.valueEp1 = 1
			E4.valueEp1 = 1

	if body_ref.name == "F1":
			placed = true
			Ep1A.visible = false
			Ep1D.visible = false
			F1.valueEp1 = 1
			F2.valueEp1 = 1
	if body_ref.name == "F2":
			placed = true
			Ep1D.visible = false
			F1.valueEp1 = 1
			F2.valueEp1 = 1
			F3.valueEp1 = 1
	if body_ref.name == "F3":
			placed = true
			Ep1D.visible = false
			F2.valueEp1 = 1
			F3.valueEp1 = 1
			F4.valueEp1 = 1
	if body_ref.name == "F4":
			placed = true
			Ep1C.visible = false
			Ep1D.visible = false
			F3.valueEp1 = 1
			F4.valueEp1 = 1
