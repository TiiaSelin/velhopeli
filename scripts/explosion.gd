extends Area2D

var spell_data: SpellData

func _ready() -> void:
	var radius = spell_data.effect.base_radius + \
		spell_data.effect.radius_per_power * (spell_data.effect_power - 1)

	$BlastRadius.shape.radius = radius
	
	await get_tree().physics_frame
	
	var bodies = get_overlapping_bodies()

	for body in bodies:
		if body.has_method("take_damage"):
			SpellCalculator.apply_element(spell_data, body)

	queue_free()
