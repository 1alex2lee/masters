
import threading, time, random, os
import pandas as pd
import numpy as np

from PySide6.QtCore import QAbstractTableModel, QModelIndex, Qt, Property, Slot

from python import model_control

all_vars = ["Force","Velocity","Blank Thickness","Temperature"]
picked_vars = ["picked1","picked2"]
units_library = {"force":"kN","velocity":'mm/s',"blank thickness":"mm","temperature":"°C"}
units = []
bounds = {}
options = []
progress = 0
runsno = 0
best_output = 0
all_runs = {}
bestrun = []
stop_requested = False


def load_optivars ():
    global all_vars

    return all_vars


def pick_option (option):
    global picked_vars

    option = str(option).lower()
    picked_vars.append(option)
    print(option + " picked")


def unpick_option (option):
    global picked_vars

    option = str(option).lower()
    if option in picked_vars:
        picked_vars.remove(option)
        print(option + " unpicked")


def set_options (material, process, model, goal, aim, setto, search, runsno):
    global options

    options = [goal.lower(), aim.lower(), setto, search, runsno]
    print("options set: ",material, process, model, goal, aim, setto, search, runsno)

    model_control.selectMaterialandProcess(material, process)
    model_control.load(model)


def picked_optivars ():
    global picked_vars

    return picked_vars


def get_units (var, idx):
    global units, units_library

    var = str(var).lower()
    print("units requested for",var)
    if var in units_library:
        units.append([units_library[var]])
        return units
    else:
        units.append([""])
        return units


def set_bounds (var, lower, upper, unit):
    global bounds

    print(var, lower, upper, unit)
    bounds[var] = [lower, upper, unit]


def start ():
    global bounds, options

    threading.Thread(target=optimise, args=(bounds, options)).start()


def stop ():
    global stop_requested

    stop_requested = True


def optimise (bounds, options):
    global progress, runsno, picked_vars, bestrun, best_output, all_runs, stop_requested

    print("optimisation started")
    goal, aim, setto, search, runsno = options[0], options[1], options[2], options[3], options[4]

    goal_column = goal+"_"+aim+"_"+str(setto)

    for var in picked_vars:
        all_runs[var] = list()

    all_runs[goal_column] = list()

    while progress < runsno:

        if stop_requested:
            print("optimisation stopped")
            break

        progress += 1
        output = random.random()

        for var in picked_vars:
           all_runs[var].append(random.randint(bounds[var][0],bounds[var][1]))
        #    var_list = all_runs[var]
        #    var_list.append(random.randint(bounds[var][0],bounds[var][1]))
        #    all_runs[var] = var_list

        goal_list = all_runs[goal_column]
        goal_list.append(output)
        all_runs[goal_column] = goal_list

        print(all_runs)

        if output > best_output:
            bestrun = []
            best_output = output

            for var in all_runs:
                bestrun.append([var, all_runs[var][-1]])

        time.sleep(0.11)

    all_runs_df = pd.DataFrame(all_runs)
    all_runs_df.to_csv(os.path.join("temp","optimisation_result.csv"))


def get_progress ():
    global progress, runsno
    
    # print(progress," out of ",runsno)
    return [progress, runsno]


def getbestrun ():
    global picked_vars, bestrun

    return bestrun


def getbestrun_final ():
    all_runs = pd.read_csv(os.path.join("temp","optimisation_result.csv"))
    aim = str(all_runs.columns[-1]).split('_')[-2]
    setto = int(str(all_runs.columns[-1]).split('_')[-1])

    if aim == "minimise":
        idx = all_runs[all_runs.columns[-1]].idxmin()
    if aim == "maximise":
        idx = all_runs[all_runs.columns[-1]].idxmax()
    if aim == "setto":
        idx = all_runs.sub(setto).abs().idxmin()
   
    best_run = []

    for i, column in enumerate(all_runs.columns):

        if i == 0:
            best_run.append(["Run #", float(all_runs[column][idx])])

        elif i == len(all_runs.columns)-1:
            this_aim = str(column).split('_')[-2]

            if this_aim != "setto":
                best_run.append(["_".join(str(column).split('_')[:-1]), float(all_runs[column][idx])])

        else:
            best_run.append([column, float(all_runs[column][idx])])

    return best_run


def get_final_vars ():
    all_runs = pd.read_csv(os.path.join("temp","optimisation_result.csv"))
    vars = ["Run #"]

    for i, column in enumerate(all_runs.columns[1:]):

        if i == len(all_runs.columns)-1:
            this_aim = str(column).split('_')[-2]

            if this_aim != "setto":
                vars.append("_".join(str(column).split('_')[:-1]))

        else:
            vars.append(column)

    return vars



class BestRunTable(QAbstractTableModel):
    DtypeRole = Qt.UserRole + 1000
    ValueRole = Qt.UserRole + 1001

    def __init__(self, df=pd.DataFrame(), parent=None):
        super(BestRunTable, self).__init__(parent)
        df = df.rename(columns={"Unnamed: 0": "Run #"})
        self._dataframe = df.round(decimals=2)

    def setDataFrame(self, dataframe):
        self.beginResetModel()
        self._dataframe = dataframe.copy()
        self.endResetModel()

    def dataFrame(self):
        return self._dataframe

    dataFrame = Property(pd.DataFrame, fget=dataFrame, fset=setDataFrame)

    def rowCount(self, parent=QModelIndex()):
        if parent.isValid():
            return 0
        return len(self._dataframe.index)

    def columnCount(self, parent=QModelIndex()):
        if parent.isValid():
            return 0
        return self._dataframe.columns.size

    def data(self, index, role=Qt.DisplayRole):
        if not index.isValid() or not (
            0 <= index.row() < self.rowCount()
            and 0 <= index.column() < self.columnCount()
        ):
            return
        row = self._dataframe.index[index.row()]
        col = self._dataframe.columns[index.column()]

        if row == 0:
            val = col
        else:
            val = self._dataframe.iloc[row-1][col]
        if role == Qt.DisplayRole:
            return str(val)

    def sort(self, var):
        return "sort by "+var
        
        