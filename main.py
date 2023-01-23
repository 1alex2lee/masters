# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtCore import QAbstractTableModel

from python import refresh, model_control, load

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    update = Signal(float)

    @Slot(float, float, float, float)
    def updateParameters (self, force, velocity, blankthickness, temperature):

        manufacturbility = refresh.manufacturbility(force, velocity, blankthickness, temperature)
        refresh.thinningField(force, velocity, blankthickness, temperature)

        self.update.emit(manufacturbility)

    @Slot(str)
    def changeResultType (self, str):
        model_control.load(str)

    bestruntable = Signal(QAbstractTableModel)

    @Slot()
    def updateBestruntable (self):
        print("button pressed")
        tablemodel = refresh.bestruntable()

        self.bestruntable.emit(tablemodel)

    @Slot(str, str)
    def loadPredictionMesh (self, die, edge):
        load.predictionmesh(die, edge)


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
