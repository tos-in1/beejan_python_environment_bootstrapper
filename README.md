# Beejan Python Environment Bootstrapper
### Overview
Imagine you’ve just joined a data engineering team at a company that maintains multiple Python-based data pipelines and engineering projects. Excited to get started, you quickly realize that before you can even write a single line of code, you need to set up your development environment.

Hours spent creating virtual environments, upgrading pip, configuring .gitignore files, and installing essential Python packages tasks that feel repetitive and tedious for every new project. For a new engineer, this setup process can be frustrating and time-consuming.

![Setup Script Demo](https://media1.tenor.com/m/GII8hx-nKnAAAAAC/ron-swanson-parks-and-recreation.gif)

#### Heck! This script just makes your life easier.

The Beejan Python Environment Bootstrapper is a Bash script that automates all these initial steps. With a single command, it creates or activates a Python virtual environment, upgrades pip, sets up a .gitignore file, installs essential Python packages, and even writes a log of all actions.

No more repetitive setup headaches!!

This script ensures that every new project environment is ready in minutes, so engineers can focus on what truly matters: building and maintaining data pipelines.

![Setup Script Demo](https://media1.tenor.com/m/ceWB2MGXunEAAAAC/gameboyluke-celebrate.gif)

### How To Execute The Script ([setup.sh](./setup.sh))
1. Clone the repository to your local machine:

           git clone https://github.com/tos-in1/beejan_python_environment_bootstrapper.git
   Navigate to the directory below:

           cd beejan_python_environment_bootstrapper
   
   Move the `setup.sh` to your desired directory

2. Make `setup.sh` an executable:

           chmod +x setup.sh

3. Run the setup script:

        . ./setup.sh

### Outputs Excerpts

        testing@DESKTOP-HOJ987O:~$ . ./setup.sh
        Starting setup process......🔃
        Installing python package....
        Reading package lists... Done
        Building dependency tree... Done
        Reading state information... Done
        python3.12-venv is already the newest version (3.12.3-1ubuntu0.9).
        0 upgraded, 0 newly installed, 0 to remove and 108 not upgraded.
        Creating venv environment
        Activating virtual environment .....
        Virtual environment created and activated
        Upgrading pip to the latest version.....
        Requirement already satisfied: pip in ./.venv/lib/python3.12/site-packages (24.0)
        Collecting pip
          Using cached pip-25.3-py3-none-any.whl.metadata (4.7 kB)
        Using cached pip-25.3-py3-none-any.whl (1.8 MB)
        Installing collected packages: pip
          Attempting uninstall: pip
            Found existing installation: pip 24.0
            Uninstalling pip-24.0:
              Successfully uninstalled pip-24.0
        Successfully installed pip-25.3
        pip was upgraded sucessfully
        .env successfully created!
        README.md created successfully!
        Creating .gitignore...
        .gitignore created successfully!
        Creating /home/testing/req_package.txt file
        /home/testing/req_package.txt created successfully!
        Installing packages from /home/testing/req_package.txt....
        Collecting pandas (from -r /home/testing/req_package.txt (line 2))
          Using cached pandas-2.3.3-cp312-cp312-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl.metadata (91 kB)
        Collecting numpy>=2.0.0 (from -r /home/testing/req_package.txt (line 3))
          Using cached numpy-2.3.5-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl.metadata (62 kB)
        Collecting requests (from -r /home/testing/req_package.txt (line 4))
          Using cached requests-2.32.5-py3-none-any.whl.metadata (4.9 kB)
        Collecting sqlalchemy (from -r /home/testing/req_package.txt (line 5))
          Using cached sqlalchemy-2.0.44-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (9.5 kB)

<img width="1245" height="602" alt="Image" src="https://github.com/user-attachments/assets/d1dfcbe4-02ae-4e66-9cef-c2bdab9e5fbc" />

### Scenerio Test

#### Case 1: All Files Exist
   Setup: `.venv`, `.gitignore`, `.env`, `req_package.txt` all exist.
   
        (.venv) testing@DESKTOP-HOJ987O:~$ . ./setup.sh
        Starting setup process......🔃
        Virtual environment /home/testing/.venv already exists.. Activating...
        Upgrading pip to the latest version.....
        Requirement already satisfied: pip in ./.venv/lib/python3.12/site-packages (25.3)
        pip was upgraded sucessfully
        .env successfully created!
        README.md already exists
        .gitignore already existed in /home/testing/.gitignore
        /home/testing/req_package.txt already exists...
        Installing packages from /home/testing/req_package.txt....
        Requirement already satisfied: pandas in ./.venv/lib/python3.12/site-packages (from -r /home/testing/req_package.txt (line 2)) (2.3.3)
        Requirement already satisfied: numpy>=2.0.0 in ./.venv/lib/python3.12/site-packages (from -r /home/testing/req_package.txt (line 3)) (2.3.5)
        Requirement already satisfied: requests in ./.venv/lib/python3.12/site-packages (from -r /home/testing/req_package.txt (line 4)) (2.32.5)
        Requirement already satisfied: sqlalchemy in ./.venv/lib/python3.12/site-packages (from -r /home/testing/req_package.txt (line 5)) (2.0.44)
        Requirement already satisfied: psycopg2-binary in ./.venv/lib/python3.12/site-packages (from -r /home/testing/req_package.txt (line 6)) (2.9.11)
        Requirement already satisfied: python-dotenv in ./.venv/lib/python3.12/site-packages (from -r /home/testing/req_package.txt (line 7)) (1.2.1)
        Requirement already satisfied: python-dateutil>=2.8.2 in ./.venv/lib/python3.12/site-packages (from pandas->-r /home/testing/req_package.txt (line 2)) (2.9.0.post0)
        Requirement already satisfied: pytz>=2020.1 in ./.venv/lib/python3.12/site-packages (from pandas->-r /home/testing/req_package.txt (line 2)) (2025.2)
        Requirement already satisfied: tzdata>=2022.7 in ./.venv/lib/python3.12/site-packages (from pandas->-r /home/testing/req_package.txt (line 2)) (2025.2)
        Requirement already satisfied: charset_normalizer<4,>=2 in ./.venv/lib/python3.12/site-packages (from requests->-r /home/testing/req_package.txt (line 4)) (3.4.4)
        Requirement already satisfied: idna<4,>=2.5 in ./.venv/lib/python3.12/site-packages (from requests->-r /home/testing/req_package.txt (line 4)) (3.11)
        Requirement already satisfied: urllib3<3,>=1.21.1 in ./.venv/lib/python3.12/site-packages (from requests->-r /home/testing/req_package.txt (line 4)) (2.5.0)
        Requirement already satisfied: certifi>=2017.4.17 in ./.venv/lib/python3.12/site-packages (from requests->-r /home/testing/req_package.txt (line 4)) (2025.11.12)
        Requirement already satisfied: greenlet>=1 in ./.venv/lib/python3.12/site-packages (from sqlalchemy->-r /home/testing/req_package.txt (line 5)) (3.2.4)
        Requirement already satisfied: typing-extensions>=4.6.0 in ./.venv/lib/python3.12/site-packages (from sqlalchemy->-r /home/testing/req_package.txt (line 5)) (4.15.0)
        Requirement already satisfied: six>=1.5 in ./.venv/lib/python3.12/site-packages (from python-dateutil>=2.8.2->pandas->-r /home/testing/req_package.txt (line 2)) (1.17.0)
        \e[32m/home/testing/req_package.txt installed successfully!\e[0m
        Setup completed successfully!!✅

   <img width="1372" height="1078" alt="Image" src="https://github.com/user-attachments/assets/e0fb3dc2-1cd2-4b2b-bfba-58e4d4ed9006" />

#### Case 2: No `.venv` and no `.gitignore`

<img width="1297" height="712" alt="Image" src="https://github.com/user-attachments/assets/aaf5318b-68de-4a9f-bcf8-116113286476" />

<img width="1301" height="770" alt="Image" src="https://github.com/user-attachments/assets/45d65d48-2fe2-4ef2-aa54-60fed2937c95" />

### Challenges Faced and Lessons Learnt

#### 1. Making the Script Reusable for Any Project

Originally, the script assumed a fixed project folder name, which made it unusable outside one specific project.

<img width="1106" height="587" alt="Image" src="https://github.com/user-attachments/assets/339aa857-348c-44a6-894a-1fa28f27de8e" />

To solve this, I updated the script to use:

           DIRECTORY="$(pwd)"

No more hard-coded paths. I removed the old directory-creation function and now everything adapts to whatever folder the user is in.

#### Lesson learnt:
Good automation scripts should be portable and flexible, not tied to a single setup or file structure.


#### 2. Environment Refused to Activate After running setup.sh

After running:

           ./setup.sh

the virtual environment didn’t activate as expected.

<img width="1138" height="601" alt="Image" src="https://github.com/user-attachments/assets/9d13dc24-1b1e-44e4-b334-6ef8fc378efd" />

I have to run setup.sh using:

           . ./setup.sh


before it worked properly.

#### Lesson learnt:
Scripts executed with `./file.sh` run in a subshell, so environment changes don’t carry over

#### 3. Terminal Colors Not Displaying Correctly

One surprising challenge I faced was that none of the colored output messages were showing in my terminal. At first, I thought my Ubuntu terminal didn’t support ANSI color codes, but the real problem was a simple syntax mistake.

<img width="1102" height="618" alt="Image" src="https://github.com/user-attachments/assets/6f43cc80-9df3-4c1c-adb5-471404543a37" />

I wrote my color variables like this:

           ($COLOUR)
           
Instead of the correct Bash variable format:

           ${COLOUR}

#### Lesson Learnt
Bash is very strict with variable syntax, especially inside echo statements.
Using ${VAR} instead of $VAR ensures consistent behavior, avoids parsing errors, and makes color formatting work across different terminals.


### Conclusion 
This project started as a simple script, but it evolved into a fully reusable Python environment bootstrapper that removes the repetitive pain of manual setup. From virtual environment management to pip upgrades, package installation, colorful feedback, and logging — everything is now automated with a single command.

There could be plenty of room for future improvements, but it already achieves its main goal: 

#### Making project setup fast, consistent, and effortless!



