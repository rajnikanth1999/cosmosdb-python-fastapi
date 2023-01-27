FROM python:3.8-slim-buster
RUN apt update
RUN apt install git -y
RUN git clone https://github.com/Azure-Samples/cosmosdb-python-fastapi.git
RUN pip install fastapi && pip install fastapi uvicorn && pip install python-dotenv && pip install aiohttp && pip install azure-cosmos && pip install uvicorn
WORKDIR /cosmosdb-python-fastapi/cosmosdb-with-fastapi/
COPY . .
EXPOSE 8000
CMD ["uvicorn","main:app"]