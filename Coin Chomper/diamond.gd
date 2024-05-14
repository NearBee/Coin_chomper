extends Area2D


func _on_body_entered(body):
	queue_free()  #Player picks up the diamond
	var diamonds = get_tree().get_nodes_in_group("Diamonds")
	if diamonds.size() == 1:  #var.size() will default to 1 when there are no variables on screen
		Events.level_completed.emit()
	
