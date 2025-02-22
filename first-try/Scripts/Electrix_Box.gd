extends Area3D
	
var isActive = false
@onready var timer: Timer = $Timer

func _on_body_entered(body: RigidBody3D) -> void:
	if body.name == "Player":
		print ("Entered El Box!")
	
	isActive = true
	timer.start()

func _on_timer_timeout() -> void:
	isActive = false
