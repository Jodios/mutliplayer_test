extends Node2D

@export var projectile_direction:Vector2 = Vector2.ZERO
@export var speed = 20
var shooter: String

func _ready():
	if shooter == null || shooter == "": queue_free()
	$Area2D.body_entered.connect(_on_collision)
	get_tree().create_timer(2).timeout.connect(_auto_remove)
	
func _physics_process(_delta):
	position += projectile_direction * speed

func _on_collision(body: Node2D):
	#print(body," ", body.name, " : ", shooter, " (",name,")")
	if body.name == shooter: return
	if body is CharacterBody2D:
		get_parent()._increment_score()
	queue_free()

func _auto_remove():
	queue_free()
