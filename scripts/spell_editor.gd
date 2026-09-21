extends Control

func _ready() -> void:
	update_current_spell_text()
	list_elements()
	list_effects()

func update_current_spell_text():
	%CurrentSpellText.text = "Current spell: %s x%d, %s x%d, %s x%d." % [
		GameState.selected_spell["element"],
		GameState.selected_spell["element_power"],
		GameState.selected_spell["form"],
		GameState.selected_spell["form_power"],
		GameState.selected_spell["effect"],
		GameState.selected_spell["effect_power"]
	]
	update_power_texts()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_clear_menu.tscn")

func list_elements() -> void:
	for element in GameState.elements:
		var button = Button.new()
		button.text = element
		button.pressed.connect(_on_element_selected.bind(element))
		%ElementButtons.add_child(button)

func list_effects() -> void:
	for effect in GameState.effects:
		var button = Button.new()
		button.text = effect
		button.pressed.connect(_on_effect_selected.bind(effect))
		%EffectButtons.add_child(button)

func _on_element_selected(element) -> void:
	GameState.selected_spell["element"] = element
	GameState.selected_spell["element_power"] = 1
	update_current_spell_text()

func _on_effect_selected(effect) -> void:
	GameState.selected_spell["effect"] = effect
	GameState.selected_spell["effect_power"] = 1
	update_current_spell_text()

func _on_minus_element_button_pressed() -> void:
	var current_power = GameState.selected_spell["element_power"]

	if current_power > 1:
		GameState.selected_spell["element_power"] -= 1
		update_current_spell_text()

func _on_plus_element_button_pressed() -> void:
	var element = GameState.selected_spell["element"]
	var owned_amount = GameState.elements.get(element, 0)
	var current_power = GameState.selected_spell["element_power"]

	if current_power < owned_amount:
		GameState.selected_spell["element_power"] += 1
		update_current_spell_text()

func update_power_texts() -> void:
	%ElementPowerLabel.text = str(GameState.selected_spell["element_power"])
	%EffectPowerLabel.text = str(GameState.selected_spell["effect_power"])

func _on_minus_effect_button_pressed() -> void:
	var current_power = GameState.selected_spell["effect_power"]

	if current_power > 1:
		GameState.selected_spell["effect_power"] -= 1
		update_current_spell_text()

func _on_plus_effect_button_pressed() -> void:
	var effect = GameState.selected_spell["effect"]
	var owned_amount = GameState.effects.get(effect, 0)
	var current_power = GameState.selected_spell["effect_power"]

	if current_power < owned_amount:
		GameState.selected_spell["effect_power"] += 1
		update_current_spell_text()
