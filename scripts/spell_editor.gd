extends Control

func _ready() -> void:
	update_current_spell_text()
	list_elements()

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

func _on_element_selected(element) -> void:
	GameState.selected_spell["element"] = element
	update_current_spell_text()
