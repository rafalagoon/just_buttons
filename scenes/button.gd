extends Node3D



func click ():
	
	$Base/Switch/AnimationPlayer.stop()
	$Base/Switch/AnimationPlayer.play("RESET")
	$AnimationPlayer.play("Press")


func flash (play_audio := true):
	$Base/Switch/AnimationPlayer.play("Flash")
	$Area3D.set_meta("flashing", true)
	$Area3D/CollisionShape3D.disabled = false
	if play_audio:
		$BlobAudioStreamPlayer3D.play()


