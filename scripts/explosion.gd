extends Area2D

@export var damage: float = 1.0

func _ready() -> void:
	await get_tree().physics_frame
	
	var bodies = get_overlapping_bodies()

	for body in bodies:
		if body.has_method("take_damage"):
			body.take_damage(damage)

	queue_free()
