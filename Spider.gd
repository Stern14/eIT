extends CharacterBody2D

const speed = 5120
var chase = false
@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D


func _physics_process(_delta: float) -> void:
	if chase:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed * _delta
		move_and_slide()

func _on_detecter_body_entered(body):
	if body.name == 'Player':
		chase = true
		

func _on_detecter_body_exited(body):
	if body.name == 'Player':
		chase = false
	
func makepath() -> void:
	nav_agent.target_position = player.global_position
	
	
func _on_make_path_timeout():
	makepath()
