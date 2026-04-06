extends NinePatchRect


func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass




func 当_开始游戏_被按下() -> void:
	get_tree().change_scene_to_file("res://场景/游戏/地形.tscn")

func 当_设置_被按下() -> void:
	pass # Replace with function body.


func 当_退出_被按下() -> void:
	get_tree().quit()
