Class {
	#name : #CGParkingExample,
	#superclass : #Object,
	#instVars : [
		'cars'
	],
	#category : #'CommentGenerator-Example'
}

{ #category : #adding }
CGParkingExample >> addCar [
	cars add: CGCarExample new
]

{ #category : #initialization }
CGParkingExample >> initialize [
	cars := OrderedCollection new
]

{ #category : #'as yet unclassified' }
CGParkingExample >> passOneHour [
	cars do: [ :c | c addOneHour ]
]
