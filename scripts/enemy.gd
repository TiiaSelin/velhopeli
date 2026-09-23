extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")

var health = 3
var normal_speed: float = 300.0
var current_speed: float = 300.0
@export_category("Loot")
@export var spell_part_drop_chance := 1.0
@export var spell_part_drops: Array[SpellPartDrop]

#Vihollisen liike
func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * current_speed
	move_and_slide()

# Damage and death. 
func take_damage(damage):
	health -= damage
	%HealthBar.value = health
	
	if health <= 0:
		call_deferred("spawn_currency_pickup")
		call_deferred("roll_spawn_spell_part")
		call_deferred("queue_free")

# Spawn currency upon death.
func spawn_currency_pickup():
	var currency_pickup = preload("res://scenes/loot/currency_pickup.tscn").instantiate()
	currency_pickup.position = position + Vector2(randf_range(-20, 20), randf_range(-20, 20))
	get_parent().add_child(currency_pickup)

func roll_spawn_spell_part():
	if randf() <= spell_part_drop_chance:
		var spell_part_pickup = preload("res://scenes/loot/spell_part_pickup.tscn").instantiate()
		var drop = spell_part_drops.pick_random()

		spell_part_pickup.part_type = drop.part_type
		if drop.part_type == "element":
			spell_part_pickup.part_name = drop.part_data.element_name
		elif drop.part_type == "form":
			spell_part_pickup.part_name = drop.part_data.form_name
		elif drop.part_type == "effect":
			spell_part_pickup.part_name = drop.part_data.effect_name

		spell_part_pickup.set_icon(drop.get_icon())

		spell_part_pickup.position = position + Vector2(randf_range(-20, 20), randf_range(-20, 20))

		get_parent().add_child(spell_part_pickup)

func apply_ice(amount, duration) -> void:
	current_speed = normal_speed * (1.0 - amount)
	$IceTimer.start(duration)

func _on_ice_timer_timeout() -> void:
	current_speed = normal_speed
