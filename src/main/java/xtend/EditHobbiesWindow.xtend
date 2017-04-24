package xtend

import AppModel.EditHobbiesAppModel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.layout.HorizontalLayout

class EditHobbiesWindow extends Dialog<EditHobbiesAppModel> {
	
	TextBox textBox
	
	new(WindowOwner owner, EditHobbiesAppModel model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel p) {
		this.title = "Editar Hobbies"
		new Label(p).text = "Hobbies: "
		new List<String>(p) => [
            (items <=> "newHobbies")
            height = 100
            width = 270
            value <=> "selectedHobbie"
        ]
        new Button(p) => [
		      caption = "Eliminar"
		      setAsDefault
		      onClick[ | this.deleteSelected ]
		      disableOnError
		]
		this.textBox = new TextBox(p) => [ 
			width = 200
			value <=> "currHobbie"
		]
        new Button(p) => [
		      caption = "Agregar"
		      setAsDefault
		      onClick[ | this.addFromTextBox ]
		      disableOnError
		]
		
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
	
	def addFromTextBox() {
		this.model.getSource.addHobbie
	}
	
	def deleteSelected() {
		this.model.getSource.removeHobbie
	}
	
	override accept() {
		this.model.getSource.accept
		super.accept
	}
	
}