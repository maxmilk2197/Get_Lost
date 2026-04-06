extends Camera3D

# 引用玩家角色（需要手动拖拽赋值）
@export var 玩家: CharacterBody3D

# 鼠标灵敏度（单位：弧度/像素）
@export var 鼠标灵敏度: float = 0.002

# 垂直视角限制（度）
@export var 垂直视角限制: float = 90.0

# 暂停菜单 UI 节点（需要手动拖拽一个 CanvasLayer 或 Control 节点）
@export var 暂停菜单界面: CanvasLayer

# 内部变量：存储当前俯仰角（弧度）
var 视角: float = 0.0

# 是否处于暂停状态
var 是否暂停: bool = false


func _ready() -> void:
	# 确保暂停时相机仍能接收输入（用于恢复游戏）
	process_mode = PROCESS_MODE_ALWAYS
	
	# 确保初始时暂停菜单隐藏
	if 暂停菜单界面:
		暂停菜单界面.visible = false
	# 捕获并隐藏鼠标
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event: InputEvent) -> void:
	# 处理 ESC 键：切换暂停 / 恢复
	if event.is_action_pressed("ui_cancel"):
		切换暂停()
		return  # 避免在暂停/恢复时同时处理鼠标视角移动

	# 仅在游戏未暂停且鼠标被捕获时，处理视角旋转
	if not 是否暂停 and event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# 水平旋转（修改玩家角色的 Y 轴旋转）
		if 玩家:
			玩家.rotate_y(-event.relative.x * 鼠标灵敏度)
		
		# 垂直旋转（修改相机的 X 轴旋转）
		视角 -= event.relative.y * 鼠标灵敏度
		视角 = clamp(视角, deg_to_rad(-垂直视角限制), deg_to_rad(垂直视角限制))
		rotation.x = 视角



func 切换暂停() -> void:
	是否暂停 = not 是否暂停
	if 是否暂停:
		# 显示菜单
		暂停菜单界面.show()
		# 暂停游戏世界
		get_tree().paused = true
		# 释放鼠标，让玩家可以操作 UI
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		# 隐藏菜单
		暂停菜单界面.hide()
		# 恢复游戏
		get_tree().paused = false
		# 重新捕获鼠标
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
