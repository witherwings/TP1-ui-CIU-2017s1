package xtend

import AppModel.CaseFilesAppModel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.windows.Dialog
import Game.CaseFile

class NewGameWindow extends SimpleWindow<CaseFilesAppModel> {

	new(WindowOwner parent, CaseFilesAppModel model) {
		super(parent, model)
		modelObject.initializeCaseFiles
	}

	override protected addActions(Panel actionsPanel) { /* no queremos usar este template default*/ }

	override protected createFormPanel(Panel mainPanel) { /* no queremos usar este template default */ }

	override createMainTemplate(Panel mainP) {
		this.title = this.modelObject.caseF.caseName
		mainP.layout = new VerticalLayout

		val topPanel = new Panel(mainP)
		new Label(topPanel).text = "Detective, tenemos un caso para usted!"

		val textPanel = new Panel(mainP)
		textPanel.layout = new VerticalLayout
		new Label(textPanel).text = this.modelObject.caseF.report
		new Button(textPanel)
			.setCaption("Aceptar el caso")
			.onClick[ |this.solvingCase]
			.setAsDefault.disableOnError

	}

	def solvingCase() {
		this.openDialog(new SolvingMysteryWindow(this, this.modelObject))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

}
