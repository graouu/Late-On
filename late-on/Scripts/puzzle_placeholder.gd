class_name Puzzle extends Node2D

signal quit_puzzle

func quit():
	quit_puzzle.emit()
