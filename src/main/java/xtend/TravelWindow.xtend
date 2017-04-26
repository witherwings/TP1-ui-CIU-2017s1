package xtend

import Game.CaseFile
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import WorldMap.Country
import org.uqbar.arena.bindings.PropertyAdapter

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button

class TravelWindow extends Dialog<CaseFile> {
	
	new(WindowOwner owner, CaseFile model) {
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
			value <=> "nextCountry"
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
		this.modelObject.addfailedDestination(this.modelObject.currentCountry)
		this.modelObject.currentCountry = this.modelObject.lastCountry
		this.modelObject.lastCountry = null
		this.modelObject.nextCountry = null
		this.close
	}
	
	def travelToSelectedCountry() {
		this.modelObject.addSuccesfulDestination(this.modelObject.currentCountry)
		this.modelObject.lastCountry = this.modelObject.currentCountry
		this.modelObject.currentCountry = this.modelObject.nextCountry
		this.modelObject.nextCountry = null
		this.close
	}
	
}