extends CharacterBody2D

const SPEED = 8120

@export var ATTACK_RADIUS = 12
@export var ATTACK_LENGHT = 16

const DAMAGE = 5 # DMG per frame

@export var ATTACK_RADIUS2 = 40
@export var ATTACK_LENGHT2 = 0

const DAMAGE2 = 15

const DASH_SPEED = SPEED * 10

@onready var attCol = $ATT/AttackCollider
@onready var attTimer = $ATT/AttcTimer
@onready var spTimer = $ATT/Timer
@onready var dashTimer = $Timer

func _physics_process(delta):
	var dir = Input.get_vector("Right", "Left", "Up", "Down")
	if dir:
		if dir.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif dir.x > 0:
			$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play('walk')
	else:
		$AnimatedSprite2D.play('idle')
	var dash_dir = (get_global_mouse_position() - position).normalized()
	
	if dashTimer.is_stopped(): 
		velocity = dir * SPEED * delta
	else: 
		velocity = dash_dir * DASH_SPEED * delta
	
	if Input.is_action_just_pressed("Atack"):
		attCol.visible = true
		attCol.position = dash_dir * ATTACK_LENGHT
		attCol.shape.radius = ATTACK_RADIUS
		attTimer.start()
	
	if Input.is_action_just_pressed("Special"):
		attCol.visible = true
		attCol.position = dash_dir * ATTACK_LENGHT2
		attCol.shape.radius = ATTACK_RADIUS2
		spTimer.start()
	
	if Input.is_action_just_pressed("Dash"): dashTimer.start()
	
	if attTimer.is_stopped() and spTimer.is_stopped():attCol.visible = false
	
	move_and_slide()
