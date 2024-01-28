extends Area2D

@export var direction = Vector2(2000, 0)

func _ready():
	direction = direction.rotated(rotation)

func _on_body_entered(body):
	body.velocity += direction
