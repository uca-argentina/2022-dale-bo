Class {
	#name : #DiceCupTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DiceCupTest >> should: aBlock raise: anErrorClass whoseDescriptionIncludes: anErrorMessage [ 
	self
			should: aBlock
			raise: anErrorClass
			whoseDescriptionIncludes: anErrorMessage
			description: 'Test did not fail as expected'
]

{ #category : #tests }
DiceCupTest >> testDiceCupCannotBeEmpty [

	self
		should: [ DiceCup withAll: {  } ]
		raise: Error
		whoseDescriptionIncludes: 'DiceCup can´t be empty'
]

{ #category : #tests }
DiceCupTest >> testDiceCupRollShouldReturnTheSumOfAllLoadedDie [

	| dieOne dieTwo dieThree aDiceCup rollResult |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.

	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.

	rollResult := aDiceCup roll.
	self assert: rollResult equals: 6
]
