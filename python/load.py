
from python import die

def predictionmesh (die_dir, edge_dir):
    print("die directory is " + die_dir)
    print("edge direcotry is " + edge_dir)

    die.load(die_dir, edge_dir)

def materialandprocess (material, process):
    if material == "Aluminium":
        print("aluminium selected")
    if material == "Steel":
        print("steel selected")
    if process == "Cold Stamping":
        print("cold stamping selected")