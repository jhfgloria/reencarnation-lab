extends KinematicBody2D

export(bool) var is_spinning = true
export(float) var rotation_speed = 60.0
export(int) var direction = 1

func _physics_process(delta):
	if is_spinning: set_rotation_degrees(get_rotation_degrees() + delta * rotation_speed * direction)

func trigger(): is_spinning = !is_spinning
