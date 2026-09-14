extends Node2D


func spawn_enemies():
	var new_enemy = preload("res://scenes/enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	add_child(new_enemy)
	

func _on_timer_timeout() -> void:
	spawn_enemies()


func _on_level_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/level_clear_menu.tscn")
