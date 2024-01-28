extends Node2D

func _ready():
	print(self.get_path())
	if get_node("/root/Level"):
		print("yuh")
		new_game()


func new_game():
	$Ferret.start($StartPosition.position)
	$Camera.start()
