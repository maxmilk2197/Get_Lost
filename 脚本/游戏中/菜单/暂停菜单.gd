extends CanvasLayer

func _ready():
	process_mode = PROCESS_MODE_ALWAYS #在暂停时也可以触发            

func 显示菜单():
	show()
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func 隐藏菜单():
	hide()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func 当_继续_被按下():
	hide()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"../角色/相机".是否暂停 = false

func 当_返回主界面_被按下():
	# 恢复暂停和鼠标，然后切换场景
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://场景/菜单/主菜单.tscn")
