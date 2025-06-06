import json


def Http_Server_Input(prompt, default="localhost:80"):
    data = input(f"{prompt} ({default})>> ").strip()

    if data != default and data != '':
        Ip, Port = data.split(':')
    else:
        Ip, Port = default.split(':')

    Http_Server = {"Ip": Ip, "Port": Port}

    with open("server_info.json", "w") as json_file:
        json.dump(Http_Server, json_file)

def Http_Server_Output():
    with open("server_info.json", "r") as json_file:
        loaded_data = json.load(json_file)
    
    return loaded_data