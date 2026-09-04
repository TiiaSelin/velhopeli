extends CharacterBody2D

var health = 100.0

func _ready() -> void:
	%HealthBar.value = health

func _physics_process(delta: float) -> void:
	if health <= 0.0:
		print_debug("Game over.")
