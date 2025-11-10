extends Node

signal playing(data: Dictionary)

func play(data: Dictionary):
	playing.emit(data)
