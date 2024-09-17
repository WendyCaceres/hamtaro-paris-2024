extends RigidBody2D


func _ready():
	$Area2D.connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):  # Si el personaje tiene el grupo 'player'
		body.aumentar_velocidad() 


func _process(delta):
	pass
