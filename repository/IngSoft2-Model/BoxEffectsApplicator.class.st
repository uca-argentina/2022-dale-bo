Class {
	#name : #BoxEffectsApplicator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'action handling' }
BoxEffectsApplicator >> applyTo: aSpaceshipPosition using:aGame [

	(aGame lastBoxEffect) triggeredBy:aSpaceshipPosition name with: aGame. "REVISAR. 1 solo metodo  que en realidad llama a otro de otro objeto, middle man."
]
