extends Node3D

@export var player: Node3D  # Поврзи го со `Player` во Inspector!
@export var rotation_speed: float = 3.0  # Брзина на вртење
@export var mouse_sensitivity: float = 0.2  # Чувствителност на глувчето

var rotation_x = 0
var rotation_y = 0

func _input(event):
	# Контрола со стрелки
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_LEFT:
				rotation_y += rotation_speed
			elif event.keycode == KEY_RIGHT:
				rotation_y -= rotation_speed
			elif event.keycode == KEY_UP:
				rotation_x = max(rotation_x - rotation_speed, -30)  # Ограничување нагоре
			elif event.keycode == KEY_DOWN:
				rotation_x = min(rotation_x + rotation_speed, 30)  # Ограничување надолу

	# Контрола со глувче
	if event is InputEventMouseMotion and Input.is_action_pressed("ui_focus_next"):
		rotation_y -= event.relative.x * mouse_sensitivity
		rotation_x = clamp(rotation_x - event.relative.y * mouse_sensitivity, -30, 30)  # Ограничување на X ротација

func _process(delta):
	# Ротираме според input
	rotation_degrees.y = rotation_y
	rotation_degrees.x = rotation_x

	# Следи ја позицијата на играчот
	if player:
		global_transform.origin = player.global_transform.origin
