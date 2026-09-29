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
	%Preferreds.text = ", ".join(character["preferred_components"])
	%NonPreferreds.text = ", ".join(character["non-preferred_components"])
	%DetailsText.text = character["details"]
	%UltimateText.text = "[i]" + character["ultimate"]["name"] + "[/i]: " + character["ultimate"]["description"]

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

func _on_preferences_button_pressed() -> void:
	%PreferencesContainer.visible = true
	%BaseStatsContainer.visible = false
	%DetailsContainer.visible = false

func _on_details_button_pressed() -> void:
	%DetailsContainer.visible = true
	%BaseStatsContainer.visible = false
	%PreferencesContainer.visible = false
