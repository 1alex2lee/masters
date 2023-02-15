# This Python file uses the following encoding: utf-8
import sys, os
from pathlib import Path
import pandas as pd

from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterSingletonType
from PySide6.QtCore import QObject, Slot, Signal, Property, QSortFilterProxyModel, QUrl
from PySide6.QtQuick import QQuickWindow, QSGRendererInterface, QQuickView


from python import die, model_control, load, optimisation, prediction


class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)


    load_pred_mesh_progress = Signal(str, float)
    load_pred_mesh_complete = Signal(str)
    @Slot(str, str, str)
    def loadPredictionMesh (self, die, edge, blank):
        load.predictionmesh(die, edge, blank, self)


    @Slot(result=bool)
    def is_blank_loaded (self):
        return die.is_blank_loaded()


    @Slot(result=list)
    def load_materials (self):
        return load.materials()
    

    @Slot(result=list)
    def load_processes (self):
        return load.processes()
    

    @Slot(result=list)
    def load_modeltypes (self):
        return load.modeltypes()


    @Slot(str, str)
    def setMaterialandProcess (self, material, process):
        load.select_materialandprocess(material, process)




    @Slot(result=list)
    def get_pred_inputs (self):
        return load.process_inputs()
    

    @Slot(str, result=str)
    def get_pred_parameter_units (self, parameter):
        return load.process_input_units(parameter)
    

    @Slot(str, result=float)
    def get_pred_parameter_lowerbound (self, parameter):
        return load.process_input_lowerbound(parameter)
    

    @Slot(str, result=float)
    def get_pred_parameter_upperbound (self, parameter):
        return load.process_input_upperbound(parameter)
    

    @Slot(str, result=int)
    def get_pred_parameter_decimals (self, parameter):
        return load.process_input_decimals(parameter)
    

    @Slot(str, result=list)
    def get_pred_metrics (self, str):
        # return prediction.metrics(str)
        return load.process_outputs(str)
    

    # @Slot(str, result=str)
    # def get_pred_result (self, str):
    #     return prediction.update_result(str)


    pred_updated = Signal()
    @Slot(int, str)
    def send_pred_inputvalue (self, value, parameter):

        # print("update ",parameter," to ",value)

        # manufacturbility = refresh.manufacturbility(force, velocity, blankthickness, temperature)
        # refresh.field(value, parameter)

        prediction.receive_inputvalue (value, parameter, self)


    @Slot(str)
    def changemodelType (self, str):
        model_control.load(str)


    pred_close_workspace = Signal()
    @Slot()
    def pred_close_workspace_request (self):
        self.pred_close_workspace.emit()


    # bestruntable = Signal(QAbstractTableModel)
    # @Slot()
    # def updateBestruntable (self):
    #     print("button pressed")
    #     tablemodel = refresh.bestruntable()

    #     self.bestruntable.emit(tablemodel)






    @Slot(result=list)
    def load_opti_varopts (self):
        return optimisation.load_varopts()
    

    @Slot(str, str, result=bool)
    def enable_opti_vars (self, var, process):
        return optimisation.enable_vars(var, process)


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

    
    @Slot(str, result=float)
    def get_optivar_lowerbound (self, var):
        return optimisation.get_var_property(var, "lower bound")

    
    @Slot(str, result=float)
    def get_optivar_upperbound (self, var):
        return optimisation.get_var_property(var, "upper bound")

    
    @Slot(str, result=float)
    def get_optivar_decimals (self, var):
        return optimisation.get_var_property(var, "decimals")
    

    @Slot(str, result=list)
    def get_optivar_units (self, str):
        return optimisation.get_var_property(str, "units")
    

    opti_var_name_changed = Signal()
    @Slot(int, str, str)
    def change_opti_var_name (self, idx, old, new):
        optimisation.change_name(idx, old, new)
        self.opti_var_name_changed.emit()
    

    @Slot(str, int, int, str)
    def setvarbounds (self, var, lower, upper, unit):
        optimisation.set_bounds(var, lower, upper, unit)
    

    opti_result_updated = Signal(int, int, float)
    @Slot()
    def start_optimisation (self):
        optimisation.start(self)
    

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
    

    @Slot(result=list)
    def get_opti_final_graph (self):
        return optimisation.get_final_graph()


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




    @Slot(str, result=int)
    def get_dev_filecount (self, dir):
        return len(os.listdir(dir[7:]))
    

    @Slot(result=list)
    def get_dev_retrain_lossfunctions (self):
        return ["MSE Loss"]




if __name__ == "__main__":
    app = QApplication(sys.argv)
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
    # qml_file = Path(__file__).resolve().parent / "qml/start_screen.qml"
    engine.load(qml_file)

    main.setProperty("QSGRendererInterface", "OpenGL")
    main.setProperty("OSG_RHI_BACKEND", "opengl")

    QQuickWindow.setGraphicsApi(QSGRendererInterface.OpenGL)
    os.environ["QT_QUICK_BACKEND"] = "software"

    # view = QQuickView()
    # view.setResizeMode(QQuickView.SizeRootObjectToView)
    # qml_file = Path(__file__).parent / "qml/prediction_workspace_3d.qml"
    # view.setSource(QUrl.fromLocalFile(qml_file))

#    if not engine.rootObjects():
#        sys.exit()
    
#    app.exec()
    sys.exit(app.exec())
