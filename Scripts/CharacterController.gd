extends CharacterBody2D

var screen_size # Size of the game window.
var RADIUS = 30

const MAX_SPEED = 200
const SPEED = 10

const MAX_LENGTH = 2000
const PAPER_SPACING = 5

var is_rolling = false

var paper_length = 0

var TRAIL_ELEMENT;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func start(pos):
	position = pos
	RADIUS = $CollisionShape2D.shape.radius
	TRAIL_ELEMENT.position = position
	show()

# Called when the node enters the scene tree for the first time.
func _ready():
	var root_node = get_parent()
	TRAIL_ELEMENT = root_node.get_node("ToiletPaperTrail")
	
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

	if velocity.x > 0.1:
		roll_paper(delta)
	elif velocity.x < -0.1:
		wind_paper(delta)

	move_and_slide()
	
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.collision_layer == 2:
			$CollectTP.play()
			collider.queue_free()

	self.rotation += (velocity.x * delta) / RADIUS
	
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
	var pts = TRAIL_ELEMENT.get_points()
	var dist = position.distance_to(pts[pts.size() - 1])
	if is_rolling and dist > 5:
		TRAIL_ELEMENT.add_point(TRAIL_ELEMENT.position - position)
		#paper_length += dist
	

