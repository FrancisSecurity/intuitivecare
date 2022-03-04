FROM python:3.9
WORKDIR /app1/
COPY ./app/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY ./app/ /app1/
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "9000"]
