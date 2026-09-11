extends CharacterBody2D

var health = 100.0
var mana = 100.0
var max_mana = 100.0
const PROJECTILE = preload("res://scenes/projectile.tscn")

var default_spell: SpellData
var selected_spell: SpellData
@export var spell_library: SpellLibrary

# Pelaajahahmon liike
func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#Hahmon nopeus
	velocity = direction * 650
	move_and_slide()

	%ShootingPoint.global_rotation = global_position.angle_to_point(get_global_mouse_position())

	# Player damage and game over.
	const DAMAGE_RATE = 50.0
	var overlapping_enemies = %HurtBox.get_overlapping_bodies()

	if overlapping_enemies.size() > 0:
		health -= DAMAGE_RATE * overlapping_enemies.size() * _delta
		%HealthBar.value = health
		if health <= 0.0:
			print("Game over.")
			get_tree().paused = true

# Create spells on runtime.
func _ready() -> void:
	default_spell = SpellData.new()
	default_spell.setup(
		spell_library.get_element("None"),
		spell_library.get_form("Projectile"),
		spell_library.get_effect("None")
	)

	selected_spell = SpellData.new()
	selected_spell.setup(
		spell_library.get_element("Fire"),
		spell_library.get_form("Projectile"),
		spell_library.get_effect("None")
	)

# Player inputs.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			cast_default()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			cast_selected()

# Spell types.
func cast_default():
	cast_spell(default_spell, 10)

func cast_selected():
	cast_spell(selected_spell, 20)

func cast_spell(spell, mana_cost):
	if mana < mana_cost:
		return

	mana -= mana_cost
	%ManaBar.value = mana

	var new_projectile = spell.form.spell_scene.instantiate()
	new_projectile.spell_data = spell

	var target = get_global_mouse_position()
	var angle = global_position.angle_to_point(target)

	new_projectile.rotation = angle

	get_parent().add_child(new_projectile)
	new_projectile.global_position = %ShootingPoint.global_position
	new_projectile.global_rotation = %ShootingPoint.global_rotation

# Mana recharge.
func _on_mp_recharge_timeout() -> void:
	mana = clamp(mana + 1.0, 0.0, max_mana)
	%ManaBar.value = mana
