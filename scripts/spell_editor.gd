extends Control

func _ready() -> void:
	update_current_spell_text()
	list_elements()
	list_forms()
	list_effects()

func update_current_spell_text():
	%CurrentSpellText.text = "Current spell: %s, %s, %s." % [
	("%s x%d" % [
		GameState.selected_spell["element"],
		GameState.selected_spell["element_power"]
	]) if GameState.selected_spell["element"] else "No element",
	("%s x%d" % [
		GameState.selected_spell["form"],
		GameState.selected_spell["form_power"]
	]) if GameState.selected_spell["form"] else "No form",
	("%s x%d" % [
		GameState.selected_spell["effect"],
		GameState.selected_spell["effect_power"]
	]) if GameState.selected_spell["effect"] else "No effect"
	]
	update_power_texts()
	update_spell_status()

func update_spell_status() -> void:
	if is_spell_usable():
		%IsUsable.text = "Spell ready!"
		%IsUsable.self_modulate = Color.GREEN
	else:
		%IsUsable.text = "Spell incomplete."
		%IsUsable.self_modulate = Color.RED

func is_spell_usable() -> bool:
	return (
		GameState.selected_spell["element"] != null
		and GameState.selected_spell["form"] != null
		and GameState.selected_spell["effect"] != null
	)

func update_power_texts() -> void:
	%ElementPowerLabel.text = str(GameState.selected_spell["element_power"])
	%FormPowerLabel.text = str(GameState.selected_spell["form_power"])
	%EffectPowerLabel.text = str(GameState.selected_spell["effect_power"])

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_clear_menu.tscn")

func list_elements() -> void:
	for element in GameState.elements:
		var button = Button.new()
		button.text = element
		button.pressed.connect(_on_element_selected.bind(element))
		%ElementButtons.add_child(button)

func list_forms() -> void:
	for form in GameState.forms:
		var button = Button.new()
		button.text = form
		button.pressed.connect(_on_form_selected.bind(form))
		%FormButtons.add_child(button)

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

func _on_form_selected(form) -> void:
	GameState.selected_spell["form"] = form
	GameState.selected_spell["form_power"] = 1
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

func _on_minus_form_button_pressed() -> void:
	var current_power = GameState.selected_spell["form_power"]

	if current_power > 1:
		GameState.selected_spell["form_power"] -= 1
		update_current_spell_text()

func _on_plus_form_button_pressed() -> void:
	var form = GameState.selected_spell["form"]
	var owned_amount = GameState.forms.get(form, 0)
	var current_power = GameState.selected_spell["form_power"]

	if current_power < owned_amount:
		GameState.selected_spell["form_power"] += 1
		update_current_spell_text()

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
