extends CharacterBody2D

var health = 100.0
var mana = 100.0

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
			
# Player inputs.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			cast_default()

# Spell types.
func cast_default():
	if mana < 10:
		return
	mana -= 10
	%ManaBar.value = mana

# Mana recharge.
func _on_mp_recharge_timeout() -> void:
	mana += 1
	%ManaBar.value = mana
