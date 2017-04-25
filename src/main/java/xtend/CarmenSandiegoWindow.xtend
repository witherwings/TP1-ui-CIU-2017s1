package xtend

import AppModel.ArchiveVillainsAppModel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.Window
import org.uqbar.arena.windows.WindowOwner
import AppModel.WorldMapAppModel
import AppModel.CaseFilesAppModel

class CarmenSandiegoWindow extends SimpleWindow<CaseFilesAppModel>{
	
	new(WindowOwner parent, CaseFilesAppModel model) {
		super(parent, model)
		title = "¿Donde esta Carmen Sandiego?"
		taskDescription = "¿Que haremos ahora detective?"
	}

    override protected createFormPanel(Panel mainPanel) { /* no queremos usar este template default */ }
    
	override protected addActions(Panel actionsPanel) { 	
		new Button(actionsPanel) 
		.setCaption("Resolver Misterio")
		.onClick [ |this.solveMystery ]
		
		new Button(actionsPanel) 
		.setCaption("Mapamundi")
		.onClick [ |this.openWorldMap]
		
		new Button(actionsPanel) 
		.setCaption("Expedientes")
		.onClick [ |this.openArchiveVillains]
	}
	
	def solveMystery() {
		this.openWindow(new NewGameWindow(this, new CaseFilesAppModel))
	}
	
	def openArchiveVillains() {
		this.openWindow(new ArchiveVillainsWindow(this, new ArchiveVillainsAppModel))
	}
	
	def openWorldMap() {
		this.openWindow(new WorldMapWindow(this, new WorldMapAppModel))
	}
	
	def openWindow(Window<?> window) {
		window.open
	}
}