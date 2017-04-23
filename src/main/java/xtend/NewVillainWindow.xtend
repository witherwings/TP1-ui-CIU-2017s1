package xtend

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import AppModel.NewVillainAppModel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Button
import AppModel.EditHobbiesAppModel
import AppModel.EditSignsAppModel
import AppModel.ArchiveVillainsAppModel
import People.Villain

class NewVillainWindow extends Dialog<NewVillainAppModel> {
	
	ArchiveVillainsAppModel parentModel
	
	new(WindowOwner owner, NewVillainAppModel model, ArchiveVillainsAppModel parentModel) {
		super(owner, model)
		this.parentModel = parentModel
	}
	
	override protected createFormPanel(Panel p) {
		this.title = "Crear Villano"
		new Label(p).text = "Nombre: "
		new TextBox(p) => [ value <=> "villain.name"; width = 200; ]
		new Label(p).text = "Sexo: "
		new TextBox(p) => [ value <=> "villain.gender"; width = 200; ]
		new Label(p).text = "Senhas particulares"
		this.createSignsSection(p)
		this.createHobbiesSection(p)
		new Button(p) => [
		      caption = "Aceptar"
		      setAsDefault
		      onClick[ | this.accept ]
		      disableOnError
		]
        new Button(p) => [
		      caption = "Cancelar"
		      setAsDefault
		      onClick[ | this.cancel ]
		      disableOnError
		]
	}	
	
	def void createSignsSection(Panel owner) {
		new Label(owner).text = "Senhas: "
		new List<String>(owner) => [
            (items <=> "villain.signs")
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
            (items <=> "villain.hobbies")
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
		new EditHobbiesWindow(this, new EditHobbiesAppModel(this.model.getSource.villain)).open
	}
	
	def openEditSigns() {
		new EditSignsWindow(this, new EditSignsAppModel(this.model.getSource.villain)).open 
	}
	
	override accept() {
		this.parentModel.addVillain(this.model.getSource.villain)
		super.accept()
	}
	
}