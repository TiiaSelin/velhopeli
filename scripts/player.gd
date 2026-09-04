extends CharacterBody2D

var health = 100.0

func _ready() -> void:
	%HealthBar.value = health

# Pelaajahahmon liike
func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#Hahmon nopeus
	velocity = direction * 650
	move_and_slide()

	if health <= 0.0:
		print_debug("Game over.")