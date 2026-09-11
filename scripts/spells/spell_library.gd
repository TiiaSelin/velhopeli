class_name SpellLibrary
extends Resource

@export var elements: Array[ElementData]
@export var forms: Array[FormData]
@export var effects: Array[EffectData]

func get_element(element_name):
	for element in elements:
		if element.element_name == element_name:
			return element
	return null

func get_form(form_name):
	for form in forms:
		if form.form_name == form_name:
			return form
	return null

func get_effect(effect_name):
	for effect in effects:
		if effect.effect_name == effect_name:
			return effect
	return null
