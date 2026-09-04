extends CharacterBody2D

var health = 100.0

# Pelaajahahmon liike
func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#Hahmon nopeus
	velocity = direction * 650
	move_and_slide()

	# Player damage and game over.
	const DAMAGE_RATE = 50.0
	var overlapping_enemies = %HurtBox.get_overlapping_bodies()
	
	if overlapping_enemies.size() > 0:
		health -= DAMAGE_RATE * overlapping_enemies.size() * _delta
		%HealthBar.value = health
		if health <= 0.0:
			print("Game over.")
			get_tree().paused = true
