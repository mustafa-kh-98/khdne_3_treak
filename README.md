///[Mustafa Khaled : pohne: +963987158414]///

///[Khdne 3 Tareak]///

Project Structure

# Data Layer

The Data layer is responsible for data collection and management within the application. It is
primarily organized into three main folders:

1. DB (Database)
   This folder represents the layer that deals with the local database if needed. It can be used for
   storing and retrieving local data such as configurations or temporary data that doesn't require
   server communication.

2. Remote (Server Communication)
   This folder is focused on fetching data from the server through the Application Programming
   Interface (API). It usually consists of the following components:

Model
Data received from the server is structured within this folder. The Model represents data objects
that mirror the structure of the received data.

Provider
The data provider communicates with the server via the API and retrieves data. It can also transform
the data into a suitable format for use within the application.

Repo (Repository)
This part serves as an interface for communicating with the server and fetching data. The repository
is used to unify the interface between the Data layer and the User Interface (UI) layer.

# User Interface (UI)

This layer is located within the "Modules" directory and contains all user interface components.
Each user interface includes a Controller and View.
Controller: Manages the interaction between the UI and the data by connecting to the appropriate
Repo.
View: Represents the user interface for each module and displays data to the user.

# Core Folder

Contains common application-wide matters, such as functions and basic tools used across all layers.

# Components Folder

Contains frequently reused and commonly shared widgets and components throughout the project.

# Requirements

Flutter 3.10.

# How to Run the Project

1-Download the project files from the GitHub code repository by this command
//**get clone https://gitlab.com/mustafasyr3661/khdne_3_treak.git**//
2-Ensure you have Flutter version 3.10 installed on your system.
3-Run the project using the following commands:
flutter pub get
flutter run
