extends Control

var game_menu_scene = load("res://GameMenu.tscn")
onready var credits = get_node("/root/GameCredits")

func _on_Button_button_down():
	_back_to_menu()

func _back_to_menu():
	credits.call_deferred("free")
	var menu = game_menu_scene.instance()
	get_tree().get_root().add_child(menu)
