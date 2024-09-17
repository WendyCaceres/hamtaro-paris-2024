extends CharacterBody2D

@onready var boss_sprite = $boss_sprite
@onready var warm_timer = $Warm_Timer
@onready var jumptimer = $jumptimer

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.9  # Aumentar la gravedad
var velocidad = 160
var JUMP_SPEED = -500  # Menos negativo para saltos más bajos
var VELOCIDAD_INCREMENTO = 50  # La cantidad que aumentará la velocidad

var start = false

func _ready():
	warm_timer.start()
	boss_sprite.play("warm")
	await (warm_timer.timeout)
	boss_sprite.play("ready")

func _physics_process(delta):
	# Aplicar gravedad en el eje Y
	velocity.y += GRAVITY * delta

	# Comenzar el movimiento cuando se presione la tecla "iniciar"
	if Input.is_action_pressed("iniciar"):
		start = true
		boss_sprite.play("run")

	# Realizar el salto si el personaje está en el suelo y la tecla de salto está presionada
	if Input.is_action_just_pressed("saltar") and start and is_on_floor():
		velocity.y = JUMP_SPEED
		jumptimer.start()
		boss_sprite.play("jump")
		await (jumptimer.timeout)
		boss_sprite.play("run")

	# Movimiento horizontal cuando el juego empieza
	if start:
		velocity.x = velocidad

	# Aplicar el movimiento usando move_and_slide, afectando tanto el eje X como el Y
	move_and_slide()


# Función para aumentar la velocidad al pasar un obstáculo
func aumentar_velocidad():
	velocidad += VELOCIDAD_INCREMENTO
	print("Velocidad actual:", velocidad)
