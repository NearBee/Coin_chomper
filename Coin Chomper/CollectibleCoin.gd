extends Area2D


func _on_body_entered(body):
	queue_free()
	var coin = get_tree().get_nodes_in_group("Coin")
	if coin.size() == 1:
		Events.level_completed.emit()
		# Change to ALL collectibles collected being the LEVEL COMPLETE event
		
	
