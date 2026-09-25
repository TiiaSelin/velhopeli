class_name ItemData
extends Resource

enum EffectType {
	HEALTH,
	MANA
}

@export var item_name: String
@export var effect_type: EffectType
@export var effect_amount: int
@export var icon: Texture2D
@export var buy_price: int = 5
@export var sell_price: int = 2
