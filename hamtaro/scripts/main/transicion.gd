extends CanvasLayer

class_name Transicion

signal transicion_completa

@export var transicion_time: float = 1.0

# Ajusta la ruta según la estructura de tu escena
@onready var color_react: ColorRect = $ColorRect

var siguiente_scene_path: String
var is_transicion: bool = false
var jugador_spam_posicion: Vector2 = Vector2(0, 0)

func _ready() -> void:
	print("Nodos hijos del CanvasLayer: ", get_children())
	print("Transicion singleton cargado")
	if color_react:
		print("ColorRect encontrado en la escena")
		color_react.modulate.a = 0
	else:
		print("Error: No se encontró el nodo ColorRect en la escena.")

func fade_out():
	if color_react:
		is_transicion = true
		color_react.modulate.a = 0
		color_react.visible = true

		var tween = get_tree().create_tween()
		tween.tween_property(color_react, "modulate:a", 1, transicion_time)
		tween.finished.connect(on_fade_out_completed)
	else:
		print("Error: No se encontró el nodo ColorRect en fade_out().")

func on_fade_out_completed():
	if siguiente_scene_path:
		print("Cambiando de escena a: ", siguiente_scene_path)
		get_tree().change_scene_to_file(siguiente_scene_path)
		fade_in()
	else:
		print("Error: La ruta de la escena no está definida en on_fade_out_completed().")

func fade_in():
	if color_react:
		color_react.modulate.a = 1
		var tween = get_tree().create_tween()
		tween.tween_property(color_react, "modulate:a", 0, transicion_time)
		tween.finished.connect(on_fade_in_finished)
	else:
		print("Error: No se encontró el nodo ColorRect en fade_in().")

func on_fade_in_finished():
	print("Fade in completo")
	is_transicion = false
	transicion_completa.emit()

func change_scene(siguiente_scene_path: String):
	if is_transicion:
		return
	self.siguiente_scene_path = siguiente_scene_path
	fade_out()
