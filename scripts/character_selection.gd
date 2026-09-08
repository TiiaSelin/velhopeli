extends Control

@onready var game = preload("res://scenes/game.tscn")

var characters = [
	{
		"name": "Mushroom",
		"sprite": preload("res://assets/sienihahmo.png")
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
	get_tree().change_scene_to_packed(game)

func _on_previous_pressed() -> void:
	print("Previous.")

	# Previous button logic once more characters are added.
	'''
	selected_character -= 1

	if selected_character < 0:
		selected_character = characters.size() - 1

	update_character_display()
	'''

func _on_next_pressed() -> void:
	print("Next.")
	
	# Next button logic once more characters are added.
	'''
	selected_character += 1

	if selected_character >= characters.size():
		selected_character = 0

	update_character_display()
	'''
