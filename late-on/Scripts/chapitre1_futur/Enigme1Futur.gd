extends Node2D

@export var scene_music: AudioStream
@export var house_music: AudioStream
@export var silence_music: AudioStream
@export var arrows_SFX: AudioStream
@onready var Up = $Button_Up
@onready var RayUp = $Maze/Ball/RayCastUp
@onready var Right = $Button_Right
@onready var RayRight = $Maze/Ball/RayCastRight
@onready var Left = $Button_Left
@onready var RayLeft = $Maze/Ball/RayCastLeft
@onready var Down = $Button_Down
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
		PopUpText.text = "Commence ta journée de travail en déloquant l'ordinateur :) Tu as sécurisé ton compte avec une page de ton livre préféré. Il faut que tu repères les mots les plus <<impactants >> ;) "
		PopUpText.text += '\n' + "<<Prenons une proposition élémentaire: les entreprises existent pour gagner de l'argent, pas pour en perdre. Ce principe devrait être évident pour tout individu doué de raison.>>"
	else :
		PopUpText.text = "Repartons du premier paragraphe: <<	Prenons une proposition élémentaire: les entreprises existent pour gagner de l'argent, pas pour en perdre. Ce principe devrait être évident pour tout individu doué de raison.>>"

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
			tweenWall.tween_property(Wall1,"modulate:a", 0,0.6)
			Wall1.process_mode = Node.PROCESS_MODE_DISABLED
			tweenWall.tween_property(WallOff1,"modulate:a", 0,0.6)
			WallOff1.process_mode = Node.PROCESS_MODE_DISABLED
			KeyOk = true
			PopUpText.text = "Bravo! tu te souviens de la première étape :) 2ème paragraphe: <<	Mais il ne l'était pas tant que ça à la fin des années 1990, quand les pertes les plus lourdes étaient présentées comme un moyen d'investir dans un avenir plus grand et plus radieux.>>"

		elif CollisionWall == Wall2 :
			tweenWall.tween_property(WallOff2,"modulate:a", 1,0.6)
			KeyOk = true
			PopUpText.text = "Tu t'en sors vraiment bien! continuons avec le 3ème paragraphe: <<	Selon la doxa de la <<Nouvelle Economie>>, le nombre de pages consultées sur Internet était considéré comme un indicateur financier plus fiable et plus prospectif qu'un critère aussi prosaïque que le bénéfice net.>>"

		elif CollisionWall == Wall3 :
			tweenWall.tween_property(WallOff3,"modulate:a", 1,0.6)
			KeyOk = true
			PopUpText.text = "Tu y es presque! 4ème paragraphe: <<	C'est retrosectivement que les croyances communes finissent par sembler arbitraires et fausses; chaque fois que l'une d'elles s'effondre, nous la qualifions de <<bulle>>.>>"

		elif CollisionWall == Wall4 :
			tweenWall.tween_property(WallOff1,"modulate:a", 1,0.6)
			tweenWall.tween_property(WallOff4,"modulate:a", 0,0.6)
			WallOff4.process_mode = Node.PROCESS_MODE_DISABLED
			KeyOk = true
			PopUpText.text = "Tu es arrivé si loin! est-ce que tu trouveras le 5° paragraphe aussi? <<	Mais les distorsions qu'entraînent les bulles ne disparaissent pas dès qu'elles éclatent. La folie Internet des années 1990 était la plus grosse bulle depuis le krach de 1929 et les leçons qu'on a retenues définissent et altèrent presque toute la vision technologique actuelle.>>"

		elif CollisionWall == Wall5 :
			tweenWall.tween_property(WallOff2,"modulate:a", 0,0.6)
			WallOff2.process_mode = Node.PROCESS_MODE_DISABLED
			KeyOk = true
			PopUpText.text = "Wahoo! dernier paragraphe: <<	La première étape vers une pensée claire consiste à remettre en cause ce que nous croyons savoir du passé.>>"

		elif CollisionWall == Wall6 :
			global.enigme1f_fini = true
			tweenWall.tween_property(WallOff2,"modulate:a", 1,0.6)
			PopUpText.text = "C'est la bonne combinaison! Ton compte est ouvert! Félicitations petit employé :)"
			await get_tree().create_timer(3).timeout
			AudioManager.play_music(house_music)
			get_parent().get_parent().current_place.name = "desktop"
			end_puzzle.emit(dialogue_to_play)

		else:
			global.enigme1f_Nbtry += 1
			if global.enigme1f_Nbtry == 1:
				Wall1.modulate = Color(0, 1, 1)
			if global.enigme1f_Nbtry == 2:
				Wall2.modulate = Color(0, 1, 1)
			if global.enigme1f_Nbtry == 3:
				Wall3.modulate = Color(0, 1, 1)
			if global.enigme1f_Nbtry == 4:
				Wall4.modulate = Color(0, 1, 1)
			if global.enigme1f_Nbtry == 5:
				Wall5.modulate = Color(0, 1, 1)
			tweenMove.kill()
			tweenBounce.kill()
			var tweenBall = get_tree().create_tween() 
			PopUpText.text = "Oh non, ce n'est pas le bon mot :( . Mais ne t'en fais pas, tu vas y arriver ^^"
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
	AudioManager.play_music(house_music)
	quit_puzzle.emit()

func _on_button_fabliau_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Futur/Page_Futur.tscn")

# mouvement de la balle
func _on_button_up_pressed() -> void:
	if KeyOk:
		Collision = RayUp.get_collision_point() + Vector2 (0,30)
		CollisionWall = RayUp.get_collider()
		Move = true
		Bounce = Collision + Vector2 (0,30)

func _on_button_right_pressed() -> void:
	if KeyOk:
		Collision = RayRight.get_collision_point() - Vector2 (30,0)
		CollisionWall = RayRight.get_collider()
		Move = true
		Bounce = Collision - Vector2 (30,0)

func _on_button_left_pressed() -> void:
	if KeyOk:
		Collision = RayLeft.get_collision_point() + Vector2 (30,0)
		CollisionWall = RayLeft.get_collider()
		Move = true
		Bounce = Collision + Vector2 (30,0)

func _on_button_down_pressed() -> void:
	if KeyOk:
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

func _on_button_fabliau_mouse_entered() -> void:
	if KeyOk:
		ButtonFabliau.scale = Vector2(1.05,1.05)

func _on_button_fabliau_mouse_exited() -> void:
	if KeyOk:
		ButtonFabliau.scale = Vector2(1,1)

func _on_button_up_mouse_entered() -> void:
	if KeyOk:
		Up.scale = Vector2(1.05,1.05)

func _on_button_up_mouse_exited() -> void:
	if KeyOk:
		Up.scale = Vector2(1,1)

func _on_button_right_mouse_entered() -> void:
	if KeyOk:
		Right.scale = Vector2(1.05,1.05)

func _on_button_right_mouse_exited() -> void:
	if KeyOk:
		Right.scale = Vector2(1,1)

func _on_button_left_mouse_entered() -> void:
	if KeyOk:
		Left.scale = Vector2(1.05,1.05)

func _on_button_left_mouse_exited() -> void:
	if KeyOk:
		Left.scale = Vector2(1,1)

func _on_button_down_mouse_entered() -> void:
	if KeyOk:
		Down.scale = Vector2(1.05,1.05)

func _on_button_down_mouse_exited() -> void:
	if KeyOk:
		Down.scale = Vector2(1,1)
