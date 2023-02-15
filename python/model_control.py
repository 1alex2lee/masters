import torch, os
import numpy as np

from python.model_architecture import ResUNet

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

num_channel = np.array([4,8,16,32,64,128,256,512])
batch_size = 4

model_dir = ""

model = ResUNet(num_channel,batch_size)
model = model.to(device)

# print("thinning model loaded")
# model.load_state_dict(torch.load(os.path.join('CarDoorModel','Door_ResSEUNet_1408_B4_2000_LRFix0.0002_E6B6D6_Th.pkl'),map_location=device))
# model.eval()


def selectMaterialandProcess (material, process):
    global model_dir

    print(material + " is selected")
    print(process + " is selected")

    model_dir = os.path.join(os.getcwd(), "python", process, material)


def load (model_type):
    global model, model_dir

    model.load_state_dict(torch.load(os.path.join(model_dir, model_type), map_location=device))
    model.eval()

    print(model_type + " model loaded")


def predict(input):

    input = torch.from_numpy(input).float().to(device).unsqueeze(0)

    decoded = model(input)

    return decoded.cpu().detach().numpy().reshape(2,256,384)
