# GameState.gd (singleton)
extends Node2D

#Actualizar score en el UI
@onready var score_board = $Score_Board

var archery_points: Array = []

func set_archery_points(point: int):
	archery_points.append(point)

func get_archery_points():
	return archery_points
