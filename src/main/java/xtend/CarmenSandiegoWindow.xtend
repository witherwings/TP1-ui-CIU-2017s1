package xtend

import AppModel.ArchiveVillainsAppModel
import AppModel.CaseFileAppModel
import AppModel.MapamundiAppModel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.Window
import org.uqbar.arena.windows.WindowOwner

class CarmenSandiegoWindow extends SimpleWindow<CaseFileAppModel>{
	
	new(WindowOwner parent, CaseFileAppModel model) {
		super(parent, model)
		title = "¿Donde esta Carmen Sandiego?"
		taskDescription = "¿Que haremos ahora detective?"
	}

    override protected createFormPanel(Panel mainPanel) { /* no queremos usar este template default */ }
    
	override protected addActions(Panel actionsPanel) { 	
		new Button(actionsPanel) 
		.setCaption("Resolver Misterio")
		.onClick [ | ]
		
		new Button(actionsPanel) 
		.setCaption("Mapamundi")
		.onClick [ |this.openWorldMap]
		
		new Button(actionsPanel) 
		.setCaption("Expedientes")
		.onClick [ |this.openArchiveVillains]
	}
	
	def openArchiveVillains() {
		this.openWindow(new ArchiveVillainsWindow(this, new ArchiveVillainsAppModel))
	}
	
	def openWorldMap() {
		this.openWindow(new MapamundiWindow(this, new MapamundiAppModel))
	}
	
	def openWindow(Window<?> window) {
		window.open
	}
}