extends Node2D

@export var scene_music: AudioStream
@export var house_music: AudioStream
@export var silence_music: AudioStream
@export var arrows_SFX : AudioStreamPlayer
@export var mecanism_SFX : AudioStreamPlayer
@export var poc_SFX : AudioStreamPlayer
@export var error_SFX : AudioStreamPlayer
@export var success_SFX : AudioStreamPlayer
#@onready var Up = $Button_Up
@onready var RayUp = $Maze/Ball/RayCastUp
#@onready var Right = $Button_Right
@onready var RayRight = $Maze/Ball/RayCastRight
#@onready var Left = $Button_Left
@onready var RayLeft = $Maze/Ball/RayCastLeft
#@onready var Down = $Button_Down
@onready var RayDown = $Maze/Ball/RayCastDown
@onready var ButtonFabliau = $Button_Fabliau
@onready var ButtonReturn = $Button_Return
@onready var PopUp = $PopUp
@onready var PopUpText = $PopUp/TextPopUp
@onready var Ball = $Maze/Ball
@onready var Wall1 = $Maze/Wall_Key1
@onready var Wall2 = $Maze/Wall_Key2
@onready var Wall3 = $Maze/Wall_Key3
@onready var Wall4 = $Maze/Wall_Key4
@onready var Wall5 = $Maze/Wall_Key5
@onready var Wall6 = $Maze/Wall_Key6
@onready var WallOff1 = $Maze/WallOff_Key1
@onready var WallOff2 = $Maze/WallOff_Key2
@onready var WallOff3 = $Maze/WallOff_Key3
@onready var WallOff4 = $Maze/WallOff_Key4

signal end_puzzle(dialogue : String)
signal quit_puzzle

@export var dialogue_to_play : Array[DialogueLine]

var Move = false
var KeyOk = true
var CollisionWall
var Bounce: Vector2
var Collision: Vector2
var initialPos: Vector2

func _ready() -> void:
	#Gestion de la musique
	AudioManager.play_music(scene_music)
	#PopUpText.text = "Cette boite s'ouvre en faisant en sorte que la bille du labyrinthe active les bons mots. En cas d'oubli, j'ai toujours le fabliaux me permettant de me souvenir des mots et de leur ordre."
	if global.enigme1_Wall1 == false:
		PopUpText.text = "La combinaison a suivre pour débloquer le mécanisme est cachée dans mon fabliau préféré:" + '\n' + "Gérard aimait Isabeau, Isabeau aimait Gérard, mais leur amour était, ainsi que l'amour doit toujours l'être, pur et décent."
	else :
		PopUpText.text = "Repartons du premier paragraphe du fabliau. Gérard attend la joie mais j'aimerais bien qu'il l'atteigne"

	initialPos = Ball.global_position

#Fonctionnement de la boite
func _process(delta: float) -> void:
	if Move:
		KeyOk = false
		var tweenMove = get_tree().create_tween()
		tweenMove.tween_property(Ball,"global_position", Collision, 0.6).set_ease(Tween.EASE_OUT)
		Move = false
		await tweenMove.finished
		var tweenWall = get_tree().create_tween()
		var tweenBounce = get_tree().create_tween()
		tweenBounce.tween_property(Ball,"global_position", Bounce, 0.2).set_ease(Tween.EASE_OUT)

		if CollisionWall == Wall1 :
			poc_SFX.play()
			global.enigme1_Wall1 = true
			tweenWall.tween_property(Wall1,"modulate:a", 0,0.6)
			Wall1.process_mode = Node.PROCESS_MODE_DISABLED
			tweenWall.tween_property(WallOff1,"modulate:a", 0,0.6)
			WallOff1.process_mode = Node.PROCESS_MODE_DISABLED
			KeyOk = true
			mecanism_SFX.play()
			if global.enigme1_Wall2 == false:
				PopUpText.text = "Une si belle union fut troublée tout-à-coup: les parents de la pucelle l'accordèrent en mariage à un vavasseur."

		elif CollisionWall == Wall2 :
			poc_SFX.play()
			global.enigme1_Wall2 = true
			tweenWall.tween_property(WallOff2,"modulate:a", 1,0.6)
			KeyOk = true
			mecanism_SFX.play()
			if global.enigme1_Wall3 == false:
				PopUpText.text = "Gérard vient comme avant lui parler de sa tendresse, mais elle répondit que, ne pouvant désormais le voir sans crime, elle renonçait à lui pour toujours et le pria même de ne jamais se représenter devant elle."

		elif CollisionWall == Wall3 :
			poc_SFX.play()
			global.enigme1_Wall3 = true
			tweenWall.tween_property(WallOff3,"modulate:a", 1,0.6)
			KeyOk = true
			mecanism_SFX.play()
			if global.enigme1_Wall4 == false:
				PopUpText.text = "De désespoir, Gérard se croise pour la Terre Sainte. Cependant, il veut, avant de partir, voir encore une fois sa chère Isabeau. Il se rend chez elle et la trouve dans son verger."

		elif CollisionWall == Wall4 :
			poc_SFX.play()
			global.enigme1_Wall4 = true
			tweenWall.tween_property(WallOff1,"modulate:a", 1,0.6)
			tweenWall.tween_property(WallOff4,"modulate:a", 0,0.6)
			WallOff4.process_mode = Node.PROCESS_MODE_DISABLED
			KeyOk = true
			mecanism_SFX.play()
			if global.enigme1_Wall5 == false:
				PopUpText.text = "Ses adieux sont si touchants qu'ils réveillent tout l'amour que la dame avait pour lui; elle fond en larmes, elle l'embrasse pour la dernière fois et tombe, comme Gérard, sans connaissance."

		elif CollisionWall == Wall5 :
			poc_SFX.play()
			global.enigme1_Wall5 = true
			tweenWall.tween_property(WallOff2,"modulate:a", 0,0.6)
			WallOff2.process_mode = Node.PROCESS_MODE_DISABLED
			KeyOk = true
			mecanism_SFX.play()
			if global.enigme1_fini == false:
				PopUpText.text = "Le mari, qui voit de sa fenêtre le spectacle, en meurt de douleur, et cette mort donne à Gérard la joie d'épouser sa maîtresse."

		elif CollisionWall == Wall6 :
			poc_SFX.play()
			global.enigme1_fini = true
			tweenWall.tween_property(WallOff2,"modulate:a", 1,0.6)
			PopUpText.text = "C'est bon!"
			AudioManager.play_music(silence_music)
			success_SFX.play()
			await get_tree().create_timer(3).timeout
			AudioManager.play_music(house_music)
			end_puzzle.emit(dialogue_to_play)

		else:
			tweenMove.kill()
			tweenBounce.kill()
			var tweenBall = get_tree().create_tween() 
			error_SFX.play()
			PopUpText.text = "Le mécanisme est bloqué. J'ai dû faire une erreur dans la combinaison. Aurais-je oublié l'histoire du Fabliau?"
			tweenBall.tween_property(Ball,"modulate:a", 0,0.3)
			Ball.global_position = initialPos
			Wall1.process_mode = Node.PROCESS_MODE_ALWAYS
			WallOff1.process_mode = Node.PROCESS_MODE_ALWAYS
			WallOff2.process_mode = Node.PROCESS_MODE_ALWAYS
			WallOff4.process_mode = Node.PROCESS_MODE_ALWAYS
			tweenWall.tween_property(Wall1,"modulate:a", 1,0.2)
			tweenWall.tween_property(WallOff1,"modulate:a", 1,0.2)
			tweenWall.tween_property(WallOff2,"modulate:a", 0,0.2)
			tweenWall.tween_property(WallOff3,"modulate:a", 0,0.2)
			tweenWall.tween_property(WallOff4,"modulate:a", 1,0.2)
			tweenBall.tween_property(Ball,"modulate:a", 1,0.3)
			KeyOk = true

