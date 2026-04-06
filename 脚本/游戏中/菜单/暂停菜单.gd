extends CanvasLayer


func _ready():
	hide()


func 显示菜单():
	show()                     # 显示菜单界面
	get_tree().paused = true   # 暂停游戏世界
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # 显示鼠标用于操作UI


func 隐藏菜单():
	hide()                     # 隐藏菜单界面
	get_tree().paused = false  # 恢复游戏
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # 重新捕获鼠标
