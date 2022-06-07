Class {
	#name : #PositionControllerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
PositionControllerTest >> should: aBlock raise: anError withMessage: anErrorMessage [

	| tmp2 tmp3 |
	aBlock
		on: anError
		do: [ :error | 
			tmp2 := true.
			tmp3 := error messageText ].
	self
		assert: tmp2;
		assert: tmp3 equals: anErrorMessage
]

{ #category : #tests }
PositionControllerTest >> testPositionControllerMovesOneShipBackwards3Boxes [

	| positionController |
	positionController := PositionController for: { 'Valen'. 'Pablo' }.
	positionController moveForward: 'Valen' to: 7 with:5 and:2.
	positionController moveBackwards: 'Valen' to: 3 with:5 and:2.
	
	self assert: (positionController positionOf: 'Valen') boxNumber equals: 5.
	self assert:(positionController positionOf: 'Valen')lapNumber equals: 1.
]

{ #category : #tests }
PositionControllerTest >> testPositionControllerMovesOneShipForward3Boxes [

	| positionController |
	positionController := PositionController for: { 'Valen'. 'Pablo' }.
	positionController moveForward: 'Valen' to: 7 with:5 and: 2.
	self assert: (positionController positionOf: 'Valen') boxNumber equals: 3.
	self assert: (positionController positionOf: 'Valen') lapNumber  equals: 2.
]
