extends Control

@onready var game = preload("res://scenes/game.tscn")

var characters = [
	{
		"name": "Fire Mush",
		"sprite": preload("res://assets/red_mushroom.png")
	},
	{
		"name": "Ice Mush",
		"sprite": preload("res://assets/blue_mushroom.png")
	}
]

var selected_character = 0

func _ready() -> void:
	update_character_display()

func update_character_display():
	var character = characters[selected_character]

	%CharacterName.text = character["name"]
	%CharacterSprite.texture = character["sprite"]

func _on_start_game_pressed() -> void:
	GameState.selected_character = selected_character
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
