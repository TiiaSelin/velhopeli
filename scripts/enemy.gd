extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")

var health = 3

#Vihollisen liike
func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * 300.0
	move_and_slide()

# Damage and death. 
func take_damage():
	health -= 1
	%HealthBar.value = health
	
	if health <= 0:
		queue_free()
