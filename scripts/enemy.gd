extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")

var health = 3
var normal_speed: float = 300.0
var current_speed: float = 300.0

#Vihollisen liike
func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * current_speed
	move_and_slide()

# Damage and death. 
func take_damage(damage):
	health -= damage
	%HealthBar.value = health
	
	if health <= 0:
		call_deferred("spawn_currency_pickup")
		call_deferred("queue_free")

# Spawn currency upon death.
func spawn_currency_pickup():
	var currency_pickup = preload("res://scenes/currency_pickup.tscn").instantiate()
	currency_pickup.position = position
	get_parent().add_child(currency_pickup)

func apply_ice(amount, duration) -> void:
	current_speed = normal_speed * (1.0 - amount)
	$IceTimer.start(duration)

func _on_ice_timer_timeout() -> void:
	current_speed = normal_speed
