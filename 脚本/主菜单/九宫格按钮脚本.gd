extends NinePatchRect


func _ready() -> void:
	var 淡化 = $"../淡化"
	淡化.modulate = Color.BLACK   # 初始为纯黑不透明
	淡化.show()
	var 淡化动画 = create_tween().bind_node(淡化)
	淡化动画.tween_property(淡化, "modulate", Color(0,0,0,0), 0.2)  # 渐变到全透明
	await 淡化动画.finished
	淡化.hide()
	

func 当_开始游戏_被按下() -> void:
	var 退出淡化 = $"../淡化"
	退出淡化.modulate = Color(0,0,0,0)   # 纯黑透明
	退出淡化.show()
	var 淡化动画 = create_tween().bind_node(退出淡化)
	淡化动画.tween_property(退出淡化, "modulate", Color.BLACK, 0.2)
	await 淡化动画.finished
	get_tree().change_scene_to_file("res://场景/游戏/游戏/世界1.tscn")


func 当_设置_被按下() -> void:
	pass # Replace with function body.


func 当_退出_被按下() -> void:
	var 退出淡化 = $"../淡化"
	退出淡化.modulate = Color(0,0,0,0)   # 纯黑透明
	退出淡化.show()
	var 淡化动画 = create_tween().bind_node(退出淡化)
	淡化动画.tween_property(退出淡化, "modulate", Color.BLACK, 0.2)
	await 淡化动画.finished
	get_tree().quit()
