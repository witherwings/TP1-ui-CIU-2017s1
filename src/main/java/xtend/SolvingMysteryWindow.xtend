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

class SolvingMysteryWindow extends Dialog<CaseFile>{
	
	new(WindowOwner owner, CaseFile model) {
		super(owner, model)
		title = "Resolviendo: " + modelObject.caseName
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val main = new Panel(mainPanel)
		main.layout = new VerticalLayout
		
		val panel1 = new Panel(main)
		panel1.layout = new ColumnLayout(2)
		new Label(panel1).text = "Estas en: " + modelObject.robberyCountry.name
		new Button(panel1)
			.setCaption("Orden de Arresto")
			.onClick[|]
		new Button(panel1)
			.setCaption("Viajar")
			.onClick[|]
		new Button(panel1)
			.setCaption("Expedientes")
			.onClick[|]
		new Label(panel1).text = "Lugares"
		new Button(panel1)
			.setCaption(modelObject.robberyCountry.places.get(0).getPlaceName)
			.onClick[|]
		new Button(panel1)
			.setCaption(modelObject.robberyCountry.places.get(1).getPlaceName)
			.onClick[|]
		new Button(panel1)
			.setCaption(modelObject.robberyCountry.places.get(2).getPlaceName)
			.onClick[|]
			
		val panel2 = new Panel(main)
		panel2.layout = new VerticalLayout
		
		new Label(panel2).text = "Recorrido criminal:"
		new Label(panel2).text = ""
		new Label(panel2).text = "Destinos fallidos:"
		new List<Country>(panel2) =>[
			height = 50
            width = 250
		]
		
	}
	
}