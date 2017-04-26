package xtend

import AppModel.CountryAppModel
import Components.Title
import WorldMap.Country
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import WorldMap.CommonPlace

abstract class EditNewCountryWindow extends Dialog<CountryAppModel>{
	
	new(WindowOwner owner, CountryAppModel model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val panel = new Panel(mainPanel)
		this.addFormPanel(panel)
			
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
            value <=> "selectedFeature"
        ]
        
        new Button(panel) 
			.setCaption("Eliminar")
			.onClick [ | this.removeFeature(this.modelObject.selectedFeature)]
	}
	
	override addFormPanel2(Panel panel) {
		val featuresP2 = new Panel(panel)
		new TextBox(featuresP2).value <=> "newFeature"
		new Button(featuresP2)
			.setCaption("Agregar")
			.onClick [ | this.addNewFeature ]
	}
	
	def void removeFeature(String string) {
		this.modelObject.getCountry.removeSelectedFeature(string)
	}

	def void addNewFeature(){
		this.modelObject.getCountry.addFeature(this.modelObject.getNewFeature)
	}
	
}

class EditConnectionsFromCountryWindow extends EditNewCountryWindow{
		
	new(WindowOwner owner, CountryAppModel model) {
		super(owner, model)
		this.title = "Editar Conexiones"
	}
	
	override addFormPanel(Panel panel) {
		val featuresP = new Panel(panel)
		new Title(featuresP, "Conexiones")
        new List<String>(featuresP) => [
            (items <=> "country.connectedCountries").adapter = new PropertyAdapter(Country, "name")
            height = 50
            width = 250
            value <=> "selectedConnection"
        ]
        
         new Button(panel) 
			.setCaption("Eliminar")
			.onClick [ | this.removeConnection(this.modelObject.selectedConnection)]
	}
	
	override addFormPanel2(Panel panel) {
		val featuresP2 = new Panel(panel)
		new Selector<Country>(featuresP2) => [
			allowNull = false
			val itemsProperty = items <=> "country.map.countries"
			itemsProperty.adapter = 
			    new PropertyAdapter(Country, "name")
			value <=> "newConnection"
		]
		new Button(featuresP2)
			.setCaption("Agregar")
			.onClick [ | this.addNewConnection ]
	}
	
	def removeConnection(Country country) {
		this.modelObject.getCountry.removeSelectedConnection(country)
	}
	
	def addNewConnection() {
		this.modelObject.getCountry.addCountry(this.modelObject.getNewConnection)
	}	
}

class EditPlacesFromCountryWindow extends EditNewCountryWindow{
	
	new(WindowOwner owner, CountryAppModel model) {
		super(owner, model)
		this.title = "Editar Lugares"
	}
	
	override addFormPanel(Panel panel) {
		val featuresP = new Panel(panel)
		new Title(featuresP, "Lugares de Interes")
        new List<String>(featuresP) => [
            (items <=> "country.places").adapter = new PropertyAdapter(CommonPlace, "placeName")
            height = 50
            width = 250
            value <=> "selectedPlace"
        ]
        
         new Button(panel) 
			.setCaption("Eliminar")
			.onClick [ | this.removePlace(this.modelObject.selectedPlace)]
	}
	
	override addFormPanel2(Panel panel) {
		val featuresP2 = new Panel(panel)
		new Selector<CommonPlace>(featuresP2) => [
			allowNull = false
			val itemsProperty = items <=> "places"
			itemsProperty.adapter = 
			    new PropertyAdapter(CommonPlace, "placeName")
			value <=> "selectedPlace"
		]
		new Button(featuresP2)
			.setCaption("Agregar")
			.onClick [ | this.addNewPlace ]
	}
	
	def removePlace(CommonPlace place) {
		this.modelObject.getCountry.removeSelectedPlace(this.modelObject.getSelectedPlace)
	}
	
	def addNewPlace() {
		this.modelObject.getCountry.addPlace(this.modelObject.getSelectedPlace)
	}		
}
