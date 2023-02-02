# This Python file uses the following encoding: utf-8
import sys, os
from pathlib import Path
import pandas as pd

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterSingletonType
from PySide6.QtCore import QObject, Slot, Signal, Property, QSortFilterProxyModel, Qt

from python import refresh, model_control, load, optimisation

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    update = Signal(float)
    @Slot(float, float, float, float)
    def updateParameters (self, force, velocity, blankthickness, temperature):

        manufacturbility = refresh.manufacturbility(force, velocity, blankthickness, temperature)
        refresh.field(force, velocity, blankthickness, temperature)

        self.update.emit(manufacturbility)


    @Slot(str)
    def changeResultType (self, str):
        model_control.load(str)


    # bestruntable = Signal(QAbstractTableModel)
    # @Slot()
    # def updateBestruntable (self):
    #     print("button pressed")
    #     tablemodel = refresh.bestruntable()

    #     self.bestruntable.emit(tablemodel)


    @Slot(str, str)
    def loadPredictionMesh (self, die, edge):
        load.predictionmesh(die, edge)


    @Slot(str, str)
    def setMaterialandProcess (self, material, process):
        model_control.selectMaterialandProcess(material, process)




    @Property(list, constant=True)
    def load_optivaropts (self):
        return optimisation.load_optivars()


    change_optivars = Signal()
    @Slot(str)
    def pick_optivar (self, str):
        optimisation.pick_option(str)
        self.change_optivars.emit()


    @Slot(str)
    def unpick_optivar (self, str):
        optimisation.unpick_option(str)
        self.change_optivars.emit()


    @Slot(str, str, str, str, str, int, str, int)
    def set_optiopts (self, material, process, model, goal, aim, setto, search, runsno):
        optimisation.set_options(material, process, model, goal, aim, setto, search, runsno)


    @Property(list, notify=change_optivars)
    def picked_optivars (self):
        return optimisation.picked_optivars()
    

    @Slot(str, int, result=list)
    def get_optivar_units (self, str, idx):
        return optimisation.get_units(str, idx)
    

    @Slot(str, int, int, str)
    def setvarbounds (self, var, lower, upper, unit):
        optimisation.set_bounds(var, lower, upper, unit)
    

    @Slot()
    def start_optimisation (self):
        optimisation.start()


    @Slot(result=list)
    def optimisation_progress (self):
        return optimisation.get_progress()
    

    @Property(list, constant=True)
    # @Slot(result=list)
    def getbestrun (self):
        # return [["var1","10%"],["var2","20%"]]
        return optimisation.getbestrun()
    

    @Slot()
    def stop_optimisation (self):
        optimisation.stop()


    @Property(list ,constant=True)
    def get_final_bestrun (self):
        # return [["var1","var2"],["value1","value2"]]
        return optimisation.getbestrun_final()
    

    @Property(list, constant=True)
    def get_final_vars (self):
        return optimisation.get_final_vars()


    # optiresults_requested = Signal()

    @Slot(str, result=list)
    def sort_optiresults_table (self, var):
        print("sort by ", var)
        return [[var,"var2"],[var,"value2"],[var,"value4"]]




    @Property(list, constant=True)
    def load_independentvars (self):
        return load.independentvars()
    

    @Property(list, constant=True)
    def load_dependentvars (self):
        return load.dependentvars()




if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    model = optimisation.BestRunTable(pd.read_csv(os.path.join("temp","optimisation_result.csv")))

    proxyModel = QSortFilterProxyModel()
    proxyModel.setSourceModel(model)
    # proxyModel.setSortingEnabled(True)
    # proxyModel.sort(2, Qt.AscendingOrder)

    # model.setSortingEnabled(True)
    engine.rootContext().setContextProperty("bestruntable_model", proxyModel)

    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
