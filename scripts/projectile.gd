extends Area2D

var spell_data: SpellData
var travel_distance = 0

func _physics_process(delta: float) -> void:
	const SPEED = 1000
	const RANGE = 1200
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta

	travel_distance += SPEED * delta
	if travel_distance > RANGE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if (body.has_method("take_damage")):
		var damage = SpellCalculator.calculate_damage(spell_data)
		body.take_damage(damage)
