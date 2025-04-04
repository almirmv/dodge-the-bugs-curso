extends CanvasLayer

signal start_game
@onready var score_label: Label = $Control/ScoreLabel
@onready var message_label = $Control/MessageLabel
@onready var message_timer = $MessageTimer
@onready var start_button: Button = $Control/StartButton


func show_message(text: String) -> void:
	message_label.text = text
	message_label.show()
	message_timer.start()


func show_game_over() -> void:
	show_message("Game Over")
	await message_timer.timeout # aguarda um tempo e volta a mostrar o titulo do jogo
	message_label.text = "Dodge the bugs"
	message_label.show()
	# agora criar timer para depois mostrar o botao de iniciar
	await get_tree().create_timer(1.0).timeout
	start_button.show()


func update_score(score: int) -> void:
	score_label.text = str(score)


func _on_start_button_pressed() -> void:
	start_button.hide() # esconde o botao
	start_game.emit()   # envia sinal de inicio de jogo


func _on_message_timer_timeout() -> void:
	message_label.hide() # esconde message label
