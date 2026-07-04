"
Repeta Card

"
Class {
	#name : 'CardRepeat',
	#superclass : 'Card',
	#instVars : [
		'spaceship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardRepeat >> applyInstantaneousEffectIn: aGame [ 

	aGame applyRepeatEffectWith: spaceship


]

{ #category : 'action' }
CardRepeat >> playedBy: aSpaceship targeting: aTarget in: aGame [

	spaceship := aTarget.
	aGame playsInstantaneousCard: self
]
