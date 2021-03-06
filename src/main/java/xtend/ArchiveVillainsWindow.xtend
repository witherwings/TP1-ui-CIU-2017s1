package xtend

import AppModel.ArchiveVillainsAppModel
import Components.Title
import People.Villain
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class ArchiveVillainsWindow extends SimpleWindow<ArchiveVillainsAppModel> {
	
	new(WindowOwner parent, ArchiveVillainsAppModel model) {
		super(parent, model)
		modelObject.updateList
	}
	
	override protected addActions(Panel actionsPanel) { /* no queremos usar este template default*/ }
    override protected createFormPanel(Panel mainPanel) { /* no queremos usar este template default */ }
    
    override createMainTemplate(Panel mainPanel){
    	this.title = "Expedientes"
    	mainPanel.layout = new VerticalLayout
    	
    	val contentPanel = new Panel(mainPanel)
        contentPanel.layout = new ColumnLayout(2)
        this.createVillainListPanel(contentPanel)
        this.createVillainInfoPanel(contentPanel)
    }
	
	def createVillainListPanel(Panel panel) {
		val villainLP = new Panel(panel)
		
		new Title(villainLP, "Villanos")
		new List<Villain>(villainLP) => [
            (items <=> "villains").adapter = new PropertyAdapter(Villain, "name")
            height = 150
            width = 270
            value <=> "selectedVillain"
        ]
        
        this.addLastPanel(villainLP)
        
	}
	
	def addLastPanel(Panel panel) {
		new Button(panel) =>[
            caption = "Nuevo"
			onClick [ | this.openNewVillainWindow ]
        ]
        new Button(panel) =>[
            caption = "Editar"
            onClick [ | this.openEditVillainWindow ]
        ]
	}
	
	def openEditVillainWindow() {
		new EditVillainWindow(this, this.modelObject.selectedVillain, this.modelObject).open
	}
	
	def openNewVillainWindow() {
		new NewVillainWindow(this, new Villain, this.modelObject).open 
	}
	
	def createVillainInfoPanel(Panel panel) {
		val villainIP = new Panel(panel)
		villainIP.layout = new VerticalLayout
		
		val nameP = new Panel(villainIP)
        nameP.layout = new ColumnLayout(2)
        val genderP = new Panel(villainIP)
        genderP.layout = new ColumnLayout(2)
        
        new Label(villainIP)=>[
            setText("Nombre: ")
            fontSize = 12
        ]
        new Label(villainIP)=>[
            value <=> "selectedVillain.name"
            fontSize = 12
        ]
        new Label(villainIP)=>[
            setText("Sexo: ")
            fontSize = 12
        ]
        new Label(villainIP)=>[
            value <=> "selectedVillain.gender"
            fontSize = 12
        ]
        
        new Label(villainIP)=>[
            setText("Señas Particulares: ")
        ]
        new List<Villain>(villainIP) => [
            (items <=> "selectedVillain.signsInfo")
            width = 270
        ]
        
        new Label(villainIP)=>[
            setText("Hobbies: ")
        ]
        new List<Villain>(villainIP) => [
            (items <=> "selectedVillain.hobbiesInfo")
            width = 270
        ]
	}
	
	def updateList(){
		this.modelObject.updateList
	}
	
}


class ArchiveVillainsMysteryWindow extends ArchiveVillainsWindow{
	
	new(WindowOwner parent, ArchiveVillainsAppModel model) {
		super(parent, model)
	}
	
	override addLastPanel(Panel panel){}
	
}