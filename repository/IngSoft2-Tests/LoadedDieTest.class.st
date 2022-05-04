Class {
	#name : #LoadedDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LoadedDieTest >> should: aBlock raise: anErrorClass whoseDescriptionIncludes: anErrorMessage [ 
	self
			should: aBlock
			raise: anErrorClass
			whoseDescriptionIncludes: anErrorMessage
			description: 'Test did not fail as expected'.
]

{ #category : #tests }
LoadedDieTest >> testLoadedDieCantBeLoadedWith0 [

	self
		should: [ LoadedDie with: 0 ]
		raise: Error
		whoseDescriptionIncludes: 'Number of faces should be greater than 0'
]

{ #category : #tests }
LoadedDieTest >> testLoadedDieRollsOneWhenLoadedWithOne [

	| die rollResult |
	die := LoadedDie with: 1.
	rollResult := die roll.
	self assert: rollResult equals: 1
]
