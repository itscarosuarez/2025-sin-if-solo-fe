"
AllyCard

"
Class {
	#name : 'CardAlly',
	#superclass : 'Card',
	#instVars : [
		'spaceShipToTeamUp'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardAlly >> applyInstantaneousEffectIn: aGame [

	aGame formsAlianceWith: spaceShipToTeamUp
]

{ #category : 'action' }
CardAlly >> playedBy: aSpaceship targeting: aTarget in: aGame [

	spaceShipToTeamUp := aTarget.
	aGame playsPermanentCard: self
]
