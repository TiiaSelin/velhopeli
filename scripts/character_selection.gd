extends Control

@onready var game = preload("res://scenes/game.tscn")

var characters = CharacterData.characters

var selected_character = 0

func _ready() -> void:
	update_character_display()

func update_character_display():
	var character = characters[selected_character]

	%CharacterName.text = character["name"]
	%CharacterSprite.texture = character["sprite"]
	%Preferreds.text = ", ".join(character["preferred_elements"])
	%NonPreferreds.text = ", ".join(character["non-preferred_elements"])
	%DetailsText.text = character["details"]
	%UltimateText.text = "[i]" + character["ultimate"]["name"] + "[/i]: " + character["ultimate"]["description"]

func update_tabs(selected_button) -> void:
	var buttons = [
		%BaseStatsButton,
		%PreferencesButton,
		%DetailsButton
	]

	for button in buttons:
		button.remove_theme_color_override("font_color")
		button.remove_theme_stylebox_override("normal")
		button.remove_theme_stylebox_override("hover")
		button.remove_theme_stylebox_override("pressed")
		button.remove_theme_stylebox_override("focus")

	selected_button.add_theme_color_override("font_color", Color.BLACK)

	var selected_style = StyleBoxFlat.new()
	selected_style.bg_color = Color("#45ad9a")
	
	selected_style.corner_radius_top_left = 5
	selected_style.corner_radius_top_right = 5
	selected_style.corner_radius_bottom_left = 5
	selected_style.corner_radius_bottom_right = 5

	selected_button.add_theme_stylebox_override("normal", selected_style)
	selected_button.add_theme_stylebox_override("hover", selected_style)
	selected_button.add_theme_stylebox_override("pressed", selected_style)
	selected_button.add_theme_stylebox_override("focus", selected_style)

func _on_start_game_pressed() -> void:
	GameState.selected_character = selected_character
	GameState.preferred_elements = characters[selected_character]["preferred_elements"]
	get_tree().change_scene_to_packed(game)

func _on_previous_pressed() -> void:
	selected_character -= 1

	if selected_character < 0:
		selected_character = characters.size() - 1

	update_character_display()

func _on_next_pressed() -> void:
	selected_character += 1

	if selected_character >= characters.size():
		selected_character = 0

	update_character_display()

func _on_base_stats_button_pressed() -> void:
	%BaseStatsContainer.visible = true
	%PreferencesContainer.visible = false
	%DetailsContainer.visible = false

	update_tabs(%BaseStatsButton)

func _on_preferences_button_pressed() -> void:
	%PreferencesContainer.visible = true
	%BaseStatsContainer.visible = false
	%DetailsContainer.visible = false

	update_tabs(%PreferencesButton)

func _on_details_button_pressed() -> void:
	%DetailsContainer.visible = true
	%BaseStatsContainer.visible = false
	%PreferencesContainer.visible = false

	update_tabs(%DetailsButton)
