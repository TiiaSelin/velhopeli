extends Control

func _ready() -> void:
	update_current_spell_text()
	list_elements()
	list_effects()

func update_current_spell_text():
	%CurrentSpellText.text = "Current spell: %s, %s, %s." % [
		GameState.selected_spell["element"], 
		GameState.selected_spell["form"], 
		GameState.selected_spell["effect"]
	]

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_clear_menu.tscn")

func list_elements() -> void:
	var displayed_elements = []

	for element in GameState.elements:
		if element in displayed_elements:
			continue

		displayed_elements.append(element)

		var button = Button.new()
		button.text = element
		button.pressed.connect(_on_element_selected.bind(element))
		%ElementButtons.add_child(button)

func list_effects() -> void:
	var displayed_effects = []

	for effect in GameState.effects:
		if effect in displayed_effects:
			continue

		displayed_effects.append(effect)

		var button = Button.new()
		button.text = effect
		button.pressed.connect(_on_effect_selected.bind(effect))
		%EffectButtons.add_child(button)

func _on_element_selected(element) -> void:
	GameState.selected_spell["element"] = element
	update_current_spell_text()

func _on_effect_selected(effect) -> void:
	GameState.selected_spell["effect"] = effect
	update_current_spell_text()
