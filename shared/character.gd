extends CharacterBody2D

var input_direction: Vector2 = Vector2.ZERO
@export var sync_score: int = 0

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	position = ServerData.SPAWN_POINTS[1]
	$Label.text = name
	$scorelabel.text = "score: " + str(sync_score)

func _input(event):
	if !is_multiplayer_authority(): return
	if event.is_action_pressed("fire"):
		rpc("_shoot")

func _process(_delta):
	if !is_multiplayer_authority(): return
	$Camera2D.make_current()
	input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	#look_at(get_global_mouse_position())
	#"""
	if input_direction.x > 0:
		$UserSprite.rotation_degrees = 90
	elif input_direction.x < 0:
		$UserSprite.rotation_degrees = 270
	elif input_direction.y > 0:
		$UserSprite.rotation_degrees = 180
	elif input_direction.y < 0:
		$UserSprite.rotation_degrees = 0
	#"""

func _physics_process(_delta):
	velocity = input_direction * 200
	move_and_slide()

@rpc("any_peer", "call_local")
func _shoot():
	var projectile = preload("res://shared/projectile.tscn").instantiate()
	projectile.shooter = name
	if $UserSprite.rotation_degrees == 0:
		projectile.projectile_direction = Vector2(0,-1)
	elif $UserSprite.rotation_degrees == 90:
		projectile.projectile_direction = Vector2(1,0)
	elif $UserSprite.rotation_degrees == 180:
		projectile.projectile_direction = Vector2(0,1)
	elif $UserSprite.rotation_degrees == 270:
		projectile.projectile_direction = Vector2(-1,0)
	projectile.position = Vector2(position.normalized().x, position.normalized().y)
	projectile.position += (projectile.projectile_direction * 32)
	call_deferred("add_child", projectile, true)
	
func _increment_score():
	sync_score+=1
	$scorelabel.text = "score: " + str(sync_score)
