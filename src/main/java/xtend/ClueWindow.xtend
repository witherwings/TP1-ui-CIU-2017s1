package xtend

import Game.CaseFile
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class ClueWindow extends Dialog<CaseFile>{
	
	int placeNumber
	
	new(WindowOwner owner, CaseFile model, int placeNumber) {
		super(owner, model)
		this.placeNumber = placeNumber
		this.title = model.caseName
		this.taskDescription = "Estas visitando: " + model.currentCountry.places.get(placeNumber).getPlaceName
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val mainP = new Panel(mainPanel)
		
		val place = this.modelObject.currentCountry.places.get(placeNumber)
		new Label(mainP).text = place.occupant.getClue(this.modelObject, place)
		
		new Button(mainP)
			.setCaption("Continuar")
			.onClick [| this.accept]
	}
	
	override accept(){
		if(this.modelObject.currentCountry.places.get(placeNumber).occupant.isVillain())
			new EndGameWindow(this, this.modelObject).open
		this.close
	}
		
}