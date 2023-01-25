import numpy as np
import os
import re #for splitting strings
import meshio
from scipy.interpolate import griddata

#paths
dieImagesPath = ""
punchImagesPath = ""
Edges_dir = ""

### HELPER FUNCTIONS ###

# sort files in alphanumeric order
def sortFiles(dirName, extention):  # this is really important to get the order of the files correct for the dataset
    numbers = []
    for file in os.listdir(dirName):
        if extention not in file:  # only consider '.pc' files wihtin this folder
            continue

        baseName, sampleNo, item, fileExt = file.replace('.', '_').split("_")
        numbers.append(int(sampleNo))

    numbers.sort()

    sortedNames = []
    for i, number in enumerate(numbers):
        currentName = baseName + "_" + str(number) + "_" + item + "." + fileExt
        sortedNames.append(currentName)
    return sortedNames


def sortedgeFiles(dirName, extention):  # this is really important to get the order of the files correct for the dataset
    numbers = []
    for file in os.listdir(dirName):
        if extention not in file:  # only consider '.pc' files wihtin this folder
            continue

        baseName, sampleNo, item, fileExt = file.replace('.', '_').split("_")
        numbers.append(int(sampleNo))

    numbers.sort()

    sortedNames = []
    for i, number in enumerate(numbers):
        currentName = baseName + "_" + str(number) + "_" + item + "." + fileExt
        sortedNames.append(currentName)
    return sortedNames

### Whether a point is in a polygon ###

def is_in_poly(p, poly):
    """
    :param p: [x, y]
    :param poly: [[[], []], [[], []], [[], []], [[], []], ...]
    :return:
    """
    px, py = p
    is_in = False
    for i, cweld in enumerate(poly):

        x1, y1 = cweld[0]
        x2, y2 = cweld[1]
        if (x1 == px and y1 == py) or (x2 == px and y2 == py):  # if point is on vertex
            is_in = True
            break
        if min(y1, y2) < py <= max(y1, y2):  # find horizontal edges of polygon
            x = x1 + (py - y1) * (x2 - x1) / (y2 - y1)
            if x == px:  # if point is on edge
                is_in = True
                break
            elif x > px:  # if point is on left-side of line
                is_in = not is_in
    return is_in

def postprocess(i, file, edgefile, baseLength_W, baseLength_H, imageResolution_W, imageResolution_H):
    print("-> DIE START", file, "\n")

    # load the mesh
    fileName = dieImagesPath + file
    mesh = meshio.read(filename=fileName)

    # offset and flip
    mesh.points[:, 2] = mesh.points[:, 2] - mesh.points[:, 2].max()  # offset ensures z=0 base
    mesh.points[:, 2] = -1 * mesh.points[:, 2]

    # interpolate to grid
    X = np.linspace(0, baseLength_H, imageResolution_H)
    Y = np.linspace(0, baseLength_W, imageResolution_W)
    gridX, gridY = np.meshgrid(X, Y)
    dieImage = np.ones((imageResolution_W, imageResolution_H))

    interpolatedImage = griddata(mesh.points[:, 0:2], mesh.points[:, 2], (gridX, gridY), method='linear', fill_value=0)
    dieImage[:, :] = interpolatedImage

    meshFilePath = Edges_dir + edgefile

    nodalIDs = []
    nodalCoordinates = []
    elementIDs = []
    elementConnectivity = []
    nodeConnectivity_elementIndicies = []

    with open(meshFilePath) as f:  # open file j

        # Iterate through lines
        for line in f.readlines():

            # Find the keyword
            nodalIndex = line.find('GRID')
            elementIndex = line.find('CROD')

            # If the keyword is at the beginning of the line (index == 0)
            if nodalIndex == 0:
                nodalIDs.append(int(line[4:16]))

            if elementIndex == 0:
                temp = line.replace('\n', ' ')  # replace \n with white space
                temp = re.split(' +', temp)  # split the string at all occurances of white space
                elementIDs.append(int(temp[1]))  # store into element ID list
                temp = re.split(' +', line)  # split the string at all occurances of white space
                temp = temp[2:]  # only keep columns containing strings of element ID and connectivity
                temp = np.int_(temp)  # convert the strings into ints
                elementConnectivity.append(temp)  # store connectivity in a list

    nodalCoordinates = meshio.read(meshFilePath).points

    # convert into np arrays
    nodalIDs = np.array(nodalIDs)

    # elementConnectivity was populated with nodal IDs, here we populate elementConnectivity_nodalIndex with corresponding nodel index values
    # Note, this np.searchsorted() function works only if nodalIDs is sorted, which it will be every time, since the FE solver outputs node IDs in sorted order
    # If it is not sorted, please assign a valid value to the augment 'sort'
    poly = []
    for e in range(len(elementConnectivity)):
        ID = np.searchsorted(nodalIDs, elementConnectivity[e])
        poly.append([[nodalCoordinates[ID[0], 0], nodalCoordinates[ID[0], 1]],
                     [nodalCoordinates[ID[1], 0], nodalCoordinates[ID[1], 1]]])

    for p in range(len(X)):
        for q in range(len(Y)):
            if not is_in_poly([X[p], Y[q]], poly):
                dieImage[q, p] = 0

    print("-> DIE DONE", file, "\n")

    return i, dieImage


def load(die_dir, edge_dir):

    # sortedFiles = sortFiles(dieImagesPath, '.nas')
    # edgeFiles = sortedgeFiles(Edges_dir, 'Die.nas')

    sortedFiles = die_dir[5:]
    edgeFiles = edge_dir[5:]

    # fixed parameters
    # imageResolution_H = [384 for i in range(len(sortedFiles))]
    # imageResolution_W = [256 for i in range(len(sortedFiles))]
    # baseLength_H = [1090 for i in range(len(sortedFiles))]  # in mm
    # baseLength_W = [-660 for i in range(len(sortedFiles))]  # in mm

    imageResolution_H = 384
    imageResolution_W = 256
    baseLength_H = 1090  # in mm
    baseLength_W = -660  # in mm

    # obtain die images
    dieImages = np.zeros((imageResolution_W, imageResolution_H))

    # with concurrent.futures.ProcessPoolExecutor(max_workers = 10) as executor:
    #     for i, dieImage in executor.map(postprocess, 1, sortedFiles, edgeFiles, baseLength_W, baseLength_H, imageResolution_W, imageResolution_H):
    #         dieImages[i, :, :] = dieImage

    i, dieImage = postprocess (0, sortedFiles, edgeFiles, baseLength_W, baseLength_H, imageResolution_W, imageResolution_H)

    np.save(os.path.join("temp","imported_die.npy"), dieImage)
