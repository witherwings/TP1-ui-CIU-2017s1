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
import org.uqbar.arena.layout.HorizontalLayout

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
		this.modelObject.addSign
	}
	
	def deleteSelected() {
		this.modelObject.removeSign
	}
	
	override accept() {
		this.modelObject.accept
		super.accept
	}
	
}