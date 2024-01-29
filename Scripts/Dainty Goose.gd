extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if position.x > 1200:
		direction = -1
		$AnimatedSprite2D.flip_h = false
	elif position.x < 200:
		direction = 1
		$AnimatedSprite2D.flip_h = true
	position.x += direction * delta * SPEED
