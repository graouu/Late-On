class_name Puzzle extends Node2D

signal quit_puzzle
signal end_puzzle

func quit():
	quit_puzzle.emit()
	end_puzzle.emit()


func _on_return_pressed() -> void:
	quit()
