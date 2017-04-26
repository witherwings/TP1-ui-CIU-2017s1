package xtend

import Game.CaseFile
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Button

class EndGameWindow extends Dialog<CaseFile>{
	
	new(WindowOwner owner, CaseFile model) {
		super(owner, model)
		title = model.caseName
	}
	
	override protected createFormPanel(Panel mainPanel) {
		if(this.modelObject.responsible == this.modelObject.archives.responsible)
			this.victoryPanel(mainPanel)
		else
			this.defeatPanel(mainPanel)
	}
	
	def defeatPanel(Panel panel) {
		val mainP = new Panel(panel)
		
		new Label(mainP).text = "Malas noticias :("
		new Label(mainP).text = "Ha detenido a " + this.modelObject.archives.responsible.name 
			+ " pero usted tenia una orden contra " + this.modelObject.responsible.name
		new Label(mainP).text = "Lamentablemente este crimen quedara impune"
		
		new Button(mainP)
			.setCaption("Aceptar el error cometido")
			.onClick [|this.close]
	}
	
	def victoryPanel(Panel panel) {
		val mainP = new Panel(panel)
		
		new Label(mainP).text = "En Hora Buena!!!"
		new Label(mainP).text = "Ha detenido a " + this.modelObject.responsible.name 
			+ " y recuperado " + this.modelObject.stolenObject
		new Label(mainP).text = "Felicitaciones!!"
		
		new Button(mainP)
			.setCaption("Disfrutar de nuestra victoria")
			.onClick [|this.close]
	}
	
}