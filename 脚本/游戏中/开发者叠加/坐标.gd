extends Label

@export var player: CharacterBody3D
@export var flashlight: SpotLight3D

func _process(delta: float) -> void:
	var fps: int = Engine.get_frames_per_second()
	var pos: Vector3 = player.global_position if player else Vector3.ZERO
	var speed: float = player.velocity.length() if player else 0.0
	var light_status: String = "开" if (flashlight and flashlight.visible) else "关"

	text = """FPS: %d
坐标: (%.1f, %.1f, %.1f)
速度: %.1f
手电筒: %s""" % [fps, pos.x, pos.y, pos.z, speed, light_status]
