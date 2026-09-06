extends Node2D

@export var arena_size := Vector2(2000, 2000)
@export var wall_thickness := 32.0

@onready var top_wall = %Top
@onready var right_wall = %Right
@onready var bottom_wall = %Bottom
@onready var left_wall = %Left

func _ready():
	set_boundaries()

func set_boundaries():
	# Set wall positions.
	
	top_wall.position = Vector2(
		arena_size.x / 2,
		-wall_thickness / 2
	)

	bottom_wall.position = Vector2(
		arena_size.x / 2,
		arena_size.y + wall_thickness / 2
	)

	left_wall.position = Vector2(
		-wall_thickness / 2,
		arena_size.y / 2
	)

	right_wall.position = Vector2(
		arena_size.x + wall_thickness / 2,
		arena_size.y / 2
	)
	
	# Set wall sizes.

	%Top/CollisionShape2D.shape.size = Vector2(
		arena_size.x,
		wall_thickness
	)

	%Right/CollisionShape2D.shape.size = Vector2(
		wall_thickness,
		arena_size.y
	)

	%Bottom/CollisionShape2D.shape.size = Vector2(
		arena_size.x,
		wall_thickness
	)

	%Left/CollisionShape2D.shape.size = Vector2(
		wall_thickness,
		arena_size.y
	)
