package xtend

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Button
import AppModel.EditHobbiesAppModel
import AppModel.EditSignsAppModel
import AppModel.ArchiveVillainsAppModel
import People.Villain
import org.uqbar.arena.layout.HorizontalLayout

class NewVillainWindow extends Dialog<Villain> {
	
	ArchiveVillainsAppModel parentModel
	
	new(WindowOwner owner, Villain model, ArchiveVillainsAppModel parentModel) {
		super(owner, model)
		this.parentModel = parentModel
		this.title = "Expedientes - Crear Villano"
	}
	
	override protected createFormPanel(Panel p) {
		new Label(p).text = "Nombre: "
		new TextBox(p) => [ value <=> "name"; width = 200; ]
		new Label(p).text = "Sexo: "
		new TextBox(p) => [ value <=> "gender"; width = 200; ]
		new Label(p).text = "Senhas particulares"
		this.createSignsSection(p)
		this.createHobbiesSection(p)
		
		val buttonPanel = new Panel(p)
		buttonPanel.layout = new HorizontalLayout
		new Button(buttonPanel) => [
		      caption = "Aceptar"
		      setAsDefault
		      onClick[ | this.accept ]
		      disableOnError
		]
        new Button(buttonPanel) => [
		      caption = "Cancelar"
		      setAsDefault
		      onClick[ | this.cancel ]
		      disableOnError
		]
	}	
	
	def void createSignsSection(Panel owner) {
		new Label(owner).text = "Senhas: "
		new List<String>(owner) => [
            (items <=> "signs")
            height = 100
            width = 270
        ]
		new Button(owner) => [
		      caption = "Editar senhas particulares"
		      setAsDefault
		      onClick[ | this.openEditSigns  ]
		      disableOnError
		]
	}
	
	def void createHobbiesSection(Panel owner) {
		new Label(owner).text = "Hobbies: "
		new List<String>(owner) => [
            (items <=> "hobbies")
            height = 100
            width = 270
        ]
		new Button(owner) => [
		      caption = "Editar hobbies"
		      setAsDefault
		      onClick[ | this.openEditHobbies  ]
		      disableOnError
		]
	}
	
	def openEditHobbies() {
		new EditHobbiesWindow(this, new EditHobbiesAppModel(this.modelObject)).open
	}
	
	def openEditSigns() {
		new EditSignsWindow(this, new EditSignsAppModel(this.modelObject)).open
	}
	
	override accept() {
		this.parentModel.addVillain(this.modelObject)
		super.accept()
	}
	
}

public class EditVillainWindow extends NewVillainWindow{
	
	new(WindowOwner owner, Villain model, ArchiveVillainsAppModel parentModel) {
		super(owner, model, parentModel)
		this.title = "Expedientes - Editar Villano"
	}
	
	override accept(){
		this.close
	}
}