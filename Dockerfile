FROM python:3.8-slim-buster
RUN apt update
RUN apt install git -y
RUN git clone https://github.com/Azure-Samples/cosmosdb-python-fastapi.git
WORKDIR /cosmosdb-python-fastapi
COPY . .
EXPOSE 8000
CMD ["uvicorn","main:app"]