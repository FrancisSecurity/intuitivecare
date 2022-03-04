from urllib import response
from fastapi import FastAPI, HTTPException, Request, BackgroundTasks
import json
from http import HTTPStatus
from fastapi.responses import HTMLResponse

app = FastAPI()

title="Status Primeiro APP",
description="description",
version="0.0.1",
dados={
    "name": "Francismar Camargo",
    "Linkedin": "https://www.linkedin.com/in/francismar-camargo-682625183/",
    "email": "fcamargo.fr@gmail.com",
    }


@app.get("/app1/status/", response_class=HTMLResponse)
def read_item(request: Request):
    client_host = request.client.host
    return """ 
    <html>
        <head>
            <title>Status Servico</title>
        </head>
        <body style="background-color:powderblue;">
            <h2>"Status" ': {}'</h2>
        </body>
    </html>     
     """.format(json.JSONEncoder().encode({"Status":HTTPStatus.OK, "IP": client_host, "Nome":title }))




@app.get("/app1/contato/", response_class=HTMLResponse)
async def read_items():
    return """
    <html>
        <head>
            <title>Contatos here</title>
        </head>
        <body style="background-color:green;">
            <h2>"Contatos" ': {}'</h2>
        </body>
    </html>
    """.format(dados)
