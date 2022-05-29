extends StaticBody2D

export(bool) var hidden = false

onready var collision: CollisionShape2D = get_node("CollisionShape2D")
onready var move_door_sound: AudioStreamPlayer2D = get_node("MoveDoorSound")

func _ready():
	if hidden:
		visible = false
		collision.disabled = true

func open():
	collision.set_deferred("disabled", true)
	set_visible(false)

func trigger():
	move_door_sound.play()
	collision.set_deferred("disabled", !collision.is_disabled())
	visible = !visible
