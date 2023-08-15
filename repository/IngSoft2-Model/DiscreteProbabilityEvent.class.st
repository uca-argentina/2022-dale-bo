Class {
	#name : #DiscreteProbabilityEvent,
	#superclass : #Object,
	#instVars : [
		'box',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiscreteProbabilityEvent class >> for: aBoxEffect with: aProbability [
	^self new initializeFor:aBoxEffect with:aProbability.
]

{ #category : #initialization }
DiscreteProbabilityEvent >> box [

	^ box
]

{ #category : #initialization }
DiscreteProbabilityEvent >> initializeFor: aBoxEffect with: aProbability [ 
	box:=aBoxEffect.
	probability:= aProbability.
]

{ #category : #initialization }
DiscreteProbabilityEvent >> probability [

	^ probability
]
