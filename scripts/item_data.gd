class_name ItemData
extends Resource

enum EffectType {
	HEALTH,
	MANA
}

@export var item_name: String
@export var effect_type: EffectType
@export var effect_amount: int
