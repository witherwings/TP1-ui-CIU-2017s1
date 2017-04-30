package xtend

import AppModel.CaseFilesAppModel
import Game.CaseFile
import WorldMap.Country
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class TravelWindow extends Dialog<CaseFilesAppModel> {
	
	new(WindowOwner owner, CaseFilesAppModel model) {
		super(owner, model)
		title = "Viajar"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val mainP = new Panel(mainPanel)
		mainP.layout = new VerticalLayout
		
		new Label(mainP).text = "Estas en: " + modelObject.currentCountry.name
		new Label(mainP).text = "Posibles destinos"
		new List<Country>(mainP) => [
			(items <=> "currentCountry.connectedCountries").adapter = new PropertyAdapter(Country, "name")
			height = 50
			width = 250
			value <=> "caseF.nextCountry"
		]
		
		val buttonPanel = new Panel(mainP)
		buttonPanel.layout = new HorizontalLayout
		new Button(buttonPanel)
			.setCaption("Volver al Pais anterior")
			.onClick [| this.travelBack]
		new Button(buttonPanel)
			.setCaption("Viajar")
			.onClick [| this.travelToSelectedCountry]
	}
	
	def travelBack() {
		this.modelObject.caseF.addfailedDestination(this.modelObject.currentCountry)
		this.modelObject.caseF.setCurrentCountry(this.modelObject.lastCountry)
		this.modelObject.caseF.setLastCountry(null)
		this.modelObject.caseF.setNextCountry(null)
		this.modelObject.updateList
		this.close
	}
	
	def travelToSelectedCountry() {
		this.modelObject.caseF.addSuccesfulDestination(this.modelObject.currentCountry)
		this.modelObject.caseF.setLastCountry(this.modelObject.currentCountry)
		this.modelObject.caseF.setCurrentCountry(this.modelObject.nextCountry)
		this.modelObject.caseF.setNextCountry(null)
		this.modelObject.updateList
		this.close
	}
	
}