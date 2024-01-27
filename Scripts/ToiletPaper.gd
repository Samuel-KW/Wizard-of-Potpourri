extends RigidBody2D
signal collectTP

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()

func _on_body_entered(body):
	collectTP.emit()
	$CollisionShape2D.set_deferred("disabled", true) # Disable collision physics
	hide()
