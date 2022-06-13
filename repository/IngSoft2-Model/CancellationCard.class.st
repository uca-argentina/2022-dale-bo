Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
CancellationCard >> applyTo: target over:aCardEffect [.

	target removeEffect:aCardEffect.
]

{ #category : #accessing }
CancellationCard >> family [

	^ 'Instant'
]

{ #category : #accessing }
CancellationCard >> type [

	^ 'CancelationCard'
]
