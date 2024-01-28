extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.flip_h = true
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.flip_h = false
		velocity.x -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	# Update the character position
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func lose_tp():
	pass


func _on_body_entered(body):
	print("Yuh") # Replace with function body.
	$Collect_TP.play()
	$CollisionShape2D.disable = true
	$ToiletPaper.visible = false
	$ToiletPaper.die()
