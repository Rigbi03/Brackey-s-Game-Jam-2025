extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var run_multiplier = 0

var isRunning = false
var InteractedWithPc = false

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("Move_Left", "Move_Right")
	input.z = Input.get_axis("Move_Forward", "Move_Backward")
		
	if(Input.is_action_pressed("Run")):
		isRunning = true
		run_multiplier = 1.5
	else:
		isRunning = false
		run_multiplier = 1
	
	apply_central_force(twist_pivot.basis * input * run_multiplier * 1200.0 * delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		deg_to_rad(-60),
		deg_to_rad(60)
	)
	twist_input = 0.0
	pitch_input = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
			

func _on_body_entered(body: Node3D) -> void:
	print(body.name)
	print("You died!")
	if body.name == "Dog":
		get_tree().reload_current_scene()
	#InteractedWithPc = true
	#$Game/PcDoor.open 
