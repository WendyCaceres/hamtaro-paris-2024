extends Sprite2D

var velocity = 400

func _physics_process(delta):
	position.x += delta * velocity
