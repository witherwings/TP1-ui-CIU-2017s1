package xtend

import AppModel.CaseFileAppModel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.windows.Dialog

class CarmenSanDiegoWindow extends SimpleWindow<CaseFileAppModel>{
	
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
		.onClick [ | ]
		
		new Button(actionsPanel) 
		.setCaption("Expedientes")
		.onClick [ | ]
	}
}