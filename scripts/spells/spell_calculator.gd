class_name SpellCalculator
extends RefCounted

static func calculate_damage(spell: SpellData) -> float:
	var base_damage = 1.0
	var element_damage = spell.element.damage_bonus * spell.element_power

	return base_damage + element_damage

static func apply_element(spell, target) -> void:
	var damage = calculate_damage(spell)

	if damage > 0:
		target.take_damage(damage)

	if spell.element.element_name == "Ice":
		var slow_amount = spell.element.slow_amount + \
			spell.element.slow_amount_per_power * (spell.element_power - 1)

		var slow_duration = spell.element.slow_duration + \
			spell.element.slow_duration_per_power * (spell.element_power - 1)

		target.apply_ice(slow_amount,slow_duration)

static func calculate_mana() -> float:
	return 20.0
