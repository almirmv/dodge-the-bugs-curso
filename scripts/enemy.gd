extends RigidBody2D

@onready var anim = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy_types = Array(anim.sprite_frames.get_animations_names())
	anim.animation = enemy_types.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# chamado quando um enemy sai da tela
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # apaga da memoria
