class_name SpellData
extends Resource

@export var element: ElementData
@export var element_power: int = 1
@export var form: FormData
@export var form_power: int = 1
@export var effect: EffectData
@export var effect_power: int = 1

func setup(new_element: ElementData, new_form: FormData, new_effect: EffectData) -> void:
	element = new_element
	form = new_form
	effect = new_effect
