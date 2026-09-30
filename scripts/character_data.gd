extends Node

var characters = [
	{
		"name": "Fire Mush",
		"sprite": preload("res://assets/red_mushroom.png"),
		"preferred_elements": ["Fire"],
		"non-preferred_elements": ["Ice"],
		"details": "A spicy mushroom.",
		"ultimate": {"name": "Sporefire", "description": "I'm sure it will be hot once it exists!"}
	},
	{
		"name": "Ice Mush",
		"sprite": preload("res://assets/blue_mushroom.png"),
		"preferred_elements": ["Ice"],
		"non-preferred_elements": ["Fire"],
		"details": "A cool mushroom.",
		"ultimate": {"name": "mIcelium", "description": "Will be sure to give you the chills once it exists!"}
	},
	{
		"name": "Test Mush",
		"sprite": preload("res://assets/blue_mushroom.png"),
		"preferred_elements": ["None"],
		"non-preferred_elements": ["None"],
		"details": "A test mushroom to test the structure of the scene tree.",
		"ultimate": {"name": "The final exam", "description": "A very long text here. This text is purely for developmental purposes. It serves no real functionality regarding gameplay. It is meant to be removed once the development has reached a point where it is no longer needed."}
	}
]
