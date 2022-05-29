extends Control

var game_scene = load("res://World.tscn")
onready var menu = get_node("/root/GameMenu")
onready var controls_list = get_node("CanvasLayer/NinePatchRect/Menu/ControlsList")
onready var main_menu = get_node("CanvasLayer/NinePatchRect/Menu/MainMenu")

func _on_Button_button_down():
	_leave_controls()
	
func _on_ControlsButton_button_down():
	_show_controls()
	
func _on_Play_button_down():
	_start_game()
	
func _leave_controls():
	controls_list.visible = false
	main_menu.visible = true
	
func _show_controls():
	print("show")
	controls_list.visible = true
	main_menu.visible = false

func _start_game():
	menu.call_deferred("free")
	var world = game_scene.instance()
	get_tree().get_root().add_child(world)
