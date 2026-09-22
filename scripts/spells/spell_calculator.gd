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
		target.apply_ice(
			spell.element.slow_amount,
			spell.element.slow_duration
		)

static func calculate_mana() -> float:
	return 20.0
