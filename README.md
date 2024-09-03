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

### Step 1: Clone the Repositories and Run Setup

Download this repository and run the appropriate setup script for your operating system.

- **Linux/Mac:**

  Open a terminal, navigate to the repository folder, and run:

  ```bash
  chmod +x setup.sh
  ./setup.sh
  ```

- **Windows:**

  Open PowerShell as Administrator, navigate to the repository folder, and run:

  ```powershell
  ./setup.ps1
  ```

### Step 2: Access the Application

Once the setup script completes, the services should be running, and you can access the applications via their respective endpoints.

## Communication Between Services

- **Python Service** publishes job recommendation events to Kafka.
- **Java Service** consumes these events, performs real-time processing, and generates refined job recommendations.

## Testing and Validation

To test the integration:

1. Ensure both services are running.
2. Use the endpoints provided by both microservices to simulate user events and verify that job recommendations are processed correctly.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
