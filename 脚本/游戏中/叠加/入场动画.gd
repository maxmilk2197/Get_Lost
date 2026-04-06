extends CanvasLayer

func _ready() -> void:
	var 淡化 = $"淡化"
	淡化.modulate = Color.BLACK   # 初始为纯黑不透明
	淡化.show()
	var 淡化动画 = create_tween().bind_node(淡化)
	淡化动画.tween_property(淡化, "modulate", Color(0,0,0,0), 0.2)  # 渐变到全透明
	await 淡化动画.finished
	淡化.hide()
	self.hide()
