extends CharacterBody2D

var START_POS;
var screen_size # Size of the game window.
var RADIUS = 30

const MAX_SPEED = 200
const SPEED = 100

const MAX_LENGTH = 2000
const PAPER_SPACING = 5

var is_rolling = false

var paper_length = 0

var TRAIL_ELEMENT;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func start(pos):
	START_POS = pos
	position = pos
	TRAIL_ELEMENT.position = pos
	show()

# Called when the node enters the scene tree for the first time.
func _ready():
	var root_node = get_parent()
	RADIUS = $CollisionShape2D.shape.radius
	TRAIL_ELEMENT = root_node.get_node("ToiletPaperTrail")
	
	screen_size = get_viewport_rect().size
	hide()

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_pressed("move_right"):
		velocity.x = min(velocity.x + SPEED * delta, MAX_SPEED)

	elif Input.is_action_pressed("move_left"):
		velocity.x = max(velocity.x - SPEED * delta, -MAX_SPEED)

	if velocity.x > 0.1:
		roll_paper(delta)
	elif velocity.x < -0.1:
		pass#wind_paper(delta)

	move_and_slide()
	
	# Collect toilet paper
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.collision_layer == 2:
			$CollectTP.play()
			collider.queue_free()
			
			paper_length = 0
			$TP_Sprite.frame = 0
			$CollisionShape2D.shape.radius = RADIUS

	self.rotation += (velocity.x * delta) / $CollisionShape2D.shape.radius
	
func roll_paper(delta):
	is_rolling = true
	paper_length += velocity.x * delta
	
	if paper_length > MAX_LENGTH:
		velocity.x *= -1
		paper_length = MAX_LENGTH
		
	update_paper_visual()
	
	
func wind_paper(delta):
	is_rolling = false
	
	paper_length += velocity.x * delta
	
	if paper_length < 0:
		paper_length = 0;
		
	update_paper_visual()
	
func update_paper_visual():
	var percent = paper_length / MAX_LENGTH
	var frames = 11
	
	var radii = [100, 90, 85, 75, 63, 65, 50, 45, 45, 40, 35, 30]
	
	var frame = int (percent * frames)
	
	$CollisionShape2D.shape.radius = radii[frame]
	$TP_Sprite.frame = frame
	
	if frame == frames:
		self.position = START_POS
		paper_length = 0
		$TP_Sprite.frame = 0
		$CollisionShape2D.shape.radius = RADIUS
		velocity = Vector2(0, 0)
		
	
	

