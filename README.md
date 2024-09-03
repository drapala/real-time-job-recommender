# Real-Time Job Recommender

This repository serves as the central hub for the "Multistack Real-Time Job Recommendation Engine," which consists of two microservices: one built with Python and another with Java. Together, these microservices capture user events, generate job recommendations, and process them in real-time using various technologies like Kafka, MySQL, MongoDB, and Presto.

## Architecture Overview

The "Multistack Real-Time Job Recommendation Engine" is designed to offer real-time job recommendations by leveraging multiple microservices that communicate via Apache Kafka. 

- **Python Service**: Captures user events, manages sessions, interacts with MySQL and MongoDB, and publishes job recommendation events to Kafka. [More Details](https://github.com/drapala/job-recommender-py)
  
- **Java Service**: Consumes events from Kafka, performs real-time data analysis using Presto, and manages structured data with MySQL. [More Details](https://github.com/drapala/job-recommendation-engine)

## Technologies Used

### Java Service
- **Spring Boot 3.3.3**
  - `spring-boot-starter-actuator`
  - `spring-boot-starter-web`
  - `spring-kafka`
  - `spring-boot-starter-data-jpa`
  - `spring-boot-starter-validation`
- **Trino JDBC Driver 455** for integration with Presto
- **Apache Kafka** for event streaming
- **MySQL** for relational data storage
- **H2 Database** for in-memory testing
- **Lombok** for reducing boilerplate code
- **JUnit** for testing
- **Gradle** for project management and build automation

### Python Service
- **Flask 2.2.5** for web framework
- **Flask-SQLAlchemy 2.5.1** for ORM integration
- **Flask-Migrate 3.1.0** for database migrations
- **SQLAlchemy 1.4.41** for SQL toolkit
- **PyMySQL 1.0.2** for MySQL connectivity
- **Kafka-Python 2.0.2** for Kafka integration
- **PyMongo 3.13.0** for MongoDB connectivity
- **Cryptography 39.0.1** for security
- **OpenTelemetry** for observability:
  - `opentelemetry-api`
  - `opentelemetry-sdk`
  - `opentelemetry-instrumentation-flask`
  - `opentelemetry-exporter-otlp`
  - `opentelemetry-semantic-conventions`
  - `opentelemetry-instrumentation`
  - `opentelemetry-instrumentation-wsgi`

## Requirements

To run the full system, ensure you have the following:

- **Python 3.8+**
- **Java 17+**
- **Docker** and **Docker Compose**
- **Apache Kafka**
- **MySQL Database**
- **MongoDB**
- **Presto**
- **Gradle**
- **pip** (Python Package Manager)

## Setup Guide

### Step 1: Clone the Repositories

Clone both microservice repositories:

```bash
git clone https://github.com/drapala/job-recommender-py.git
git clone https://github.com/drapala/job-recommendation-engine.git
```

### Step 2: Set Up the Python Service

Follow the setup instructions in the [Python Service README](https://github.com/drapala/job-recommender-py) to configure the environment locally.

### Step 3: Set Up the Java Service

Follow the setup instructions in the [Java Service README](https://github.com/drapala/job-recommendation-engine) to configure the environment locally.

### Step 4: Configure Docker Compose

Create a `docker-compose.yml` file in the root of this repository to orchestrate both services and their dependencies, such as Kafka, MySQL, and MongoDB.

An example of a `docker-compose.yml`:

```yaml
version: '3.8'
services:
  mysql:
    image: mysql:latest
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: job_db
      MYSQL_USER: dev_user
      MYSQL_PASSWORD: dev_password
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql

  mongo:
    image: mongo:latest
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db

  mongo-express:
    image: mongo-express:latest
    environment:
      ME_CONFIG_MONGODB_SERVER: mongo
      ME_CONFIG_MONGODB_PORT: 27017
      ME_CONFIG_BASICAUTH_USERNAME: admin
      ME_CONFIG_BASICAUTH_PASSWORD: password
    ports:
      - "8081:8081"
    depends_on:
      - mongo

  zookeeper:
    image: confluentinc/cp-zookeeper:latest
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000
    ports:
      - "2181:2181"

  kafka:
    image: confluentinc/cp-kafka:latest
    ports:
      - "9092:9092"
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:9092
      KAFKA_LISTENERS: PLAINTEXT://0.0.0.0:9092
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
    depends_on:
      - zookeeper

  python-service:
    build: ./job-recommender-py
    depends_on:
      - mysql
      - mongo
      - kafka
    ports:
      - "5000:5000"

  java-service:
    build: ./job-recommendation-engine
    depends_on:
      - mysql
      - kafka
    ports:
      - "8080:8080"

volumes:
  mysql_data:
  mongo_data:
```

### Step 5: Run the Full System

To run the entire system, execute the following command:

```bash
docker-compose up
```

## Communication Between Services

- **Python Service** publishes job recommendation events to Kafka.
- **Java Service** consumes these events, performs real-time processing, and generates refined job recommendations.

## Testing and Validation

To test the integration:

1. Ensure both services are running.
2. Use the endpoints provided by both microservices to simulate user events and verify that job recommendations are processed correctly.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
