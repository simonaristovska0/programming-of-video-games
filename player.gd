extends CharacterBody3D

@onready var camera_pivot = $CameraPivot
@onready var game_over = get_tree().get_root().find_child("game-over", true, false)
@onready var win_ui = get_tree().get_root().find_child("you-won", true, false)
@onready var score_label = get_tree().get_root().find_child("ScoreLabel", true, false)
@onready var timer_label = get_tree().get_root().find_child("TimerLabel", true, false)
@onready var game_timer = get_tree().get_root().find_child("GameTimer", true, false)  

@export var speed : float = 5.0
@export var jump_force : float = 5.0
@export var gravity : float = 9.8
@export var rotation_speed : float = 100.0
@export var fall_limit : float = -5.0

var score = 0
var total_treasures = 0
var collected_treasures = 0

func _ready():
	# Ensure GameTimer is using the correct time
	if game_timer:
		game_timer.stop()  # Stop any existing timer
		game_timer.wait_time = 60  # Ensure it uses the correct time
		game_timer.start()
		print("Game Timer Set to:", game_timer.wait_time)  # Debugging

		if not game_timer.is_connected("timeout", _on_time_up):
			game_timer.connect("timeout", _on_time_up)

	# Hide UI elements initially
	game_over.visible = false
	win_ui.visible = false


	# Find all treasures
	var treasures = get_tree().get_nodes_in_group("Treasures")
	total_treasures = treasures.size()

	# Connect treasure collision detection
	for treasure in treasures:
		if treasure.has_node("TreasureArea"):
			var area = treasure.get_node("TreasureArea")
			if area.has_signal("body_entered") and not area.is_connected("body_entered", _on_treasure_collected):
				area.connect("body_entered", _on_treasure_collected.bind(treasure))

func _on_treasure_collected(body, treasure):
	if body == self:
		treasure.queue_free()
		await get_tree().create_timer(0.1).timeout
		score += 1
		collected_treasures += 1
		score_label.text = "Score: " + str(score)

		# If all treasures are collected, win the game
		if collected_treasures == total_treasures:
			win_game()

func _on_time_up():
	# If time runs out before collecting all treasures, game over
	if collected_treasures < total_treasures:
		game_over_func()
	else:
		win_game()

func win_game():
	win_ui.visible = true
	#restart_button.visible = true  
	timer_label.visible = false  # Hide the timer label when the game is won
	if game_timer:
		game_timer.stop()  # Stop the timer when the game is won
	get_tree().paused = true  # Pause the game


func _physics_process(delta):
	# Update timer label
	if game_timer and timer_label:
		timer_label.text = "Time left: " + str(int(game_timer.time_left))

	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle movement
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		input_dir += transform.basis.z
	if Input.is_action_pressed("move_backward"):
		input_dir -= transform.basis.z

	# Handle rotation
	if Input.is_action_pressed("move_left"):
		rotation_degrees.y += rotation_speed * delta
	if Input.is_action_pressed("move_right"):
		rotation_degrees.y -= rotation_speed * delta

	# Apply movement
	input_dir = input_dir.normalized()
	velocity.x = input_dir.x * speed
	velocity.z = input_dir.z * speed

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()

	# Check if player fell off
	if global_transform.origin.y < fall_limit:
		game_over_func()

func game_over_func():
	game_over.visible = true
	#restart_button.visible = true  
	get_tree().paused = true

#func _on_restart_pressed():
	#print("Restart Button Clicked!")  # Debugging
	#get_tree().paused = false  # Unpause before reloading
	#get_tree().reload_current_scene()  # Reload the scene
	
func _on_button_pressed() -> void:
		print("Restart Button Clicked!")  # Debugging output
		get_tree().paused = false  # Ensure the game is unpaused
		get_tree().reload_current_scene()  # Reload the scene

	
