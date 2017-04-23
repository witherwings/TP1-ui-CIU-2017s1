package xtend

import Components.Title
import WorldMap.Country
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import AppModel.WorldMapAppModel

class WorldMapWindow extends SimpleWindow<WorldMapAppModel> {

    new(WindowOwner parent, WorldMapAppModel model) {
        super(parent, model)
        modelObject.updateList
    }

    override protected addActions(Panel actionsPanel) { /* no queremos usar este template default*/ }
    override protected createFormPanel(Panel mainPanel) { /* no queremos usar este template default */ }

    override createMainTemplate(Panel mainPanel) {
        this.title = "Mapamundi"
        mainPanel.layout = new VerticalLayout

        // contenido:
        val contentPanel = new Panel(mainPanel)
        contentPanel.layout = new ColumnLayout(2)
        this.createCountryListPanel(contentPanel)
        this.createCountryInfoPanel(contentPanel)
    }

    def createCountryListPanel(Panel owner) {
        val countryListPanel = new Panel(owner)

        new Title(countryListPanel, "Paises")
        new List<Country>(countryListPanel) => [
            (items <=> "countries").adapter = new PropertyAdapter(Country, "name")
            height = 150
            width = 270
            value <=> "selectedCountry"
        ]
        new Button(countryListPanel) =>[
            setCaption("Nuevo")
            .onClick [ |this.newCountry ]
        ]
        new Button(countryListPanel) =>[
            setCaption("Editar")
            .onClick [ | this.editCountry]
        ]
        new Button(countryListPanel) =>[
            setCaption("Eliminar")
            .onClick [ | this.deleteCountry]
        ]
    }
	
    def createCountryInfoPanel(Panel owner) {
        val countryInfoPanel = new Panel(owner)
        countryInfoPanel.layout = new VerticalLayout

        val nombrePanel = new Panel(countryInfoPanel)
        nombrePanel.layout = new HorizontalLayout()

        new Label(countryInfoPanel)=>[
            setText("Nombre: ")
            fontSize = 16
        ]
        new Label(countryInfoPanel)=>[
            value <=> "selectedCountry.name"
            fontSize = 16
        ]
        new Label(countryInfoPanel)=>[
            setText("Caracteristicas: ")
        ]
        new List<Country>(countryInfoPanel) => [
            (items <=> "selectedCountry.features")
            width = 270
        ]
        new Label(countryInfoPanel)=>[
            setText("Conexiones: ")
        ]
        new List<Country>(countryInfoPanel) => [
            (items <=> "selectedCountry.connectedCountryNames")
            width = 270
        ]
        new Label(countryInfoPanel)=>[
            setText("Lugares: ")
        ]
        new List<Country>(countryInfoPanel) => [
            (items <=> "selectedCountry.placesNames")
            width = 270
        ]
    }
    
    def deleteCountry() {
		this.openDialog(new DeleteCountry(this, this.modelObject.selectedCountry, this.modelObject))
	}
    
    def editCountry() {
		this.openDialog(new EditCountry(this, this.modelObject.selectedCountry, this.modelObject))
	}
    	
	def newCountry() {
		this.openDialog(new AddNewCountryWindow(this, new Country(modelObject.getWorldMap), this.modelObject))
	}
    
    def openDialog(Dialog<?> dialog) {
		dialog.open
	}
}
