Class {
	#name : #CommentGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'cg'
	],
	#category : #'CommentGenerator-Test'
}

{ #category : #tests }
CommentGeneratorTest >> setUp [
	super setUp.
	cg := CommentGenerator new.
	cg targetClass: CGCarExample.
]

{ #category : #tests }
CommentGeneratorTest >> testGenerateDocument [

	| textDocument |
	textDocument := cg generateDocument.
	self assert: textDocument isString.
	self assert: textDocument notEmpty.
	self assert: textDocument equals:
'Name: CGCarExample

Users: 
 - CGParkingExample
 - CommentGeneratorTest

Used: 
 - CGDriver
 - Object
 - CGEngine

Public methods:
 - addOneHour

Keywords: hour,one,add,initialize'
]

{ #category : #tests }
CommentGeneratorTest >> testPublicMessages [
	| publicMessages |
	publicMessages := cg publicMethods.
	self assert: publicMessages notEmpty.
	self assert: (publicMessages includes: #addOneHour). 
	
]

{ #category : #tests }
CommentGeneratorTest >> testSimple [

	| users users2 |
	users := cg whoIsUsingTarget.
	self assert: users asArray equals: { CGParkingExample . CommentGeneratorTest }.
	
	users2 := cg whoIsUsedByTarget.
	self assert: users2 equals: { CGDriver. CGEngine. Object }.

]
