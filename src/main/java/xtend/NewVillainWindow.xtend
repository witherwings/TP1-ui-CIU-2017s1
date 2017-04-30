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
import org.uqbar.commons.model.UserException

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
		new Label(p).text = "Señas particulares"
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
		new Label(owner).text = "Señas: "
		new List<String>(owner) => [
            (items <=> "signs")
            height = 100
            width = 270
        ]
		new Button(owner) => [
		      caption = "Editar señas particulares"
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
		this.validate()
		this.parentModel.addVillain(this.modelObject)
		this.parentModel.updateList()
		super.accept()
	}
	
	def validate() {
		if(this.modelObject.name == null){
			throw new UserException("El nombre no puede ser nulo")
		}
		if(this.modelObject.gender == null){
			throw new UserException("El genero no puede ser nulo")
		}
		if(this.modelObject.gender != "Masculino" && this.modelObject.gender != "Femenino"){
			throw new UserException("Genero incorrecto. Seleccione entre 'Masculino' y 'Femenino'")
		}
	}
	
}

public class EditVillainWindow extends NewVillainWindow{
	
	
	new(WindowOwner owner, Villain model, ArchiveVillainsAppModel parentModel) {
		super(owner, model, parentModel)
		this.title = "Expedientes - Editar Villano"
	}
	
	override accept(){
		var archive = owner as ArchiveVillainsWindow
		archive.updateList
		this.close
	}
}