Class {
	#name : #CommentGenerator,
	#superclass : #Object,
	#instVars : [
		'targetClass'
	],
	#classInstVars : [
		'w'
	],
	#category : #'CommentGenerator-Core'
}

{ #category : #'as yet unclassified' }
CommentGenerator >> generateDocument [
	"This the main public method to generate a comment for the target class"

	| w |
	w := WriteStream on: String new.
	self generateNameOn: w.
	w cr; cr.
	self genereateUsersOn: w.
	w cr.
	self genererateUsedOn: w.
	w cr.
	self genereratePublicMethodsOn: w.
	w cr.
	self generateKeywordsOn: w.
	^ w contents
	
]

{ #category : #'as yet unclassified' }
CommentGenerator >> generateKeywordsOn: stream [
	"Write the name of the target class on stream"
	| keywords |
	keywords := ((((targetClass selectors flatCollect: #splitCamelCase) collect: [ :k | k asLowercase copyWithoutAll: ':' ]) groupedBy: #yourself) associations sort: [ :assoc1 :assoc2 | assoc1 value size > assoc2 value size ]) collect: #key.
	
	stream nextPutAll: 'Keywords: '.
	stream nextPutAll: (',' join: (keywords copyFrom: 1 to: (10 min: keywords size)))
	




]

{ #category : #'as yet unclassified' }
CommentGenerator >> generateNameOn: stream [
	"Write the name of the target class on stream"
	stream nextPutAll: 'Name: '.
	stream nextPutAll: targetClass name.
]

{ #category : #'as yet unclassified' }
CommentGenerator >> genereateUsersOn: stream [
	"Write the users of the target class on stream"
	stream nextPutAll: 'Users: '; cr.
	self whoIsUsingTarget do: [ :cls |
		stream nextPutAll: ' - '.
		stream nextPutAll: cls name.
		stream cr.
		 ]

]

{ #category : #'as yet unclassified' }
CommentGenerator >> genereratePublicMethodsOn: stream [
	"Write the public method of the target class on stream"
	stream nextPutAll: 'Public methods:'; cr.
	self publicMethods do: [ :methodName |
		stream nextPutAll: ' - '.
		stream nextPutAll: methodName.
		stream cr.
		 ]

]

{ #category : #'as yet unclassified' }
CommentGenerator >> genererateUsedOn: stream [
 
	"Write the classes used by the target class on stream"
	stream nextPutAll: 'Used: '; cr.
	self whoIsUsedByTarget do: [ :cls |
		stream nextPutAll: ' - '.
		stream nextPutAll: cls name.
		stream cr.
		 ]

]

{ #category : #'as yet unclassified' }
CommentGenerator >> publicMethods [
	"Return the method names that are considered as public in the target class."
	| senders results |
	results := OrderedCollection new.
	self relevantMethods do: [ :methodName | 
		senders := SystemNavigation default allSendersOf: methodName.
		(senders anySatisfy: [ :method | method methodClass ~~ targetClass ])
			ifTrue: [ results add: methodName ] ].
	^ results
]

{ #category : #'as yet unclassified' }
CommentGenerator >> relevantMethods [
	| blackListMethods |
	blackListMethods := #(#initialize).
	^ targetClass selectors copyWithoutAll: blackListMethods.
]

{ #category : #accessing }
CommentGenerator >> targetClass [
	^ targetClass
]

{ #category : #accessing }
CommentGenerator >> targetClass: aPharoClass [
	targetClass := aPharoClass
]

{ #category : #'as yet unclassified' }
CommentGenerator >> whoIsUsedByTarget [
	^ targetClass dependentClasses
]

{ #category : #'as yet unclassified' }
CommentGenerator >> whoIsUsingTarget [
	"Return the list of classes, alphabetically ordered, that user the targetClass"
	| methods |
	methods := SystemNavigation default allReferencesTo: (targetClass environment bindingOf: targetClass name).
	^ ((methods collect: #methodClass) asSet asSortedCollection: [ :c1 :c2 | c1 name < c2 name ]) asArray
]
