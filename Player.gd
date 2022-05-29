extends KinematicBody2D

signal respawn
signal death(times)

onready var sprite = get_node("AnimatedSprite")
onready var respawn_position: Node2D = get_node("/root/World/SpawnPosition")
onready var camera: Node2D = get_node("/root/World/Camera2D")
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var jump_sound: AudioStreamPlayer2D = get_node("Sounds/JumpSound")
onready var landing_sound: AudioStreamPlayer2D = get_node("Sounds/LandingSound")
onready var spawn_sound: AudioStreamPlayer2D = get_node("Sounds/SpawnSound")
onready var step_sound: AudioStreamPlayer2D = get_node("Sounds/StepSound")

export(float) var gravity = 1500.0
export(float) var walk_speed = 200.0
export(float) var jump_speed = 600.0
export(float) var climb_speed = 200.0

var velocity = Vector2.ZERO
var is_jumping = false
var camera_reposition = Vector2.ZERO
var is_dying = false
var is_walking = false
var death_times = 0

func _ready(): spawn_sound.play()

func _process(delta):
	if is_walking and !step_sound.is_playing(): 
		step_sound.play()
	elif !is_walking or !is_on_floor() or is_dying:
		step_sound.stop()
	else: pass

func _physics_process(delta):
	if is_on_ceiling():
		velocity.y = 0

	if is_on_floor():
		if is_jumping == true: landing_sound.play()

		velocity.y = 0
		is_jumping = false

	if is_dying == false:
		if Input.is_action_pressed("ui_left"):
			velocity.x = -walk_speed
			sprite.flip_h = false
			sprite.play("walk")
			is_walking = true
		elif Input.is_action_pressed("ui_right"):
			velocity.x = walk_speed
			sprite.flip_h = true
			sprite.play("walk")
			is_walking = true
		else:
			velocity.x = 0
			sprite.play("default")
			is_walking = false

		if Input.is_action_just_pressed("ui_up") and !is_jumping:
			is_jumping = true
			velocity.y = -jump_speed
			jump_sound.play()

	else:
		velocity.x = 0
		sprite.play("default")

	velocity.y += gravity * delta

	move_and_slide(velocity, Vector2.UP)


func _on_HazardDetection_area_entered(area):
	is_dying = true
	animation_player.play("death")

func _on_VasselDetector_area_entered(area):
	camera_reposition = area.get_parent().get_parent().position
	
func _death():
	death_times += 1
	get_tree().call_group("automatic_doors", "open")
	emit_signal("death", death_times)
	_respawn()

func _respawn():
	animation_player.play("Idle")
	spawn_sound.play()
	position = respawn_position.position
	camera.position = camera_reposition
	is_dying = false
