extends CharacterBody2D


var input_direction: Vector2 = Vector2.ZERO

func _ready():
	print(name)

func _process(_delta):
	input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

func _physics_process(_delta):
	if not is_multiplayer_authority(): return
	velocity = input_direction * 200
	move_and_slide()
