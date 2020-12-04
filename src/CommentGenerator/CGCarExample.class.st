Class {
	#name : #CGCarExample,
	#superclass : #Object,
	#instVars : [
		'driver',
		'engine',
		'numberOfHours'
	],
	#category : #'CommentGenerator-Example'
}

{ #category : #adding }
CGCarExample >> addOneHour [
	numberOfHours := numberOfHours + 1
]

{ #category : #initialization }
CGCarExample >> initialize [
	driver := CGDriver new.
	engine := CGEngine new.
	numberOfHours := 0.
]
