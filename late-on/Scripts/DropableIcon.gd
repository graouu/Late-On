extends Area2D

var draggable = false
var is_inside_dropable = false
var body_ref
var current_body
var initialPos: Vector2
var offset: Vector2

# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	if draggable:
		# Makes the object follow the mouse cursor
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			#Snap inside area when released inside droppable area
			if is_inside_dropable:
				tween.tween_property(self,"global_position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
				body_ref.is_inside_empty = false
				current_body = body_ref
			#Return to original pos when released outside droppable area
			else:
				tween.tween_property(self,"global_position",initialPos, 0.2).set_ease(Tween.EASE_OUT)

#Change le scale de l'icon et le rend drag
func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		draggable = true
		scale = Vector2(1.05,1.05)

func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		draggable = false
		scale = Vector2(1,1)

 #Quand l icon est sur une zone de drop
func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('dropable_perso') and body.is_inside_empty:
		is_inside_dropable = true
		body.modulate = Color(Color.GRAY, 1)
		body_ref = body
		# libérer les cases vides
		if current_body and current_body != body_ref:
			current_body.is_inside_empty = true

func _on_area_2d_body_exited(body):
	if body.is_in_group('dropable_perso'):
		is_inside_dropable = false
		body.modulate = Color(Color.GRAY, 0.7)
