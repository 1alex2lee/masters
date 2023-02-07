import json, os

from python import die


def predictionmesh (die_dir, edge_dir):
    # print("die directory is " + die_dir)
    # print("edge direcotry is " + edge_dir)

    die.load(die_dir, edge_dir)


def materials ():
    with open('info.json') as f:
        info = json.load(f)

        return [ material["name"] for material in info["materials"] ]


def processes ():
    with open('info.json') as f:
        info = json.load(f)

        return [ process["name"] for process in info["processes"] ]


def modeltypes ():
    with open('info.json') as f:
        info = json.load(f)

        return [ model["name"] for model in info["models"] ]


def model_inputs (model_type):
    with open('info.json') as f:
        info = json.load(f)

        for model in info["models"]:
            if model["name"] == model_type:
                return [ input["name"] for input in model["inputs"] ]
        

def model_input_units (model_type, input_name):
    with open('info.json') as f:
        info = json.load(f)

        for model in info["models"]:
            if model["name"] == model_type:
                for input in model["inputs"]:
                    if input["name"] == input_name:
                        return input["units"]


def model_outputs (model_type):
    with open('info.json') as f:
        info = json.load(f)

        for model in info["models"]:
            if model["name"] == model_type:
                return [ output["name"] for output in model["outputs"] ]
            

    # return [ model["outputs"] if model["name"] for model in info["models"] == model_type  ]


def materialandprocess (material, process):
    if material == "Aluminium":
        print("aluminium selected")
    if material == "Steel":
        print("steel selected")
    if process == "Cold Stamping":
        print("cold stamping selected")


def optivaropts ():
    return (["python","python1","python2"])


def independentvars ():
    return (["sensitivity","independent","variables"])


def dependentvars ():
    return (["sensitivity","dependent","variables"])


