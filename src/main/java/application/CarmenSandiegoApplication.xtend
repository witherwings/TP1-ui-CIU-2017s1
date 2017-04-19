package application

import AppModel.CaseFileAppModel
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import xtend.CarmenSandiegoWindow

class CarmenSandiegoApplication extends Application{

	static def void main(String[] args) { 
		new CarmenSandiegoApplication().start()
	}

	override protected Window<?> createMainWindow() {
		return new CarmenSandiegoWindow(this, new CaseFileAppModel)
	}
	
}
	