# mini-project-1
This mini-project demonstrates skills in Linux administration and Git version control. The project contains a BASH script that will validate and store employee shift assignments in accordance with a strict set of team constraints. The solution being containerized using Docker implementing data persistence with volume mounts.


# Shift Scheduler 🗓️

A Bash script-based solution for managing employee shift assignments. This project demonstrates skills in **Linux administration**, **Bash scripting**, **Git version control**, and **Docker containerization** with data persistence.

---

# Features

- **Interactive & Validated Input**: A user-friendly prompt accepts employee details and validates them against predefined shifts and teams.
- **JSON Data Storage**: All valid entries are saved to a `shifts.json` file, providing a structured way to store the schedule.
- **Dynamic Tabular Display**: View the current schedule in a clean, formatted table that automatically adjusts to fit employee names.
- **Enforced Constraints**: The script enforces a strict limit of two employees per shift, per team.
- **Employee Management**: Easily add or remove employees from the schedule.
- **Containerized Solution**: The application is packaged in a lightweight Docker container, ensuring it runs consistently across different environments.
- **Data Persistence**: Docker volume mounts are used to ensure that the `shifts.json` data is saved and persists even after the container is stopped or removed.

---

# Prerequisites

To run this project, you need the following installed on your system:

- **Docker**
- **Git**
- A Linux distribution (like Ubuntu or CentOS) is recommended for best compatibility.

---

# How to Use

The application is designed to run inside a Docker container.

1. **Build the Image:**
    
    ```bash
    docker build . -t mini-project-1
    ```
    
2. **Run a Container:**
    
    ```bash
    docker run -it -v scheduler-vol:/tmp mini-project-1
    ```
    
    This command starts an interactive container and mounts a Docker volume to the `/tmp` directory inside the container, ensuring data persistence.
    
3. **Script Commands:**
    - Enter an **Employee Name**, **Shift** (`morning`, `mid`, `night`), and **Team** (`a1`, `a2`, `a3`, `b1`, `b2`, `b3`) to add a new assignment.
    - Type `print` to view the current shift schedule.
    - Type `remove` to remove an employee. The script will then prompt you for the team, shift, and employee name to remove.
    - Type `exit` to quit the script.

  
### Example Walkthrough

Adding a new employee:

<img width="1068" height="126" alt="image" src="https://github.com/user-attachments/assets/c04669a4-f618-4778-8d3a-02c30c640201" />

Displaying schedule in a table:

<img width="1081" height="187" alt="image (1)" src="https://github.com/user-attachments/assets/b571f19f-3439-4d42-a796-cc6c7f983c09" />

Removing employee assignment:

<img width="1084" height="140" alt="image (2)" src="https://github.com/user-attachments/assets/c5491885-3c3b-4190-8380-5b0a4458ca66" />


