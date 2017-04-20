package xtend;

import org.uqbar.arena.widgets.Panel;
import org.uqbar.arena.windows.Dialog;
import org.uqbar.arena.windows.WindowOwner;

import AppModel.VillainAppModel;
import org.uqbar.arena.widgets.Label

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.widgets.List

public class EditVillainWindow extends Dialog<VillainAppModel> {
	
	new(WindowOwner owner, VillainAppModel model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel p) {
		this.title = "Editar Villano"
		new Label(p).text = "Nombre: "
		new TextBox(p) => [ value <=> "villain.name"; width = 200; ]
		new Label(p).text = "Sexo: "
		new TextBox(p) => [ value <=> "villain.gender"; width = 200; ]
		new Label(p).text = "Senhas particulares"
		this.createSignsSection(p)
		this.createHobbiesSection(p)
	}
	
	def createSignsSection(Panel owner) {
		new Label(owner).text = "Senhas: "
		new List<String>(owner) => [
            (items <=> "villain.signs")
            height = 100
            width = 270
            value <=> "selectedSign"
        ]
		new Button(owner) => [
		      caption = "Editar senhas particulares"
		      setAsDefault
		      onClick[ | this.openEditSigns  ]
		      disableOnError
		]
	}
	
	def createHobbiesSection(Panel owner) {
		new Label(owner).text = "Hobbies: "
		new List<String>(owner) => [
            (items <=> "villain.hobbies")
            height = 100
            width = 270
            value <=> "selectedHobbie"
        ]
		new Button(owner) => [
		      caption = "Editar hobbies"
		      setAsDefault
		      onClick[ | this.openEditHobbies  ]
		      disableOnError
		]
	}
	
	def openEditHobbies() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def openEditSigns() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
