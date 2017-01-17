# Bartender

Bartender with Raspberry Pi.

## Requirements
* **Software**
 * tomcat
 * maven
 * jdk 1.8
 * MySQL database
 * Pi4j (http://pi4j.com/)
* **Hardware**
 * Raspberry Pi
 * Self-Priming Pumps

## Installation
1. Install the software on the Raspberry Pi.
2. Connect the pumps to the Raspberry Pi. Find the pin nummbering on the pi4j website and set them in the database.

# Backend
The backend is written in Java. Use _mvn package_ to create the war file for tomcat.

## Rest
**Shots:** _/rest/interface/v1/shots/_

**Cocktails:** _/rest/interface/v1/cocktails/_

**Spirits:** _/rest/interface/v1/spirits/_

# Frontend
The frontend is written with angularjs. **Coming soon.**
