extends Node2D

export(bool) var is_open = false

onready var player: KinematicBody2D = get_node("/root/World/Player")
onready var spawn_position: Node2D = get_node("/root/World/SpawnPosition")
onready var camera: Node2D = get_node("/root/World/Camera2D")
onready var sprite: AnimatedSprite = get_node("Sprite")
onready var open_sound: AudioStreamPlayer2D = get_node("OpenSound")

func _ready():
	if is_open: sprite.play("default")
	else: sprite.play("closed")
	player.connect("respawn", self, "_respawn")	

func _on_Area2D_area_entered(area):
	if is_open: return

	sprite.play("open")
	open_sound.play()
	spawn_position.set_position(global_position)
	is_open = true

func _respawn(): camera.set_position(get_parent().position)
