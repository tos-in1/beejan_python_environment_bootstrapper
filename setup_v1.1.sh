#!/bin/bash

# If commands encounters any error, stop the scripts
set -e

# >>>>>>>>>>>>>>>>>>> Create Project Directory <<<<<<<<<<<<<<<<<<<

DIRECTORY="$(pwd)"

# >>>>>>>>>>>>>>>>>>> Create Log File In Directory <<<<<<<<<<<<<<<<<<

LOG_FILE="$DIRECTORY/logs/setup.log" # this would create a new setup.log

# Defining color variables
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
WHITE="\e[37m"
RESET="\e[0m"

# >>>>>>>>>>>>>>>>>>> Create unified CLI print / log message function <<<<<<<<<<<<<<<<<<

logging_msg() {
        local LEVEL=$1
        local MESSAGE=$2
        local COLOR

        # Selecting colour based on level
        case "$LEVEL" in
                INFO) COLOR=$BLUE;;
                SUCCESS) COLOR=$GREEN;;
                WARNING) COLOR=$YELLOW;;
                ERROR) COLOR=$RED;;
                *) COLOR=$WHITE;;
        esac

        # CLI message
        echo -e "${COLOR}[$LEVEL] $MESSAGE${RESET}"

        # Append message to Log File
        echo "$(date '+%Y-%m-%d %H:%M:%S') [$LEVEL] $MESSAGE" >> "$LOG_FILE"
}

logging_msg INFO "Starting setup process......🔃"


# >>>>>>>>>>>> Get Version  <<<<<<<<<<<<
get_version() {
        # Version path 
        VERSION_FILE="$DIRECTORY/VERSION"

        if [ -f "$VERSION_PATH" ]; then
                VERSION=$(cat "$VERSION_FILE")
        else
                VERSION="unknown"
        fi
}

get_version

logging_msg "INFO" "Starting setup process  (v$VERSION)...🛠️"

# ======================================================================
#                       STARTING STARTUP PROCESS
# ======================================================================


# ==================== CREATE PROJECT FUNCTION ===================

# >>>>>>>>>>>> Create or activate virtual environment  <<<<<<<<<<<<

create_venv() {
        VENV_PATH="$DIRECTORY/.venv"

        if [ -d  $VENV_PATH ]; then
                logging_msg INFO "Virtual environment $VENV_PATH already exists.. Activating..."
                
                # Activating virtual envirinment
                source "$VENV_PATH/bin/activate" 
        else
                MESSAGE="Installing python package...."
                echo -e "${YELLOW}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"

                # Install venv package
                sudo apt install -y python3.12-venv

                # Creating the actual environment
                MESSAGE="Creating venv environment"
                echo -e "${YELLOW}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"

                python3 -m venv "$VENV_PATH"

                MESSAGE="Activating virtual environment ....."
                echo -e "${YELLOW}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"

                # Activate the newly created virtual environment
                source "$VENV_PATH/bin/activate"

                MESSAGE="Virtual environment created and activated"
                echo -e "${GREEN}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"
        fi
}


# >>>>>>>>>>>>>>>>>>> Upgrade or Install pip  <<<<<<<<<<<<<<<<<<<

upgrade_pip() {
        MESSAGE="Upgrading pip to the latest version....."
        echo -e "${YELLOW}$MESSAGE${RESET}"
        logging_msg "$MESSAGE"

        python3 -m pip install --upgrade pip

        MESSAGE="pip was upgraded sucessfully"
        echo -e "${GREEN}$MESSAGE${RESET}"
        logging_msg "$MESSAGE"
}


# >>>>>>>>>>>>>>>>>>>> Create an Empty .env File <<<<<<<<<<<<<<<<<<<<

create_env() {
    ENV_FILE="$DIRECTORY/.env"

    if [ -f "$ENV_FILE" ]; then
        MESSAGE=".env file already exists"
        echo "$MESSAGE"
        logging_msg "$MESSAGE"
    else
        MESSAGE=".env successfully created!"
        echo -e "${GREEN}$MESSAGE${RESET}"
        logging_msg "$MESSAGE"
    fi
}


# >>>>>>>>>>>>>>>>>>> Create README.md File <<<<<<<<<<<<<<<<<<<<

create_readme() {
    README_FILE="$DIRECTORY/README.md"

    if [ -f "$README_FILE" ]; then
        MESSAGE="README.md already exists"
        echo "$MESSAGE"
        logging_msg "$MESSAGE"
    else
        cat <<EOF > "$README_FILE"
# New Python Project

This readme file was automatically generated with setup.sh and all project descrition should be written here.
EOF
        MESSAGE="README.md created successfully!"
        echo -e "${GREEN}$MESSAGE${RESET}"
        logging_msg "$MESSAGE"
    fi
}


# >>>>>>>>>>>>>>>>>>> Create .gitignore File <<<<<<<<<<<<<<<<<<

gitignore() {
        GITIGNORE_FILE="$DIRECTORY/.gitignore"

        # Checking if gitignore exists in the path directory
        if [ -f "$GITIGNORE_FILE" ]; then
                MESSAGE=".gitignore already existed in $GITIGNORE_FILE"
                echo "$MESSAGE"
                logging_msg "$MESSAGE"
        else
                MESSAGE="Creating .gitignore..."
                echo -e "${YELLOW}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"
                cat <<EOF > "$GITIGNORE_FILE"
# Python cache
__pycache__/
*.pyc

# Virtual environment
.venv/

# Environment variable
.env

# package installation list
req_package.txt

EOF

                MESSAGE=".gitignore created successfully!"
                echo -e "${GREEN}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"
        fi
}


# >>>>>>>>>>>>>>>>> Create Required Package List  <<<<<<<<<<<<<<<<<<

req_package() {

        REQ_FILE="$DIRECTORY/req_package.txt"


        if [ -f "$REQ_FILE" ]; then
                MESSAGE="$REQ_FILE already exists..."
                echo -e "$MESSAGE"
                logging_msg "$MESSAGE"
        else
                MESSAGE="Creating $REQ_FILE file"
                echo -e "${YELLOW}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"

                cat <<EOF > "$REQ_FILE"

pandas
numpy>=2.0.0
requests
sqlalchemy
psycopg2-binary
python-dotenv
EOF

                MESSAGE="$REQ_FILE created successfully!"
                echo -e "${GREEN}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"
        fi
}

# >>>>>>>>>>>>>>>>> Create Install Package Function  <<<<<<<<<<<<<<<<<<

install_package() {
        REQ_FILE="$DIRECTORY/req_package.txt"

        if [ -f "$REQ_FILE" ]; then
                MESSAGE="Installing packages from $REQ_FILE...."
                echo -e "${YELLOW}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"

                pip install -r "$REQ_FILE"

                MESSAGE="$REQ_FILE installed successfully!"
                echo "${GREEN}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"
        else
                MESSAGE="$REQ_FILE not found. Skipping, no installation...."
                echo -e "${RED}$MESSAGE${RESET}"
                logging_msg "$MESSAGE"
        fi

}

# >>>>>>>>>>>>>>>>>>>>>>>>>>> RUN THE FUNCTIONS  <<<<<<<<<<<<<<<<<<<<<<<<<

create_venv
upgrade_pip
create_env
create_readme
gitignore
req_package
install_package


MESSAGE="Setup completed successfully!!"
echo -e "${BLUE}$MESSAGE${RESET}✅"
logging_msg "$MESSAGE"




