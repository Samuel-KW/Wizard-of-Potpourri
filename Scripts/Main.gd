extends Node2D

func _ready():
	new_game()

func new_game():
	$Ferret.start($StartPosition.position)
