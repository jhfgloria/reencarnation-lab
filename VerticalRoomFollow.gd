extends Node2D

onready var camera: Node2D = get_node("/root/World/Camera2D")
onready var room: Node2D = get_parent()

export(NodePath) var door

func _ready(): door = get_node(door)

func _on_Area2D_area_entered(area):
	camera.set_position(room.position)

	if door != null: _lock_door()

func _lock_door(): door.trigger()
