extends Area2D

signal hit # player will send signal when hit

@export var SPEED := 400 # How fast the player will move (pixels/sec).
@onready var screen_size = get_viewport_rect().size
@onready var anim = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	var velocity = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	if velocity.x != 0:
		anim.play("move")
	elif velocity.y > 0:
		anim.play("move_up")
	elif velocity.y < 0:
		anim.play("move_down")
	else:
		anim.play("idle")
	# animar olhos para direita ou esquerda invertendo sprite
	if velocity.x > 0:
		anim.flip_h = false
	else:
		anim.flip_h = true
	
	# atualiza posicao na tela
	position += velocity * delta  
	# limitar movimento dentro da tela
	position = position.clamp(Vector2.ZERO, screen_size)

# verificaçao da colisao do player com os bugs
func _on_body_entered(body: Node2D) -> void:
	hide() # esconde o player
	hit.emit() # envia sinal que player foi atingido
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	

func start_pos(pos):
	position = pos
	show() # mostra o player
	$CollisionShape2D.disabled = false # activate collision detection
