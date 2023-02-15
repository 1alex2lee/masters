
import random, os, threading
import numpy as np
import matplotlib.pyplot as plt

from python import model_control, load


def parameters (model):
    model = str(model).lower()
    print("parameters for ",model," requested")
    

def metrics (model):
    model = str(model).lower()
    print("metrics for ",model," requested")
    

def update (metric):
    metric = str(metric).lower()
    print("result for ",metric," requested")
    return str(round(100*random.random())) + " %"


def receive_inputvalue (value, input, qml):

    if input == "Handle Groove Depth (H)":

        ub = load.process_input_upperbound(input)
        scalar = value/ub

        input = np.load(os.path.join(os.getcwd(),"temp","input.npy"))
        input[2,:,:] = scalar * input[0,:,:]
        input[3,:,:] = scalar * input[1,:,:]
        input[0,:,:] = scalar * input[0,:,:]
        input[1,:,:] = scalar * input[1,:,:]

        pred = model_control.predict(input)

        plt.imshow(pred[0,:,:])
        plt.colorbar()
        plt.savefig(os.path.join(os.getcwd(),"temp","outputfield1.png"))
        plt.savefig(os.path.join(os.getcwd(),"temp","outputfield2.png"))
        plt.clf()
        # plt.imsave(os.path.join(os.getcwd(),"temp","outputfield1.png"),pred[0,:,:])
        # plt.imsave(os.path.join(os.getcwd(),"temp","outputfield2.png"),pred[0,:,:])

        qml.pred_updated.emit()