#Gestion des boutons
func _on_button_return_pressed() -> void:
	arrows_SFX.play()
	quit_puzzle.emit()

func _on_button_fabliau_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Passé/Fabliau_passé.tscn")

# mouvement de la balle
func _on_button_up_pressed() -> void:
	if KeyOk:
		arrows_SFX.play()
		Collision = RayUp.get_collision_point() + Vector2 (0,30)
		CollisionWall = RayUp.get_collider()
		Move = true
		Bounce = Collision + Vector2 (0,30)

func _on_button_right_pressed() -> void:
	if KeyOk:
		arrows_SFX.play()
		Collision = RayRight.get_collision_point() - Vector2 (30,0)
		CollisionWall = RayRight.get_collider()
		Move = true
		Bounce = Collision - Vector2 (30,0)

func _on_button_left_pressed() -> void:
	if KeyOk:
		arrows_SFX.play()
		Collision = RayLeft.get_collision_point() + Vector2 (30,0)
		CollisionWall = RayLeft.get_collider()
		Move = true
		Bounce = Collision + Vector2 (30,0)

func _on_button_down_pressed() -> void:
	if KeyOk:
		arrows_SFX.play()
		Collision = RayDown.get_collision_point() - Vector2 (0,30)
		CollisionWall = RayDown.get_collider()
		Move = true
		Bounce = Collision + Vector2 (0,-30)

#Juice sur les boutons
func _on_button_return_mouse_entered() -> void:
	if KeyOk:
		ButtonReturn.scale = Vector2(1.05,1.05)

func _on_button_return_mouse_exited() -> void:
	if KeyOk:
		ButtonReturn.scale = Vector2(1,1)

#func _on_button_fabliau_mouse_entered() -> void:
	#if KeyOk:
		#ButtonFabliau.scale = Vector2(1.05,1.05)
#
#func _on_button_fabliau_mouse_exited() -> void:
	#if KeyOk:
		#ButtonFabliau.scale = Vector2(1,1)
#
#func _on_button_up_mouse_entered() -> void:
	#if KeyOk:
		#Up.scale = Vector2(1.05,1.05)
#
#func _on_button_up_mouse_exited() -> void:
	#if KeyOk:
		#Up.scale = Vector2(1,1)
#
#func _on_button_right_mouse_entered() -> void:
	#if KeyOk:
		#Right.scale = Vector2(1.05,1.05)
#
#func _on_button_right_mouse_exited() -> void:
	#if KeyOk:
		#Right.scale = Vector2(1,1)
#
#func _on_button_left_mouse_entered() -> void:
	#if KeyOk:
		#Left.scale = Vector2(1.05,1.05)
#
#func _on_button_left_mouse_exited() -> void:
	#if KeyOk:
		#Left.scale = Vector2(1,1)
#
#func _on_button_down_mouse_entered() -> void:
	#if KeyOk:
		#Down.scale = Vector2(1.05,1.05)
#
#func _on_button_down_mouse_exited() -> void:
	#if KeyOk:
		#Down.scale = Vector2(1,1)
