
import random


def parameters (model):
    model = str(model).lower()
    print("parameters for ",model," requested")

    if model == "thinning":
        return ["Thinning","Force (kN)","Velocity (mm/s)","Blank Thickness (mm)","Temperature (°C)"]
    if model == "springback":
        return ["Springback","Force (kN)","Velocity (mm/s)","Blank Thickness (mm)","Temperature (°C)"]
    if model == "strain":
        return ["Strain","Force (kN)","Velocity (mm/s)","Blank Thickness (mm)","Temperature (°C)"]
    

def metrics (model):
    model = str(model).lower()
    print("metrics for ",model," requested")

    if model == "thinning":
        return ["Manufacturbility (%)","Maximum Thinning (%)"]
    if model == "springback":
        return ["Manufacturbility (%)","Maximum Springback (%)"]
    if model == "strain":
        return ["Manufacturbility (%)","Maximum Strain (%)"]
    

def update_result (metric):
    metric = str(metric).lower()
    print("result for ",metric," requested")
    return str(round(100*random.random())) + " %"