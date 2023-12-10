Class {
	#name : #ReversedWormholeState,
	#superclass : #BoxEffectState,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
ReversedWormholeState >> reverse [
	^ NormalWormholeState new.
]

{ #category : #action }
ReversedWormholeState >> triggeredBy: aSpaceship with: aGame [

	(aGame board) calculate: aSpaceship newpositionUsing: 4
]
