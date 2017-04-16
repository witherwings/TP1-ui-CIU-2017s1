package application

import org.uqbar.arena.Application
import AppModel.MapamundiAppModel
import xtend.MapamundiWindow

class MapamundiApplication extends Application{

    override protected createMainWindow() {
        val model = new MapamundiAppModel()
        new MapamundiWindow(this, model)
    }

    def static void main(String[] args) {
        new MapamundiApplication().start()
    }
}
