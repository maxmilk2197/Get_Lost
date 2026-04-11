extends Control



@onready var rec_red_point = $Rec红点

func _ready() -> void:
	_start_blinking()

func _start_blinking() -> void:
	while true:
		rec_red_point.hide()
		await get_tree().create_timer(1.0).timeout
		rec_red_point.show()
		await get_tree().create_timer(1.0).timeout
