extends Node

var Questions = [
	"",
	"",
	"",
	#general questions that could be answered with basic answers
	"",
	"",
	"",
	#Should be a good amount of these since they are referanced every time someone speaks.
]

var Responces = [
	"",
	#Write The Possible Responces, Wich should be general responces.
	#You should have less of these because we have little way of writing answers based on the questions asked
	"",
	"",
	"",
]

func TakeLines():
	var Qvalue = rand_range(0, Questions.len)
	var Rvalue = rand_range(0, Responces.len)
	

