extends CharacterBody2D

var health = 25

func _on_area_2d_area_entered(area):
	if area.visible:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("get_damage")
		health -= 5

func _physics_process(delta):
	if health > 1: 
		# Вставь код перемещения на конец
		pass
