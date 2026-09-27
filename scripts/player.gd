extends CharacterBody2D

var health = 100.0
var max_health = 100.0
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
		update_health(-DAMAGE_RATE * overlapping_enemies.size() * _delta)
		%HealthBar.value = health
		if health <= 0.0:
			get_tree().change_scene_to_file("res://scenes/game_over_menu.tscn")

# Create spells on runtime.
func _ready() -> void:
	if GameState.selected_character == 0:
		%PlayerSprite.texture = preload("res://assets/red_mushroom.png")
	elif GameState.selected_character == 1:
		%PlayerSprite.texture = preload("res://assets/blue_mushroom.png")
	default_spell = SpellData.new()
	default_spell.setup(
		spell_library.get_element(GameState.default_spell["element"]),
		spell_library.get_form(GameState.default_spell["form"]),
		spell_library.get_effect(GameState.default_spell["effect"])
	)

	selected_spell = create_spell(GameState.selected_spell)

# Player inputs.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			cast_default()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			cast_selected()
	elif event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			use_item(GameState.inventory.get_item_in_slot(0))
		elif event.keycode == KEY_2:
			use_item(GameState.inventory.get_item_in_slot(1))

# Spell types.
func cast_default():
	cast_spell(default_spell, 10)

func cast_selected():
	if selected_spell == null:
		return

	cast_spell(selected_spell, 20)

func cast_spell(spell, mana_cost):
	if mana < mana_cost:
		return

	update_mana(-mana_cost)
	%ManaBar.value = mana

	var new_projectile = spell.form.spell_scene.instantiate()
	new_projectile.spell_data = spell

	var target = get_global_mouse_position()
	var angle = global_position.angle_to_point(target)

	new_projectile.rotation = angle

	get_parent().add_child(new_projectile)
	new_projectile.global_position = %ShootingPoint.global_position
	new_projectile.global_rotation = %ShootingPoint.global_rotation

# Item usage.
func use_item(item) -> void:
	if item == null:
		return

	if not GameState.inventory.use_item(item):
		return

	match item.effect_type:
		ItemData.EffectType.HEALTH:
			update_health(item.effect_amount)
		ItemData.EffectType.MANA:
			update_mana(item.effect_amount)

# Mana recharge.
func _on_mp_recharge_timeout() -> void:
	update_mana(1.0)

func update_health(amount) -> void:
	health = clamp(health + amount, 0.0, max_health)
	%HealthBar.value = health

func update_mana(amount) -> void:
	mana = clamp(mana + amount, 0.0, max_mana)
	%ManaBar.value = mana

func update_currency(amount) -> void:
	GameState.currency += amount

# Create "selected_spell".
func create_spell(spell_data) -> SpellData:
	var spell = SpellData.new()

	if spell_data["element"] == null:
		return null
	elif spell_data["form"] == null:
		return null
	elif spell_data["effect"] == null:
		return null

	spell.setup(
		spell_library.get_element(spell_data["element"]),
		spell_library.get_form(spell_data["form"]),
		spell_library.get_effect(spell_data["effect"])
	)

	spell.element_power = spell_data["element_power"]
	spell.form_power = spell_data["form_power"]
	spell.effect_power = spell_data["effect_power"]

	return spell
