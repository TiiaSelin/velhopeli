class_name SpellCalculator
extends RefCounted

static func calculate_damage(spell: SpellData) -> float:
	var base_damage = 1.0
	var element_damage = spell.element.damage_bonus

	return base_damage + element_damage

static func calculate_mana() -> float:
	return 20.0
