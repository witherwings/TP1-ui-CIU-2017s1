package xtend

import Game.CaseFile
import WorldMap.Country
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.bindings.PropertyAdapter

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import Components.Title

class SolvingMysteryWindow extends Dialog<CaseFile> {

	new(WindowOwner owner, CaseFile model) {
		super(owner, model)
		title = "Resolviendo: " + modelObject.caseName
	}

	override protected createFormPanel(Panel mainPanel) {
		val main = new Panel(mainPanel)
		main.layout = new VerticalLayout

		val columnPanel = new Panel(main)
		columnPanel.layout = new ColumnLayout(2)

		val leftColumn = new Panel(columnPanel)

		new Label(leftColumn).text = "Estas en: " + modelObject.actualCountry.name

		new Button(leftColumn)
			.setCaption("Orden de Arresto")
			.onClick[ | this.getWarrantWindow]
		new Label(leftColumn).text = modelObject.archives.warrant
		new Button(leftColumn)
			.setCaption("Viajar")
			.onClick[ | this.travelWindow]
		new Button(leftColumn)
			.setCaption("Expedientes")
			.onClick[ | this.openArchives]

		val rigthColumn = new Panel(columnPanel)

		new Label(rigthColumn).text = "Lugares"

		new Button(rigthColumn)
			.setCaption(modelObject.actualCountry.places.get(0).getPlaceName)
			.onClick[| this.getClue(0)]
		new Button(rigthColumn)
			.setCaption(modelObject.actualCountry.places.get(1).getPlaceName)
			.onClick[| this.getClue(1)]
		new Button(rigthColumn)
			.setCaption(modelObject.actualCountry.places.get(2).getPlaceName)
			.onClick[| this.getClue(2)]

		val panel1 = new Panel(main)
		panel1.layout = new VerticalLayout

		new Label(panel1).text = "Recorrido criminal:"
		new Label(panel1).text = ""
		new Label(panel1).text = "Destinos fallidos:"
		new Title(panel1,"Pais")
		new List<Country>(panel1) => [
			(items <=> "failedDestinations").adapter = new PropertyAdapter(Country, "name")
			height = 50
			width = 250
		]
	}
	
	def getClue(int placeNumber) {
		this.openDialog(new ClueWindow(this, this.modelObject, placeNumber))
	}
	
	def openArchives() {
		new ArchiveVillainsMysteryWindow(this, this.modelObject.archives).open
	}
	
	def travelWindow() {
		this.openDialog(new TravelWindow(this, this.modelObject))
	}
	
	def getWarrantWindow() {
		this.openDialog(new WarrantOrderWindow(this, this.modelObject))
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

}
