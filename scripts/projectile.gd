extends Area2D

var spell_data: SpellData
var travel_distance = 0

func _physics_process(delta: float) -> void:
	const SPEED = 1000
	var range = spell_data.form.base_range + \
		spell_data.form.range_per_power * (spell_data.form_power - 1)
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta

	travel_distance += SPEED * delta
	if travel_distance > range:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if (body.has_method("take_damage")):
		SpellCalculator.apply_element(spell_data, body)

		if spell_data.effect.effect_scene:
			call_deferred("create_effect")

func create_effect() -> void:
	var effect = spell_data.effect.effect_scene.instantiate()
	effect.spell_data = spell_data
	effect.global_position = global_position
	get_parent().add_child(effect)
