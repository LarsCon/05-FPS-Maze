extends KinematicBody

onready var Camera = $Pivot/Camera
onready var walk = $walk
onready var iswalking = false

var gravity = -30
var max_speed = 12
var mouse_sensitivity = 0.02
var mouse_range = 1.2

var velocity = Vector3()

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("forward"):
		input_dir += -Camera.global_transform.basis.z
		iswalking = true
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
		iswalking = true
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
		iswalking = true
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
		iswalking = true
	input_dir = input_dir.normalized()
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	if iswalking:
		if not walk.playing:
			walk.play()
	else:
		if walk.playing:
			walk.stop()
		
	if not Input.is_action_pressed("forward") and not Input.is_action_pressed("back") and not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		iswalking = false
