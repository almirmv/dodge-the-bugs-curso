extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = enemy_types.pick_random()


# chamado quando um enemy sai da tela
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # apaga da memoria
