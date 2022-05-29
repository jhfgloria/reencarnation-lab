extends Control

onready var player = get_node("/root/World/Player")
onready var death_count_label = get_node("CanvasLayer/MarginContainer/DeathCountLabel")

func _ready():
	player.connect("death", self, "_update_death_count")
	
func _update_death_count(times):
	death_count_label.text = "death count: " + String(times)
