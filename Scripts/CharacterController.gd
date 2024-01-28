extends CharacterBody2D

var screen_size # Size of the game window.
var RADIUS = 30

const MAX_SPEED = 200
const SPEED = 10


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func start(pos):
	position = pos
	RADIUS = $CollisionShape2D.shape.radius
	show()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_pressed("move_right"):
		velocity.x = min(velocity.x + SPEED, MAX_SPEED)

	elif Input.is_action_pressed("move_left"):
		velocity.x = max(velocity.x - SPEED, -MAX_SPEED)

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.collision_layer == 2:
			$CollectTP.play()
			collider.queue_free()

	self.rotation += (velocity.x * delta) / RADIUS
