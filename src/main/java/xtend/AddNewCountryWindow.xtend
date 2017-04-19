package xtend

import WorldMap.Country
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import Components.Title
import org.uqbar.arena.widgets.List
import org.uqbar.arena.bindings.PropertyAdapter
import AppModel.MapamundiAppModel
import AppModel.CountryAppModel
import WorldMap.CommonPlace

//Revisar el tema de agregar una base de datos de paises

class AddNewCountryWindow extends Dialog<Country> {
	
	MapamundiAppModel mapModel
	
	new(WindowOwner owner, Country model, MapamundiAppModel mapModel) {
		super(owner, model)
		this.mapModel = mapModel
		title = "Mapamundi - Nuevo Pais"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val newCountryP1 = new Panel(mainPanel)
		newCountryP1.layout = new ColumnLayout(2)
		
		new Label(newCountryP1).text = "Nombre"
		new TextBox(newCountryP1).value <=> "name"

		new Label(newCountryP1).text = "Caracteristicas"
		new Button(newCountryP1)
			.setCaption("Editar caracteristicas")
			.onClick[|this.editFeatures]
		
		val newCountryP2 = new Panel(mainPanel)
		new Title(newCountryP2, "Caracteristicas")
        new List<String>(newCountryP2) => [
            (items <=> "features")
            height = 50
            width = 250
        ]
        
       	val newCountryP3 = new Panel(mainPanel)
		newCountryP3.layout = new ColumnLayout(2) 
		new Label(newCountryP3).text = "Conexiones"
		new Button(newCountryP3)
			.setCaption("Editar conexiones")
		
		val newCountryP4 = new Panel(mainPanel)
		new Title(newCountryP4, "Conexiones")
        new List<Country>(newCountryP4) => [
            (items <=> "connectedCountries").adapter = new PropertyAdapter(Country, "name")
            height = 50
            width = 250
        ]
       
       	val newCountryP5 = new Panel(mainPanel)
		newCountryP5.layout = new ColumnLayout(2) 
		new Label(newCountryP5).text = "Lugares de Interes"
		new Button(newCountryP5)
			.setCaption("Editar lugares")
		
		val newCountryP6 = new Panel(mainPanel)
		new Title(newCountryP6, "Lugares de Interes")
        new List<CommonPlace>(newCountryP6) => [
            (items <=> "places").adapter = new PropertyAdapter(CommonPlace, "placeName")
            height = 50
            width = 250
        ]
	}
	
	def editFeatures() {
		this.openDialog(new EditFeaturesFromCountryWindow(this, new CountryAppModel(this.modelObject)))
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
	
	override protected void addActions(Panel actions) {
		new Button(actions)
			.setCaption("Aceptar")
			.onClick [ | this.accept ]
			.setAsDefault
			.disableOnError

		new Button(actions)
			.setCaption("Cancelar")
			.onClick[|this.cancel]
	}
	
	override accept(){
		this.mapModel.addCountry(this.getModel.getSource)
		super.accept
	}

}