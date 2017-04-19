package xtend

import Components.Title
import WorldMap.Country
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import AppModel.CountryAppModel
import java.util.ArrayList

abstract class EditNewCountryWindow extends Dialog<CountryAppModel>{
	
	new(WindowOwner owner, CountryAppModel model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val panel = new Panel(mainPanel)
		this.addFormPanel(panel)
		new Button(panel) //
			.setCaption("Eliminar")
			.onClick [ | ]
			
		val panel2 = new Panel(mainPanel)
		panel2.layout = new ColumnLayout(2)
		this.addFormPanel2(panel2)
		
		new Button(mainPanel)
			.setCaption("Aceptar")
			.onClick [ | this.accept ]
			.setAsDefault
			.disableOnError
	}
	abstract def void addFormPanel(Panel panel)
	abstract def void addFormPanel2(Panel panel)
}

class EditFeaturesFromCountryWindow extends EditNewCountryWindow {
	
	new(WindowOwner owner, CountryAppModel model) {
		super(owner, model)
		this.title = "Editar Caracteristicas"
	}
	
	override addFormPanel(Panel panel) {
		val featuresP = new Panel(panel)
		new Title(featuresP, "Caracteristicas")
        new List<String>(featuresP) => [
            (items <=> "country.features")
            height = 50
            width = 250
        ]
	}
	
	override addFormPanel2(Panel panel) {
		val featuresP2 = new Panel(panel)
		new TextBox(featuresP2).value <=> "newFeature"
		new Button(featuresP2)
			.setCaption("Agregar")
			.onClick [ | this.addNewFeature ]
	}

	def void addNewFeature(){
		this.modelObject.getCountry.addFeature(this.modelObject.getNewFeature)
	}
	
}