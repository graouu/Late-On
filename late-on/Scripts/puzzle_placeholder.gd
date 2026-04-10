class_name Puzzle extends Node2D

signal end_puzzle(place : String)

@export var place_to_load : String

func _on_button_pressed() -> void:
	end_puzzle.emit(place_to_load)
