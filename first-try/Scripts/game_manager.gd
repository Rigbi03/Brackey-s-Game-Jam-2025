extends Node

var pcHasBeenUsed = false

#@onready var electric_box: Node3D = $"../ElectricBox"
#var electricityIsOn = electric_box.isActive

func _process(delta: float) -> void:
	#if(electricityIsOn):
		pass
		#check if pcHasBeenUsed
		#Access Openable door and open it
