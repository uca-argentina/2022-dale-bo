Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
DiceCup class >> assertValid: dice [ 
	dice size > 0 ifFalse: [Error signal: 'DiceCup can´t be empty' ].
]

{ #category : #'instance creation' }
DiceCup class >> withAll: dice [ 
	self assertValid: dice.
	^self new initializeWithAll: dice. 
]

{ #category : #initialization }
DiceCup >> initializeWithAll: aDice [
	dice := aDice.
]

{ #category : #actions }
DiceCup >> roll [
	^dice sum: [:die | die roll ]
]
