extends Node2D

func _ready():
	if get_node_or_null("/root/Level"):
		new_game()

func new_game():
	$Ferret.start($StartPosition.position)
	$Camera.start()
