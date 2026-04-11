extends CanvasLayer

func _ready() -> void:
	self.show()
	var 淡化 = $"淡化"
	
	淡化.modulate = Color.BLACK
	淡化.show()
	
	# 2. 关键修改：先等待 5 秒让场景加载
	# 使用 get_tree().create_timer() 避免与 tween 混淆，且不绑定节点
	await get_tree().create_timer(5.0).timeout
	
	# 3. 5 秒后再创建淡出动画
	var fade_tween = create_tween().bind_node(淡化)
	fade_tween.tween_property(淡化, "modulate", Color(0, 0, 0, 0), 0.2)
	
	await fade_tween.finished
	淡化.hide()
	self.hide()
