package xtend

import AppModel.CaseFilesAppModel
import Components.Title
import WorldMap.Country
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class SolvingMysteryWindow extends Dialog<CaseFilesAppModel> {

	new(WindowOwner owner, CaseFilesAppModel model) {
		super(owner, model)
		title = "Resolviendo: " + modelObject.caseF.caseName
	}

	override protected createFormPanel(Panel mainPanel) {
		val main = new Panel(mainPanel)
		main.layout = new VerticalLayout

		val columnPanel = new Panel(main)
		columnPanel.layout = new ColumnLayout(2)

		val leftColumn = new Panel(columnPanel)

		val locationPanel = new Panel(leftColumn)
		locationPanel.layout = new ColumnLayout(2)
		new Label(locationPanel).text = "Estas en: "
		new Label(locationPanel).bindValueToProperty("currentCountry.name")

		new Button(leftColumn)
			.setCaption("Orden de Arresto")
			.onClick[ | this.getWarrantWindow]
		new Label(leftColumn).bindValueToProperty("caseF.archives.warrant")
		new Button(leftColumn)
			.setCaption("Viajar")
			.onClick[ | this.travelWindow]
		new Button(leftColumn)
			.setCaption("Expedientes")
			.onClick[ | this.openArchives]

		val rigthColumn = new Panel(columnPanel)

		new Label(rigthColumn).text = "Lugares"

		new Button(rigthColumn)
			.onClick[| this.getClue(0)]
			.bindCaptionToProperty("currentCountry.firstPlace.placeName")
		new Button(rigthColumn)
			.onClick[| this.getClue(1)]
			.bindCaptionToProperty("currentCountry.secondPlace.placeName")
		new Button(rigthColumn)
			.onClick[| this.getClue(2)]
			.bindCaptionToProperty("currentCountry.thirdPlace.placeName")

		val panel1 = new Panel(main)
		panel1.layout = new VerticalLayout

		new Label(panel1).text = "Recorrido criminal:"
		new List<Country>(panel1) => [
			(items <=> "caseF.criminalDestinations").adapter = new PropertyAdapter(Country, "name")
			height = 50
			width = 250
		]
		new Label(panel1).text = "Destinos fallidos:"
		new Title(panel1,"Pais")
		new List<Country>(panel1) => [
			(items <=> "caseF.failedDestinations").adapter = new PropertyAdapter(Country, "name")
			height = 50
			width = 250
		]
	}
	
	def getClue(int placeNumber) {
		this.openDialog(new ClueWindow(this, this.modelObject.caseF, placeNumber))
	}
	
	def openArchives() {
		new ArchiveVillainsMysteryWindow(this, this.modelObject.caseF.archives).open
	}
	
	def travelWindow() {
		this.openDialog(new TravelWindow(this, this.modelObject))
	}
	
	def getWarrantWindow() {
		this.openDialog(new WarrantOrderWindow(this, this.modelObject.caseF))
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

}
