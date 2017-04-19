package xtend

import Components.Title
import People.Villain
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.ColumnLayout
import AppModel.ArchiveVillainsAppModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*


class ArchiveVillainsWindow extends SimpleWindow<ArchiveVillainsAppModel>{
	
	new(WindowOwner parent, ArchiveVillainsAppModel model) {
		super(parent, model)
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
        new Button(villainLP) =>[
            caption = "Nuevo"
        ]
        new Button(villainLP) =>[
            caption = "Editar"
        ]
	}
	
	def createVillainInfoPanel(Panel panel) {
		val villainIP = new Panel(panel)
		villainIP.layout = new VerticalLayout
		
		val nameP = new Panel(villainIP)
        nameP.layout = new ColumnLayout(2)
        val genderP = new Panel(villainIP)
        genderP.layout = new ColumnLayout(2)
        
        new Label(nameP)=>[
            setText("Nombre: ")
            fontSize = 12
        ]
        new Label(nameP)=>[
            value <=> "selectedVillain.name"
            fontSize = 12
        ]
        new Label(genderP)=>[
            setText("Sexo: ")
            fontSize = 12
        ]
        new Label(genderP)=>[
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
	
}