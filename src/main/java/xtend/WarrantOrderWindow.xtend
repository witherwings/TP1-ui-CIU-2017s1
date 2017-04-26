package xtend

import Game.CaseFile
import People.Villain
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button

class WarrantOrderWindow extends Dialog<CaseFile>{
	
	
	new(WindowOwner owner, CaseFile model) {
		super(owner, model)
		title = "Resolviendo: " + model.caseName
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val mainP = new Panel(mainPanel)
		mainP.layout = new VerticalLayout
		this.modelObject.archives.selectedVillain = this.modelObject.archives.villains.get(0)
		
		new Label(mainP).text = "Orden de arresto emitida contra: " + this.modelObject.archives.selectedVillain.name
		new Selector<Villain>(mainP) => [
			allowNull = false
			val itemsProperty = items <=> "archives.villains"
			itemsProperty.adapter = 
			    new PropertyAdapter(Villain, "name")
			value <=> "archives.selectedVillain"
		]
		new Button(mainP)
			.setCaption("Generar Orden de Arresto")
			.onClick [ | this.accept]
	}
	
	override accept(){
		this.modelObject.archives.warrant = "Orden ya emitida: " + this.modelObject.archives.selectedVillain.name
		this.modelObject.archives.setResponsible(this.modelObject.archives.selectedVillain)
		this.close
	}
	
}