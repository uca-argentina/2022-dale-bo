Class {
	#name : #NormalWormholeState,
	#superclass : #BoxEffectState,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
NormalWormholeState >> reverse [
	^ ReversedWormholeState new.
]

{ #category : #action }
NormalWormholeState >> triggeredBy: aSpaceship with: aGame [

	(aGame board) calculate: aSpaceship newpositionUsing: -4
]
