class_name Puzzle extends Node2D

signal end_puzzle(place : String)

@export var dialogue_to_play : Array[DialogueLine]

func win_puzzle() -> void:
	global.enigme1_fini = true
	end_puzzle.emit(dialogue_to_play)
