extends RichTextLabel

@export var player: CharacterBody3D

func _process(delta: float) -> void:
	# 获取 FPS
	var fps: int = Engine.get_frames_per_second()
	
	# 根据 FPS 选择颜色
	var fps_color: String
	if fps >= 50:
		fps_color = "green"
	elif fps >= 30:
		fps_color = "orange"
	else:
		fps_color = "red"
	
	# 构建第一行（带颜色的 FPS）
	var fps_line: String = "[color=%s]FPS: %d[/color]" % [fps_color, fps]
	
	# 构建第二行（坐标，默认白色）
	var pos_line: String
	if player:
		var pos: Vector3 = player.global_position
		pos_line = "X: %.2f  Y: %.2f  Z: %.2f" % [pos.x, pos.y, pos.z]
	else:
		pos_line = "玩家未设定"
	
	# 合并两行，用换行符隔开
	text = fps_line + "\n" + pos_line
