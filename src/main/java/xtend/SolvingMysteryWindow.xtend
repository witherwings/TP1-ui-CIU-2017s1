package xtend

import org.uqbar.arena.windows.Dialog
import Game.CaseFile
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.List
import WorldMap.Country

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

		new Label(leftColumn).text = "Estas en: " + modelObject.robberyCountry.name

		new Button(leftColumn).setCaption("Orden de Arresto").onClick[|]
		new Button(leftColumn).setCaption("Viajar").onClick[|]
		new Button(leftColumn).setCaption("Expedientes").onClick[|]

		val rigthColumn = new Panel(columnPanel)

		new Label(rigthColumn).text = "Lugares"

		new Button(rigthColumn).setCaption(modelObject.robberyCountry.places.get(0).getPlaceName).onClick[|]
		new Button(rigthColumn).setCaption(modelObject.robberyCountry.places.get(1).getPlaceName).onClick[|]
		new Button(rigthColumn).setCaption(modelObject.robberyCountry.places.get(2).getPlaceName).onClick[|]

		val panel1 = new Panel(main)
		panel1.layout = new VerticalLayout

		new Label(panel1).text = "Recorrido criminal:"
		new Label(panel1).text = ""
		new Label(panel1).text = "Destinos fallidos:"
		new List<Country>(panel1) => [
			height = 50
			width = 250
		]
	}

}
