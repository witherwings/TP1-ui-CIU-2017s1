package xtend

import AppModel.EditSignsAppModel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditSignsWindow extends Dialog<EditSignsAppModel> {
	
	TextBox textBox 
	
	new(WindowOwner owner, EditSignsAppModel model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel p) {
		this.title = "Editar Signs"
		new Label(p).text = "Signs: "
		new List<String>(p) => [
            (items <=> "newSigns")
            height = 100
            width = 270
            value <=> "selectedSign"
        ]
        new Button(p) => [
		      caption = "Eliminar"
		      setAsDefault
		      onClick[ | this.deleteSelected ]
		      disableOnError
		]
		this.textBox = new TextBox(p) => [ 
			width = 200
			value <=> "currSign"
		]
        new Button(p) => [
		      caption = "Agregar"
		      setAsDefault
		      onClick[ | this.addFromTextBox ]
		      disableOnError
		]
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
	
	def addFromTextBox() {
		this.model.getSource.addSign
	}
	
	def deleteSelected() {
		this.model.getSource.removeSign
	}
	
	override accept() {
		this.model.getSource.accept
		super.accept
	}
	
}