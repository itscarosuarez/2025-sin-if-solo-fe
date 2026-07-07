"
card
"
Class {
	#name : 'CardFreedom',
	#superclass : 'Card',
	#instVars : [
		'spaceship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardFreedom >> applyInstantaneousEffectIn: aGame [ 

	aGame getsFreeFromJail: spaceship


]

{ #category : 'action' }
CardFreedom >> playedBy: aSpaceship targeting: aTarget in: aGame [

	spaceship := aSpaceship.
	aGame playsInstantaneousCard: self
]
