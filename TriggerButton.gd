extends Node2D

onready var sprite: Sprite = get_node("Sprite")
onready var collision: CollisionShape2D = get_node("CollisionShape2D")

export(NodePath) var triggered_object
export(Texture) var sprite_path

func _ready():
	if sprite_path == null: collision.disabled = true
	sprite.texture = sprite_path
	triggered_object = get_node(triggered_object)

func _on_Area2D_area_entered(area):
	triggered_object.trigger()
