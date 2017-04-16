package xtend

import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel

import AppModel.MapamundiAppModel
import WorldMap.Country

import Components.Title

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class MapamundiWindow extends SimpleWindow<MapamundiAppModel> {

    new(WindowOwner parent, MapamundiAppModel model) {
        super(parent, model)
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
            caption = "New Country"
        ]
        new Button(countryListPanel) =>[
            caption = "Edit Country"
        ]
        new Button(countryListPanel) =>[
            caption = "Delete Country"
        ]
    }

    def createCountryInfoPanel(Panel owner) {
        val countryInfoPanel = new Panel(owner)
        countryInfoPanel.layout = new VerticalLayout

        val nombrePanel = new Panel(countryInfoPanel)
        nombrePanel.layout = new ColumnLayout(2)

        new Label(nombrePanel)=>[
            setText("Nombre: ")
            fontSize = 16
        ]
        new Label(nombrePanel)=>[
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
            (items <=> "selectedCountry.connectedCointryNames")
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
}
