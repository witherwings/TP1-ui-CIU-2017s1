package application

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import xtend.CarmenSanDiegoWindow
import Game.CaseFile
import AppModel.CaseFileAppModel

class CarmenSanDiegoApplication extends Application{

	static def void main(String[] args) { 
		new CarmenSanDiegoApplication().start()
	}

	override protected Window<?> createMainWindow() {
		return new CarmenSanDiegoWindow(this, new CaseFileAppModel)
	}
	
}
	