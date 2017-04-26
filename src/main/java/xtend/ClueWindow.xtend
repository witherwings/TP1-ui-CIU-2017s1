package xtend

import Game.CaseFile
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel

class ClueWindow extends Dialog<CaseFile>{
	
	int placeNumber
	
	new(WindowOwner owner, CaseFile model, int placeNumber) {
		super(owner, model)
		this.placeNumber = placeNumber
		this.title = model.caseName
		this.taskDescription = "Estas visitando: " + model.actualCountry.places.get(placeNumber).getPlaceName
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
	}
		
}