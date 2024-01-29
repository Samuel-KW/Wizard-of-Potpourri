extends Area2D


func _on_body_entered(body):
	body.velocity += Vector2(1000 * get_parent().direction, 100)
