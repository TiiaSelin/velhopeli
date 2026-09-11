class_name SpellData
extends Resource

@export var element: ElementData
@export var form: FormData
@export var effect: EffectData

func setup(new_element: ElementData, new_form: FormData, new_effect: EffectData) -> void:
	element = new_element
	form = new_form
	effect = new_effect
