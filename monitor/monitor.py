from logging import exception
import requests
import datetime
import csv
import os.path
import urllib

#------Pega Data e hora e tranforma no formato que gostaria
data =  datetime.datetime.now()
data = data.strftime("%A %d %B %y %I:%M")
data = datetime.datetime.strptime(data, "%A %d %B %y %I:%M")
#-----Fim Data e Hora--------

try:
    #---Verifica a latencia da conexao e captura o status code
    response = requests.get('http://www.terra.com.br/') 
    status = response.status_code
    lat = response.elapsed.total_seconds()
except:
    if(os.path.isfile('dados1.csv')):
        with open('dados1.csv', mode='a', newline='') as saida:
            escrever = csv.writer(saida)
            escrever.writerow(["Erro ao Conectar no Servidor", data])
            exit()
    else:
        with open('dados1.csv', mode='a', newline='') as saida:
            escrever = csv.writer(saida)
            escrever.writerow(["DATA_REGISTRO", "APPLICACAO", "STATUS", "LATENCIA", "DATA_COLETA"])
            escrever.writerow(["Erro ao Conectar no Servidor", data])    
            exit()


#----Grava os dados no arquivo CSV, coloquei um para verificar se o arquivo existe, caso ele não exista 
# será criado com o cabeçalho, nas próximas será apenas feito o append dos dados

if(os.path.isfile('dados1.csv')):
    with open('dados1.csv', mode='a', newline='') as saida:
        escrever = csv.writer(saida)
        escrever.writerow([data,response.url ,status, lat,data])
else:
    with open('dados1.csv', mode='a', newline='') as saida:
        escrever = csv.writer(saida)
        escrever.writerow(["DATA_REGISTRO", "APPLICACAO", "STATUS", "LATENCIA", "DATA_COLETA"])
        escrever.writerow([data,response.url ,status, lat,data]) 




