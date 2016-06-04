
extends RigidBody

# member variables here, example:
# var a=2
# var b="textvar"

var facing = Vector3(0.0, 0.0, 1.0)
func _ready():
	set_fixed_process(true)
func _fixed_process(dt):
	var vel = get_linear_velocity()
	var tr = get_global_transform()
	vel.y = 0
	
	for cam in get_tree().get_nodes_in_group("camera"):
		if cam.is_current():
			var cam_pos = cam.get_global_transform().origin
			var l_pos = get_global_transform().origin
			var dir = cam.get_global_transform().basis[2]
			var left = cam.get_global_transform().basis[0]
			var imp = Vector3()
			if Input.is_action_pressed("player_left"):
				imp -= left
				facing = -left
			if Input.is_action_pressed("player_right"):
				imp += left
				facing = left
			if Input.is_action_pressed("player_back"):
				imp += dir
				facing = dir
			if Input.is_action_pressed("player_forward"):
				imp -= dir
				facing = -dir
			imp.y = 0.015
			if vel.length() < 1.8:
				var lfacing = tr.xform_inv(facing).normalized()
				var ang = atan2(lfacing.z, lfacing.x)
				var rot = get_rotation()
				rot.y = ang
				set_rotation(rot)
				apply_impulse(Vector3(), imp * 90)

