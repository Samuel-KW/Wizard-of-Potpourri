extends RigidBody2D


var direction = 1

const SPEED = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if position.x > 800:
		direction = -1
		$AnimatedSprite2D.flip_h = false
	elif position.x < 500:
		direction = 1
		$AnimatedSprite2D.flip_h = true
	position.x += direction * delta * SPEED

