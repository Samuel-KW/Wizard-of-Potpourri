extends Camera2D

var Ferret;

# Called when the node enters the scene tree for the first time.
func _ready():
	var root_node = get_parent()
	Ferret = root_node.get_node("Ferret")
	self.position = root_node.get_node("StartPosition").position


func _process(delta):
	self.position = self.position.lerp(Ferret.position, 3 * delta)
