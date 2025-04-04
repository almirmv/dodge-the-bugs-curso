extends Node2D

@export var bug_scene : PackedScene
var score = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$BugTimer.stop()
	$HUD.show_game_over()
	$bgMusic.stop()
	$gameOverSound.play()

func new_game() -> void:
	score = 0
	$StartTimer.start()
	$player.start_pos($StartPosition.position)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")
	get_tree().call_group("bugs", "queue_free") # limpar todos os bugs antes de iniciar
	$bgMusic.play()


func _on_bug_timer_timeout() -> void:
	var bug = bug_scene.instantiate() 			# instancia o bug
	# posicao?
	var bug_location = $BugPath/BugPathLocation # diz o caminho onde ele pode ser iniciado
	bug_location.progress_ratio = randf() 		# qual ponto do caminho vai iniciar
	bug.position = bug_location.position 		# bug vai receber a initial position 
	# e a direcao (angulo inicial)?
	var direction = bug_location.rotation + PI / 2 # iniciar perpendicular ao $bug_path
	direction += randf_range(-PI/4,PI/4)		# limita em -90 a +90 (0 a 180)
	bug.rotation = direction					# bug recebe a direcao calculada
	# e velocidade?
	var velocity = Vector2(randf_range(150.0,250.0), 0.0)
	bug.linear_velocity = velocity.rotated(direction)	# recebe a velocidade calculada
	# finalmente adicionar na cena main
	add_child(bug)


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score) # atualiza score na tela


func _on_start_timer_timeout() -> void:
	$BugTimer.start()
	$ScoreTimer.start()
