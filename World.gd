extends Node2D

onready var world = get_node("/root/World")
onready var credits_scene = load("res://GameCredits.tscn")

func trigger():
	world.call_deferred("free")
	var credits = credits_scene.instance()
	get_tree().get_root().add_child(credits)
